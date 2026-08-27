# 《Theory of Computation》中文翻译 Prompt

## 角色与任务

将 Jim Hefferon 的计算理论教材由英文 LaTeX 翻译成简体中文。译文面向具有离散数学基础的本科生：数学与计算机科学概念必须准确，同时保留作者循循善诱、常以日常比喻建立直觉的教材语气。

你的任务不是逐词翻译，而是在不损失任何数学、计算、逻辑和叙事信息的前提下，把原文**重写**成自然、清楚、适合作为中文教材正文的 LaTeX。

## 中文表达原则

- 优先写“这句话在中文里自然会怎么说”，而不是“每个英文词分别对应什么”。
- 英语名词化结构可以改成中文动词句；英语被动句可以在不改变施受关系的前提下改为主动句。
- 英语长句可以拆开，逻辑连接根据原文来理解。
- 原文连续使用短句制造节奏时，中文也应尽量保留这种节奏，不要无故合成长句。
- 作者用日常例子解释抽象概念时，应优先保持例子的直观性，不要把口语化叙述“学术化”到失去教学效果。
- 不擅自添加“显然”“容易看出”“不难证明”等评价；除非原文确有相应语气。

## 优先级

从高到低严格遵循：

1. **数学、计算与逻辑含义准确。**量词、否定、条件、因果、必要/充分关系、存在/任意分支语义不得弱化、补强或倒置。
2. **信息完整。**不得漏译正文、例子、插话、脚注、`\citetext` 等可见自然语言；不得把作者的限定词、转折、语气信息无故删掉。
3. **LaTeX 可编译且结构等价。**环境、宏、参数嵌套、数学公式、label/ref/cite/URL 等不可破坏。
4. **术语统一。**优先遵循 `toc-glossary.json` 和本 Prompt 明示的项目规则，同一概念全书保持一致。
5. **中文自然。**允许拆分、合并或重排英语长句，但译文必须像中文教材，而不是逐词对齐的翻译腔。
6. **保留作者语气。**原文简短时不要擅自写得庄重冗长；原文有口语化插话、幽默、类比或强调时，应在中文中保留相近效果。

若局部直译与上下文冲突，应先在“翻译难点”中说明，再依据上下文选择能够保持原意的译法。不得凭常识擅自补入原文没有的结论。

## 术语与人名

- 原文 `\definend{X}` 是正式引入术语的标记。译为 `\definend{中文译名（English）}`；宏外再次出现时只用中文，不重复英文括注。
- `\index{}` 的索引键暂不翻译，保留原样，避免破坏 makeindex 的排序和交叉项；正文中的可见文本照常翻译。
- `Turing machine`、`Church's Thesis` 等人名构成的术语保留西文姓氏，只翻译普通名词：`Turing 机`、`Church 论题`。
- 西文人名在正文首次出现时写 `English（中文音译）`，此后只写 English；标题中的人名始终只写 English。CJKV 人名方向相反。
- `computable / recursive / decidable / recognizable / enumerable` 等可计算性术语不可按日常近义词随意互换。
- `state` 译“状态”，`configuration` 译“格局”；`string` 译“串”，`symbol` 译“符号”，`token` 译“记号”；`grammar` 译“文法”。
- 图论中 `walk / trail / path / cycle / circuit` 分别按术语表处理，不以泛称“路径”混用。
- 当同一个英文词在不同技术语境中有不同含义时，以所在章节和术语表条目为准，不机械套用日常词义。
- 若术语表没有收录某词，优先采用本学科通行译法，并使它与表内已有相关术语构成自然的词族。

## LaTeX 与文本规则

- 保留所有环境、宏名、label、ref、cite、URL、数学模式和参数层级；不要改写命令拼写。
- 只翻译承载自然语言的参数，例如标题、caption、脚注、`\citetext` 的显示文本、表格中的文字。文件路径、引用键、索引键、代码与机器描述不翻译。
- `\footnote{...}`、`\citetext{...}{...}` 等宏中的自然语言同样属于正文信息，必须完整翻译；不可只翻译宏外主句。
- 注释原则上保留原样；不要把注释内容移入正文，也不要把正文变成注释。
- 中文正文使用弯引号“”‘’，不用 ASCII 引号或直角引号。英文代码、字符串字面量及 LaTeX 语法中的引号不改。
- 原文以 TeX 的 ``...'' 表示普通英文引语时，如果内容在译文中成为中文自然语言，引号改为中文弯引号；如果是代码、字面串或需逐字保留的英文文本，则保持原样。
- 中文与行内数学、英文缩写、人名之间按项目既有排版习惯留空格；不要在命令与参数之间擅加空格。
- 原文换行通常只是排版，不等于句法边界。译文可以重新断行，但段落边界、环境边界和宏嵌套关系不得改变。
- `~`、`\,`、`\!`、`\sentencespace`、`\Dash` 等具有排版或语义作用的控制符原则上保留。

## 工作流程

### 第一步：逐句解析

说明每句的主干、修饰关系、代词所指，以及宏参数中哪些是可译文本。

### 第二步：整理逻辑链条

列出定义、前提、推导、结论及例子之间的关系，重点检查量词、否定和“存在一条成功分支”等语义。

### 第三步：识别翻译难点

列出术语、多义词、作者语气、双关或 LaTeX 风险，并说明采取的译法。

### 第四步：译文

只给出可直接回填原文件的完整 LaTeX，不加代码围栏，不省略任何内容。

# 示例

以下样本均取自本书正文，作为整书翻译的 few-shot 示例。

## 样本一

### 原文

```tex
A text does its readers a disservice if it is not precise.
Details matter.
But students can also fail to understand a subject because they have not had
a chance to reflect on the underlying ideas.
The presentation here stresses motivation and naturalness
and, where practical, sets the results in a network of connections.

The first example comes on the first page, where we begin with Turing machines.
The alternative of starting with Finite State machines
is mathematically slicker but for
a fresh learner it is more natural to instead
start by asking what can be computed at all.
```

### 第一步：逐句解析

- **句 1：`A text does its readers a disservice if it is not precise.`** 主干是“a text does its readers a disservice”；`if it is not precise` 给出条件，即教材若不精确，就有负于读者。这里的 `precise` 不只是“写得详细”，而是数学教材意义上的严谨、准确。
- **句 2：`Details matter.`** 独立短句，承接上句，用极短的节奏强调“细节很重要”。译文也应保持简短，不扩写成一大句。
- **句 3：`But students can also fail to understand ...`** `But` 转折：只讲精确性仍不够。主干是“students can also fail to understand a subject”；`because ...` 给出另一种失败原因：没有机会反思底层思想。`underlying ideas` 指支撑细节的基本思想、直觉或动机。
- **句 4：`The presentation here stresses ...`** 主干是“the presentation stresses motivation and naturalness”，并列补充 `where practical` 条件下“sets the results in a network of connections”。后半不是字面上的“网络”，而是强调把结果放入相互联系中来呈现。
- **句 5：`The first example comes on the first page ...`** `where` 引出第一页上的具体做法：从 Turing machines 开始。这是在给上一段的教学理念举第一个例子。
- **句 6：`The alternative of starting with Finite State machines ...`** 主干是“The alternative ... is mathematically slicker but ... it is more natural ...”。对比两种编排：从有限状态机起步数学上更利落；但对新手，更自然的是先问“究竟什么是可计算的”。`at all` 加强“从根本上/究竟”的追问语气。

### 第二步：逻辑链条

1. 教材必须精确，细节不能马虎。
2. 但仅有精确细节仍不足以保证理解；学生还需要把握背后的思想。
3. 因此本书的呈现策略同时强调动机、自然性和知识之间的联系。
4. 作者马上用章节编排举例：虽然从有限状态机开始在数学结构上更漂亮，但本书为了初学者的认知顺序，从“什么可以被计算”这一更根本的问题切入 Turing 机。

### 第三步：翻译难点

- `does its readers a disservice` 不宜硬译“对读者做了坏事”；采用“有负于读者”或“是对读者的不负责任”，保留作者明确的价值判断。
- `precise` 在教材语境取“严谨/准确”，不能弱化成“写得细”。
- `motivation and naturalness` 译“动机与自然性”，其中“自然性”指概念和叙述顺序让人觉得顺理成章，不是自然科学意义的“自然”。
- `a network of connections` 不宜译成生硬的“连接网络”；采用“放到彼此联系的脉络中”。
- `mathematically slicker` 带轻松口语感，译“在数学上更利落/更漂亮”，不宜庄重化成“具有更高的数学优雅性”。
- 按项目规则，`Turing machines` 译“Turing 机”；`Finite State machines` 按术语表译“有限状态机”。

### 第四步：译文

一本教材若不够严谨，便有负于读者。
细节很重要，但背后的基本思想也很重要；
学生也可能因为没有机会思考背后的基本思想，而无法真正理解一门学科。
因此，本书会着重说明动机与自然性，并在可行之处把各项结果放到彼此联系的脉络中来理解。

本书将从 Turing 机讲起，这就是本书教学理念的第一个例子。
其他一些书籍会从有限状态机开始，这在数学上更利落；
但对初学者而言，从“究竟什么东西是可计算的”开始更加自然。

## 样本二

### 原文

```tex
Second,
the computing agent must follow a definite procedure,
a precise set of instructions
with no room for creative leaps.
Part of what makes the procedure definite is that
the instructions
\citetext{don't involve random methods}{%
  We can build things that return completely random results;
  one example is a device that registers consecutive
  clicks on a Geiger counter and if
  the second gap between clicks is longer then the first it returns~$1$,
  else it returns~$0$.},
such as counting clicks from radioactive decay
to determine which of two possibilities to perform.

In line with this, the agent works step by~step.
If needed they could pause between steps, note where they are
(``about to carry a $1$''), and pick up again later.
We say that at each moment the clerk is in one of a finite set of
possible \definend{states},\index{state}
which we denote $q_0$, $q_1$, \ldots\sentencespace
```

### 第一步：逐句解析

- **句 1：`Second, the computing agent must follow a definite procedure ...`** 这是列举中的第二点。主干是“the computing agent must follow a definite procedure”；后面的同位语 `a precise set of instructions` 解释 `procedure`，`with no room for creative leaps` 进一步限定：执行时不能依靠创造性的跳步或临场发挥。
- **句 2：`Part of what makes the procedure definite is that ...`** 主干是“Part of what makes ... is that the instructions don't involve random methods”。后面的 `such as ...` 给出随机方法的例子：用放射性衰变的随机点击来二选一。`\citetext{...}{...}` 的第一个参数属于主句的可见文本，要翻译；第二个参数是插入说明，也必须翻译并保持宏结构。
  - **插话句 1：`We can build things that return completely random results; one example is ...`** 分号连接总述和例子。例子装置记录 Geiger 计数器连续的点击；若第二个点击间隔长于第一个就返回 $1$，否则返回 $0$。其作用是说明“完全可以造出利用物理随机性的装置”，而不是说随机本身不存在。
- **句 3：`In line with this, the agent works step by step.`** `In line with this` 承接“确定的程序”：既然规则确定，计算者就按离散步骤逐步执行。
- **句 4：`If needed they could pause between steps ...`** 条件句说明“状态”概念为什么合理：计算者可以在步骤间暂停，记下当前做到哪里，再从同一点恢复。括号中的 ``about to carry a $1$'' 是具体的心算/笔算状态描述，`carry a 1` 译“进 $1$”。
- **句 5：`We say that at each moment the clerk is in ... states ...`** 正式引入 `states`。`\definend{states}` 要译为 `\definend{状态（state）}`；`\index{state}` 索引键保持原样。`which we denote ...` 指这些有限个可能状态用 $q_0,q_1,\ldots$ 表示。

### 第二步：逻辑链条

1. 可计算过程的第二项要求是“程序必须确定”：每一步都由精确指令决定，不能靠创造性跳跃。
2. “确定”还排除了把随机物理过程当作决定下一步的方法；插话用 Geiger 计数器说明真正的随机选择是可以构造出来的，因此这是一个实质限制。
3. 一旦计算被理解为逐步执行，就可以在任意步骤之间暂停并记录“当前做到哪里”。
4. 这个“当前做到哪里”的有限信息被抽象为有限多个状态，由此自然引出正式术语 `state` 及记号 $q_0,q_1,\ldots$。

### 第三步：翻译难点

- `computing agent` 不是现代 AI 语境的“智能体”；这里是抽象的计算执行者，后文直接称 `clerk`。采用“计算者”，后文 `clerk` 译“计算员”，避免误导。
- `definite procedure` 重点是“步骤由明确规则决定”，译“确定的程序/规程”；不能只译“明确的流程”而丢失可计算性讨论中的确定性。
- `creative leaps` 不是“创造性的飞跃”这种字面表达，采用“临场发挥或创造性跳步”。
- `don't involve random methods` 的否定是本句关键，必须明确译成“不涉及随机方法”。
- `\citetext` 两个参数都有自然语言；第一个参数嵌入主句，第二个参数是解释性插话，宏和 `%` 均保留。
- `then` 在 `longer then the first` 中显然承担比较义；译文按句意写“长于第一个”，不把源文拼写问题带入中文。
- `about to carry a $1$` 是算术进位语境，译“正要进 $1$”，保持作者的日常例子。
- `\definend{states}` 是正式术语首次引入，按项目规则加英文原词；`\index{state}` 不翻译。

### 第四步：译文

第二，计算者必须遵循一个确定的程序，也就是一套精确的指令，
不能留下临场发挥或创造性跳步的余地。
程序之所以是确定的，其中一点就在于这些指令\citetext{不涉及随机方法}{%
  我们完全可以造出给出纯随机结果的东西；
  例如，有一种装置会记录 Geiger 计数器连续发出的点击声，
  如果第二次点击间隔比第一次更长，就返回~$1$，
  否则返回~$0$。}，
例如不能靠数放射性衰变产生的点击声，来决定两个可能操作中究竟执行哪一个。

与此相应，计算者一步一步地工作。
必要时，他可以在两步之间停下来，记下自己当前做到哪里
（“正要进一个 $1$”），过一会儿再接着做。
我们说，在每一个时刻，这名计算者都处于有限多个可能的
\definend{状态（state）}之一，\index{state}
我们把这些状态记作 $q_0$、$q_1$、\ldots\sentencespace

## 样本三

### 原文

```tex
The rewrite rules govern the
\definend{derivation}\index{derivation}\index{grammar!derivation}
of strings in the language.
Under the grammar above
every derivation starts with \ntrm{sentence}.
During a derivation, intermediate strings contain a mix of nonterminals and
terminals.
In our grammars every rule has a head with a single nonterminal so
to get the next string,
pick a nonterminal in the present string,
find a rule where that nonterminal is a head, and
then substitute that rule's body.

Note that while the single line arrow \productionsymbol{} is for rules,
we use the double line arrow \derivessymbol{} for derivations.\footnote{%
  Read `\derivessymbol{}' aloud as ``expands to.''}
```

### 第一步：逐句解析

- **句 1：`The rewrite rules govern the derivation of strings in the language.`** 主干是“rewrite rules govern the derivation”。`\definend{derivation}` 正式引入术语“推导”；两个 `\index{...}` 都是索引键，原样保留。`of strings in the language` 说明被推导的是语言中的串。
- **句 2：`Under the grammar above every derivation starts with \ntrm{sentence}.`** `Under the grammar above` 是范围限定；全称量词 `every` 必须保留：每一次推导都从非终结符 `\ntrm{sentence}` 开始。
- **句 3：`During a derivation, intermediate strings contain a mix of nonterminals and terminals.`** 说明推导中间阶段的串还没有全变成终结符，而是同时含有非终结符与终结符。
- **句 4：`In our grammars every rule has ...`** 一个较长的过程句。前提：这里的每条规则的 `head` 都只有一个非终结符。由此给出获得“下一个串”的三步操作：在当前串中选一个非终结符；找一条以它为头部的规则；用该规则的体部替换这个非终结符。`so` 表明后面的算法步骤由前述规则形式自然导出。
- **句 5：`Note that while the single line arrow ...`** `while` 在这里作对照：单线箭头 `\productionsymbol{}` 用于规则，双线箭头 `\derivessymbol{}` 用于推导。两个宏必须保持原样。
  - **脚注句 1：`Read \derivessymbol{} aloud as “expands to.”`** 说明双线箭头的口头读法。脚注内容要翻译；宏仍保留。

### 第二步：逻辑链条

1. 先用“重写规则”定义/控制语言中串的“推导”。
2. 给出该文法中一次推导的起点：统一从 `\ntrm{sentence}` 开始。
3. 说明推导过程中的中间对象是什么：终结符和非终结符混合的串。
4. 利用“每条规则头部只有一个非终结符”这一结构，给出从当前串得到下一串的具体操作。
5. 最后区分两个容易混淆的记号：规则箭头与推导箭头，并用脚注给出后者的读法。

### 第三步：翻译难点

- `rewrite rules / derivation / nonterminals / terminals / head / body` 都是形式语言固定术语，分别采用“重写规则 / 推导 / 非终结符 / 终结符 / 头部 / 体部”。
- `govern` 不必硬译“支配”，这里译“规定/控制……的推导”更自然。
- `every` 是全称限定，不能弱化成“一般来说”。
- `substitute that rule's body` 的对象省略在英语中很自然；中文应明确成“用该规则的体部替换这个非终结符”，避免读者不清楚替换谁。
- `single line arrow / double line arrow` 重点是区分两套记号，可译“单线箭头/双线箭头”。
- 脚注中的英文 TeX 引号在中文自然语言中改成弯引号“展开为”，但 `\derivessymbol{}` 本身不动。

### 第四步：译文

重写规则规定了语言中各个串的
\definend{推导（derivation）}\index{derivation}\index{grammar!derivation}。
在上面的文法中，
每次推导都从 \ntrm{sentence} 开始。
在推导过程中，中间得到的串会同时含有非终结符和终结符。
在我们的文法中，每条规则的头部都只有一个非终结符，因此，
要得到下一个串，就在当前串中选一个非终结符，
找到一条以这个非终结符为头部的规则，
再用该规则的体部替换它。

注意，单线箭头 \productionsymbol{} 表示规则，
双线箭头 \derivessymbol{} 表示推导。\footnote{%
  \derivessymbol{} 读作“展开为”。}

## 样本四

### 原文

```tex
Going around forever in a cycle between $q_0$ and $q_1$,
always taking the $\varepsilon$ transitions, will indeed
not lead to a successful outcome.
But the definition does not require that
there must not be any wrong ways to process
the input string, only that there must be a right way.

The machine accepts the input string
if there is a sequence of transitions
that has a halting configuration with an
accepting state.
The given machine
can accept \str{aab} by starting in $q_0$,
transitioning to $q_1$ on the first \str{a},
taking the $\varepsilon$ transition to~$q_0$,
then going to $q_1$ on the second~\str{a},
then going to $q_2$, which is accepting, with the~\str{b}.
```

### 第一步：逐句解析

- **句 1：`Going around forever ... will indeed not lead to a successful outcome.`** 整个动名词短语作主语：如果始终选择 $\varepsilon$ 转移，在 $q_0$ 与 $q_1$ 之间无限循环，这条计算分支确实不会成功。`indeed not` 是确认性的强调，不应省掉。
- **句 2：`But the definition does not require ... only that ...`** 这是本段最关键的量词语义。定义**并不要求不存在任何错误的处理方式**；它**只要求存在一种正确的方式**。前半是否定“所有分支都必须正确”这一要求，后半肯定“至少有一条成功分支”。翻译时必须避免写成“不能走错路”。
- **句 3：`The machine accepts the input string if there is a sequence of transitions ...`** 给出接受条件：若**存在**一列转移，其计算达到一个停机格局，且状态为接受状态，则机器接受输入串。`there is` 的存在量词是非确定性接受语义的核心。
- **句 4：`The given machine can accept \str{aab} by ...`** 用具体成功分支验证上一句。步骤依次为：从 $q_0$ 开始；读第一个 `\str{a}` 转到 $q_1$；走 $\varepsilon$ 转移回 $q_0$；读第二个 `\str{a}` 转到 $q_1$；最后读 `\str{b}` 转到接受状态 $q_2$。所有机器记号与串宏原样保留。

### 第二步：逻辑链条

1. 先承认机器确实存在一条会永远兜圈、无法成功的计算分支。
2. 随即指出这并不妨碍非确定性机器接受输入，因为定义并不要求每条分支都成功。
3. 真正的接受条件是存在性条件：只要有一列转移能到达带接受状态的停机格局即可。
4. 最后为输入 `\str{aab}` 明确构造一条这样的成功转移序列，因此证明该机器能够接受它。

### 第三步：翻译难点

- 本段不能把非确定性接受误译成“不能有错误路径”。`does not require ... any wrong ways, only ... a right way` 必须清楚表达“失败分支可以存在；至少一条成功分支即可”。
- `there is a sequence of transitions` 必须保留存在量词“存在一列转移”，不能泛化为“经过一系列转移”。后者可能被读成确定的唯一过程。
- `successful outcome` 在上下文中指该计算分支成功接受，可译“成功的结果”；不必擅自把它改成正式定义尚未使用的其他术语。
- `$\varepsilon$ transitions` 按术语表译“$\varepsilon$-转移”。
- `halting configuration` 中 `configuration` 按项目规则译“格局”，因此采用“停机格局”。
- 最后一长句应按实际转移顺序重组，但不能漏掉每次读入哪个符号以及 $\varepsilon$ 转移不消费输入这一事实。

### 第四步：译文

如果始终走 $\varepsilon$-转移，在 $q_0$ 和 $q_1$ 之间不停地循环下去，
确实不会得到成功的结果。
但定义只要求处理输入串时存在一种正确的走法，并不要求不存在任何错误的走法。

如果存在一列转移，使机器到达一个状态为接受状态的停机格局，
那么机器就接受这个输入串。
对于这里这台机器，
可以从 $q_0$ 开始，
读入第一个 \str{a} 后转到 $q_1$，
再沿 $\varepsilon$-转移回到~$q_0$，
读入第二个~\str{a} 后转到 $q_1$，
最后读入~\str{b} 转到接受状态 $q_2$，从而接受 \str{aab}。

## 样本五

### 原文

```tex
Consider the rightmost column.
For the first few rows the relative change is an order of
magnitude, which is big but the absolute times are small.
Then we get to the bottom row.
That's not a typo\Dash the final entry really is about $10^{12}$~years.
The universe is $14\times 10^{9}$ years old
so this computation, even with
\citetext{input size of only~$100$}{%
  Basically, one hundred bits is what
  it takes to encode ``Jim Hefferon'' in UTF-8.},
would take longer than the age of the universe.
```

### 第一步：逐句解析

- **句 1：`Consider the rightmost column.`** 简短祈使句，引导读者把注意力转向表格最右一列。保持教材讲解式口吻即可。
- **句 2：`For the first few rows ...`** 主干是“the relative change is an order of magnitude”；关系从句 `which is big` 评价一个数量级的相对变化很大，`but` 随即对比：此时绝对运行时间仍很小。重点是“相对倍增巨大，但基数还小”。
- **句 3：`Then we get to the bottom row.`** 叙事推进的短句，制造转折前的停顿；不宜并入下一句。
- **句 4：`That's not a typo\Dash ...`** 作者以口语插话预判读者怀疑。“那不是排版错误”；`\Dash` 保留。后半强调最后一个数真的约为 $10^{12}$ 年。
- **句 5：`The universe is ... so this computation ... would take ...`** 因果结构：宇宙年龄约 $14\times10^9$ 年，因此即便输入规模仅为 100，这次计算所需时间仍超过宇宙年龄。`even with` 的让步语义必须保留。
  - **插话句 1：`Basically, one hundred bits is what it takes ...`** 解释“输入规模 100”有多小：用 UTF-8 编码名字 “Jim Hefferon” 大致就需要 100 比特。`\citetext` 第二参数需要翻译；人名字符串本身保持英文。

### 第二步：逻辑链条

1. 作者先让读者观察表格最右列。
2. 前几行虽然每次都出现数量级上的巨大相对变化，但绝对时间仍小，因此还不显得灾难性。
3. 到最后一行，增长突然进入极端尺度：$10^{12}$ 年，夸张到作者特意说明这不是排版错误。
4. 为建立直觉，作者拿宇宙约 $14\times10^9$ 年的年龄作比较。
5. 更强的是，这种不可接受的运行时间甚至发生在输入规模只有 100 的情况下；插话用一个人名的 UTF-8 编码说明 100 比特其实非常小。

### 第三步：翻译难点

- `an order of magnitude` 在这里是“一个数量级”，不是笼统的“很大一个量”。
- `relative change` 与 `absolute times` 必须保留对比，分别译“相对变化”和“绝对时间”。
- `Then we get to the bottom row.` 是叙事节奏，不要压成“最后一行则……”，否则会削弱下一句“不是笔误”的戏剧效果。
- `That's not a typo` 应口语化译“这可不是笔误”，而不是正式的“该数值不存在排版错误”。
- `\Dash` 是项目排版宏，保持原样。
- `even with input size of only 100` 的让步很重要，译“即使输入规模只有 100”。
- `\citetext` 的第一参数嵌在主句中，第二参数解释该数值的直观尺度；二者都要翻译，`Jim Hefferon` 与 `UTF-8` 保留英文。

### 第四步：译文

看看最右边这一列。
在开头几行里，相对变化达到了一个数量级，这当然很大，但绝对时间仍然很短。
接着我们来到最后一行。
这可不是笔误\Dash 最后那个数真的大约是 $10^{12}$~年。
宇宙的年龄约为 $14\times 10^{9}$ 年，
所以这次计算即使\citetext{输入规模只有~$100$}{%
  粗略地说，用 UTF-8 编码“Jim Hefferon”
  大约就需要一百比特。}，
耗时也会超过整个宇宙的年龄。

# 输出格式

对每个待翻译 chunk 严格输出：

```text
#### 第一步：逐句解析
...

#### 第二步：逻辑链条
...

#### 第三步：翻译难点
...

#### 第四步：译文
...
```
