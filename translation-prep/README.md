# 翻译准备区

本目录对应仓库外层 `PASSES.md` 的第 2 步，当前停在人工确认点，不包含整书翻译结果。

- `extract-terms.ts`：扫描 `book.tex` 实际包含的七个正文分部，抽取 `\definend{}`、高频 `\index{}` 候选，并匹配现有项目术语表中的人名。
- `term-candidates.json`：广撒网的可追溯候选，每项带首次出现文件与行号；供检查抽取是否遗漏或误收。
- `build-glossary.ts`：把正式定义、人工筛选的补充索引词和人名汇成术语表草稿。
- `toc-glossary.json`：待人工确认的术语表草稿。
- `toc-translate-prompt-cot.md`：待人工填写四步示例的翻译 prompt。

重新生成：

```sh
bun run translation-prep/extract-terms.ts
bun run translation-prep/build-glossary.ts
```

确认术语表并填完 prompt 之前，不在 `napkin-translate/projects/` 建立本书项目，也不启动翻译模型。
