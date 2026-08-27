#!/usr/bin/env bun

import { readdir, readFile, writeFile } from "node:fs/promises";
import { basename, extname, join, relative, resolve } from "node:path";

type GlossaryEntry = { en: string; zh: string; note?: string };
type Occurrence = { file: string; line: number; raw: string };

const repoRoot = resolve(import.meta.dir, "../..");
const sourceRoot = join(repoRoot, "toc-20260824-en", "src");
const outputRoot = import.meta.dir;
const glossaryRoot = join(repoRoot, "napkin-translate", "projects");
const bookParts = ["preface", "prologue", "background", "languages", "automata", "complexity", "appendix"];

async function walk(dir: string): Promise<string[]> {
  const entries = await readdir(dir, { withFileTypes: true });
  const nested = await Promise.all(entries.map(async (entry) => {
    const path = join(dir, entry.name);
    return entry.isDirectory() ? walk(path) : [path];
  }));
  return nested.flat();
}

function stripComments(text: string): string {
  return text.split("\n").map((line) => {
    for (let i = 0; i < line.length; i++) {
      if (line[i] !== "%") continue;
      let slashes = 0;
      for (let j = i - 1; j >= 0 && line[j] === "\\"; j--) slashes++;
      if (slashes % 2 === 0) return line.slice(0, i);
    }
    return line;
  }).join("\n");
}

function macroArguments(text: string, macro: string): Array<{ raw: string; offset: number }> {
  const found: Array<{ raw: string; offset: number }> = [];
  const needle = `\\${macro}`;
  let cursor = 0;
  while ((cursor = text.indexOf(needle, cursor)) >= 0) {
    const offset = cursor;
    cursor += needle.length;
    while (/\s/.test(text[cursor] ?? "")) cursor++;
    if (text[cursor] !== "{") continue;
    const start = ++cursor;
    let depth = 1;
    while (cursor < text.length && depth > 0) {
      if (text[cursor] === "{" && text[cursor - 1] !== "\\") depth++;
      if (text[cursor] === "}" && text[cursor - 1] !== "\\") depth--;
      cursor++;
    }
    if (depth === 0) found.push({ raw: text.slice(start, cursor - 1).replace(/\s+/g, " ").trim(), offset });
  }
  return found;
}

function lineAt(text: string, offset: number): number {
  return text.slice(0, offset).split("\n").length;
}

function keyOf(term: string): string {
  return term
    .replace(/~+/g, " ")
    .replace(/\\smash\s*\{([^{}]*)\}/g, "$1")
    .replace(/\\(?:textsc|textit|textbf|mathrm|operatorname|probname)\s*\{([^{}]*)\}/g, "$1")
    .replace(/\$[^$]*\$/g, " ")
    .replace(/\\[a-zA-Z@]+/g, " ")
    .replace(/[{}()[\],.;:]/g, " ")
    .replace(/\s+/g, " ")
    .trim()
    .toLocaleLowerCase("en-US");
}

function glossaryEntries(value: unknown, section = ""): Array<GlossaryEntry & { section: string }> {
  if (Array.isArray(value)) return value.flatMap((item) => glossaryEntries(item, section));
  if (!value || typeof value !== "object") return [];
  const object = value as Record<string, unknown>;
  const own = typeof object.en === "string" && typeof object.zh === "string"
    ? [{ en: object.en, zh: object.zh, note: typeof object.note === "string" ? object.note : undefined, section }]
    : [];
  return own.concat(Object.entries(object).flatMap(([key, item]) =>
    key.startsWith("_") ? [] : glossaryEntries(item, section ? `${section}.${key}` : key)));
}

const texFiles = (await Promise.all(bookParts.map(async (part) =>
  (await walk(join(sourceRoot, part))).filter((path) => extname(path) === ".tex")))).flat();

const definitions = new Map<string, { en: string; occurrences: Occurrence[] }>();
const indexCounts = new Map<string, number>();
let searchableSource = "";

for (const file of texFiles) {
  const original = await readFile(file, "utf8");
  const text = stripComments(original);
  searchableSource += `\n${text}`;
  for (const { raw, offset } of macroArguments(text, "definend")) {
    const key = keyOf(raw) || raw.toLocaleLowerCase("en-US");
    const occurrence = { file: relative(sourceRoot, file), line: lineAt(text, offset), raw };
    const current = definitions.get(key);
    if (current) current.occurrences.push(occurrence);
    else definitions.set(key, { en: raw, occurrences: [occurrence] });
  }
  for (const { raw } of macroArguments(text, "index")) {
    const display = raw.split("|")[0].split("@")[0].split("!").at(-1)?.trim() ?? "";
    const key = keyOf(display);
    if (key.length >= 3) indexCounts.set(display, (indexCounts.get(display) ?? 0) + 1);
  }
}

const glossaryFiles = (await walk(glossaryRoot)).filter((path) => basename(path).endsWith("-glossary.json"));
const reused = new Map<string, Array<GlossaryEntry & { source: string; section: string }>>();
const knownNames = new Map<string, Array<GlossaryEntry & { source: string; section: string }>>();

for (const file of glossaryFiles) {
  const entries = glossaryEntries(JSON.parse(await readFile(file, "utf8")));
  for (const entry of entries) {
    const enriched = { ...entry, source: basename(file) };
    const key = keyOf(entry.en);
    if (key) reused.set(key, [...(reused.get(key) ?? []), enriched]);
    if (/person|name|人名/i.test(entry.section) || /人名|音译|原拼写/.test(entry.note ?? "")) {
      knownNames.set(entry.en, [...(knownNames.get(entry.en) ?? []), enriched]);
    }
  }
}

const candidates = [...definitions.values()].sort((a, b) => a.en.localeCompare(b.en, "en")).map((term) => ({
  en: term.en,
  zh: reused.get(keyOf(term.en))?.[0]?.zh ?? "",
  reused_from: reused.get(keyOf(term.en))?.map(({ source, section }) => `${source}:${section}`) ?? [],
  occurrences: term.occurrences,
}));

const personNames = [...knownNames.entries()]
  .filter(([name]) => new RegExp(`(?<![A-Za-z])${name.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")}(?![A-Za-z])`, "i").test(searchableSource))
  .sort(([a], [b]) => a.localeCompare(b, "en"))
  .map(([en, entries]) => ({ en, zh: entries[0].zh, reused_from: entries.map(({ source, section }) => `${source}:${section}`) }));

const supplementalIndex = [...indexCounts.entries()]
  .filter(([en, count]) => count >= 2 && !definitions.has(keyOf(en)))
  .sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0], "en"))
  .map(([en, occurrences]) => ({ en, occurrences }));

await writeFile(join(outputRoot, "term-candidates.json"), JSON.stringify({
  _meta: {
    source_parts: bookParts,
    rule: "正式候选来自去注释后的 \\definend{}；重复索引词另列作补充筛选；slides/question-bank 不参与。",
    definition_candidate_count: candidates.length,
    reused_translation_count: candidates.filter(({ zh }) => zh).length,
    matched_person_name_count: personNames.length,
  },
  definitions: candidates,
  matched_person_names: personNames,
  supplemental_index_candidates: supplementalIndex,
}, null, 2) + "\n");

console.log(`definitions=${candidates.length}`);
console.log(`reused=${candidates.filter(({ zh }) => zh).length}`);
console.log(`matched_names=${personNames.length}`);
console.log(`supplemental_index=${supplementalIndex.length}`);
