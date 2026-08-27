#!/usr/bin/env bun

import candidates from "./term-candidates.json";
import { writeFile } from "node:fs/promises";
import { join } from "node:path";

type Candidate = (typeof candidates.definitions)[number];

const pairs = String.raw`
3-Coloring	3-着色
3-Satisfiability	3-可满足性
4-Satisfiability	4-可满足性
Assignment problem	指派问题
Asymmetric Traveling Salesman	非对称旅行商
Busy Beaver problem	忙海狸问题
Circuit Evaluation	电路求值
Class Scheduling	班级排课
Clique	团
Countdown	倒计时
Course Scheduling	课程排课
Crossword	填字游戏
Cyclic Shift	循环移位
Discrete Logarithm	离散对数
Divisor	因数
Double-SAT	双解 SAT
Fifteen Game	十五数码
Four Color	四色
Graph Coloring	图着色
Graph Connectedness	图连通性
Graph Isomorphism	图同构
Hamiltonian Path	Hamilton 路径
Independent Set	独立集
Integer Linear Programming	整数线性规划
Knapsack	背包
Knight's Tour	骑士巡游
Linear Divisibility	线性整除
Linear Programming	线性规划
Longest Path	最长路径
Matching problem	匹配问题
Max Cut	最大割
Max Flow	最大流
Minimum Spanning Tree	最小生成树
Nearest Neighbor	最近邻
Nondeterministic Bounded Halting problem	非确定性有界停机问题
Partition	划分
Primality	素性判定
Prime Factorization	素因数分解
Relativized Halting problem for S	相对于 $S$ 的停机问题
Satisfiability	可满足性
Semiprime	半素数
Set Cover	集合覆盖
Shortest Path	最短路径
Strict 3-Satisfiability problem	严格 3-可满足性问题
String Search	字符串搜索
Subset Sum	子集和
Three Dimensional Matching	三维匹配
Traveling Salesman	旅行商
Triangle	三角形
Turnpike	收费公路
Unweighted Shortest Path	无权最短路径
Vertex Cover	顶点覆盖
Vertex-to-Vertex Path	点到点路径
Six Degrees of Kevin Bacon	Kevin Bacon 的六度分隔
BB	忙海狸函数
HP set	停机问题集
REC	递归语言类
Sigma	字母表 $\Sigma$
K^S	相对于 $S$ 的停机集 $K^S$
ThreeSAT	3-SAT
B=set0 1	二元字母表 $\B=\set{\str{0},\str{1}}$
bigOh g	大 $O(g)$
BPP Bounded-Error Probabilistic Polynomial Time	$\compclass{BPP}$（有界错误概率多项式时间）
NP	$\compclass{NP}$（非确定性多项式时间）
DSPACE s	确定性空间复杂度类 $\DSPACE(s)$
DTIME f	确定性时间复杂度类 $\DTIME(f)$
lambda-calculus	$\lambda$-演算
mu-recursion	$\mu$-递归
mu-recursive	$\mu$-递归的
NP hard	$\NP$-难
NP intermediate	$\NP$-中间
NSPACE s	非确定性空间复杂度类 $\NSPACE(s)$
NTIME f	非确定性时间复杂度类 $\NTIME(f)$
P	$\P$（确定性多项式时间）
SAT	$\SAT$（可满足性）
SAT solver	$\SAT$ 求解器
SPACE s	空间复杂度类 $\SPACE(s)$
epsilon moves	$\varepsilon$-转移
epsilon closure	$\varepsilon$-闭包
0-distinguishable states	$0$-可区分状态
1-1	一一的
k-colorable	$k$-可着色的
k-coloring	$k$-着色
X-computable	$X$-可计算的
Y combinator	$Y$ 组合子
acceptable	可接受的
Aristotle's Paradox	Aristotle 悖论
binary sequence	二进制序列
Brocard's problem	Brocard 问题
caching	缓存
Cantor's correspondence	Cantor 对应
Cantor's pairing function	Cantor 配对函数
cardinality less than or equal to	势小于或等于
characteristic function S	特征函数 $\charfcn{S}$
co-computably enumerable	余可计算枚举的
computable enumerable in increasing order	按严格递增次序可计算枚举的
computable from the oracle X	可由预言机 $X$ 计算的
computably enumerable in an oracle	相对于预言机可计算枚举的
computably enumerable in the set A	相对于集合 $A$ 可计算枚举的
computation relative to an oracle	相对于预言机的计算
countable	可数的
countably infinite	可数无限的
decidable language	可判定语言
diagonalization	对角化
dovetailing	交错并行
enumerates	枚举
extensible	可扩展的
G odel number	Gödel 数
Galileo's Paradox	Galileo 悖论
hailstone function	冰雹函数
index number	索引号
index set	索引集
infinite	无限的
is an enumeration of	是……的枚举
K	停机集 $K$
K 0	停机集 $K_0$
lexicographic order	字典序
Liar paradox	说谎者悖论
memoization	记忆化
mentioned	被提及
Nominative determinism	姓名决定论
numbering	编号
oracle	预言机
parametrizing	参数化
partial application	部分应用
perfect number	完全数
pointers	指针
r e	递归可枚举的
recursively enumerable	递归可枚举的
reduces to	归约到
relativization	相对化
Russell set	Russell 集
same cardinality	同势
Schröder–Bernstein theorem	Schröder–Bernstein 定理
semicomputable	半可计算的
semidecidable	半可判定的
strictly increasing	严格递增的
trianglar number	三角数
Turing equivalent	Turing 等价的
Turing reducible to X	Turing 可归约到 $X$
Universal Turing Machine	通用 Turing 机
unpairing function	解配对函数
unreachable state	不可达状态
unsolvable	不可解的
use-mention distinction	使用—提及之分
used	被使用
and operator wedge	与运算符 $\wedge$
asymptotically equivalent	渐近等价的
Bacon number	Bacon 数
black holes	黑洞
bridge edge	桥
Carmichael numbers	Carmichael 数
certificate	证书
CNF	合取范式（CNF）
Cobham's thesis	Cobham 论题
colors	颜色
complexity class	复杂度类
complexity function	复杂度函数
Conjunctive Normal form	合取范式
Cook reduction	Cook 归约
coprime	互素的
cut set	割集
decision problem	判定问题
decrypter	解密器
decryption key	解密密钥
Deterministic logarithmic space	确定性对数空间
encrypter	加密器
encryption key	加密密钥
equivalent growth rates	等价的增长率
Exponential space	指数空间
Extended Church's Thesis	扩展 Church 论题
Fermat liar	Fermat 骗子数
Fermat pseudoprime	Fermat 伪素数
function problems	函数问题
gadget	小构件
galactic algorithm	银河算法
gate	门
graph cut	图割
haystack	干草堆
input gates	输入门
intractable	难解的
Karp reducible	Karp 可归约的
key length	密钥长度
language decision problem	语言判定问题
Lipton's Thesis	Lipton 论题
many-one reducible	多一可归约的
mapping reducible	映射可归约的
matching	匹配
needle	针
Nondeterministic Logarithmic space	非确定性对数空间
nondeterministic Turing machine	非确定性 Turing 机
not operator neg	非运算符 $\neg$
optimization problem	优化问题
or operator vee	或运算符 $\vee$
planar	平面的
Polynomial space	多项式空间
polynomial time many-one reducible	多项式时间多一可归约的
polynomial time mapping reducible	多项式时间映射可归约的
polytime Turing reduction	多项式时间 Turing 归约
private key	私钥
probabilistic primality test	概率素性检验
pseudopolynomial	伪多项式的
public key	公钥
quantum advantage	量子优势
Random Access machine RAM	随机存取机（RAM）
reduction function	归约函数
relatively prime	互素的
same order of growth	相同增长阶
satisfiable	可满足的
search problem	搜索问题
spans	张成
The machine runtime is bigOh f	机器运行时间为 $\bigOh(f)$
tractable	易解的
transformation function	变换函数
translation function	转换函数
truth table	真值表
Turing machine decidable	Turing 机可判定的
universal problems	通用问题
verifier	验证器
wire	导线
witness	见证
accepting state	接受状态
accepting states	接受状态
accepts	接受
alternation	交替
back reference	反向引用
computation tree	计算树
context free	上下文无关的
dead state	死状态
decided	判定
distinguishable	可区分的
distinguishable states	可区分状态
distinguishing extension	区分扩展
distinguishing string	区分串
error state	错误状态
escaping	转义
extended transition function	扩展转移函数
final state	接受状态
final states	接受状态
Finite State automata	有限状态自动机
Finite State machine	有限状态机
indistinguishable	不可区分的
initial state	初始状态
input	输入
input alphabet	输入字母表
language of that machine lang FSM	该机器的语言 $\lang(\FSM)$
language of the machine lang FSM	机器的语言 $\lang(\FSM)$
LIFO	后进先出（LIFO）
maximal path	极大路径
minimal	最小的
Moore's algorithm	Moore 算法
nondeterministic Finite State machine	非确定性有限状态机
powerset construction	幂集构造
product construction	积构造
pumping length	泵长度
Pushdown machine	下推机
recognized	识别
regex crossword	正则表达式填字游戏
regex golf	正则表达式高尔夫
regexes	正则表达式
regexp	正则表达式
regular expression	正则表达式
regular grammar	正则文法
regular language	正则语言
rejects	拒绝
right linear	右线性的
square strings	平方串
stack alphabet	栈字母表
start state	初始状态
subset method	子集法
transitions	转移
adjacency matrix	邻接矩阵
adjacent	相邻的
alpha-reduction	$\alpha$-归约
alphabet	字母表
Backus-Naur form BNF	Backus–Naur 范式（BNF）
binary tree	二叉树
body	体部
breadth-first	广度优先的
breadth-first traversal	广度优先遍历
chromatic number	色数
circuit	回路
compiler-compiler	编译器的编译器
complete graph on n vertices K n	$n$ 个顶点的完全图 $K_n$
concatenation of languages lang 0 concat lang 1	语言的拼接 $\lang_0\concat\lang_1$
context sensitive	上下文有关的
context-free grammar	上下文无关文法
DAG	有向无环图（DAG）
decides a language	判定一个语言
degree of a vertex	顶点的度
degree sequence	度序列
depth-first	深度优先的
depth-first traversal	深度优先遍历
derivation tree	推导树
digraph	有向图
directed acyclic graph	有向无环图
directed graph	有向图
edges	边
Euler circuit	Euler 回路
expansion	展开
grammar	文法
graph traversal	图遍历
Hamiltonian circuit	Hamilton 回路
has a derivation	可推导出
head	头部
incident	关联的
induced subgraph	导出子图
Kleene star of a language kleenestar lang	语言的 Kleene 星 $\kleenestar{\lang}$
lambda-expression	$\lambda$-表达式
language derived from a grammar	由文法生成的语言
language lang over an alphabet Sigma	字母表 $\Sigma$ 上的语言 $\lang$
leftmost derivation	最左推导
length	长度
metacharacters	元字符
multigraph	多重图
neighbors	邻点
nodes	节点
nonterminals	非终结符
palindrome	回文
parse tree	语法分析树
parser-generator	语法分析器生成器
Petersen graph	Petersen 图
planar graph	平面图
power lang k	幂 $\lang^k$
productions	产生式
reachable	可达的
reversal	反转
rewrite rules	重写规则
semidecides	半判定
simple graph	简单图
start symbol	开始符号
string	串
subgraph	子图
syntactic categories	句法范畴
tail-recursive	尾递归的
terminal symbols	终结符
token	记号
trail	迹
tree	树
universal donor	万能供血者
universal receptor	万能受血者
vertices	顶点
walk	通道
weight	权
weighted graph	加权图
and	与
arity	元数
atom	原子
bit strings	比特串
bitstrings	比特串
Boolean algebra	Boolean 代数
Boolean function	Boolean 函数
Boolean variables	Boolean 变量
clause	子句
connectives	联结词
correspondence	对应
decomposes	分解
DeMorgan's laws	De Morgan 律
disjunctive normal form	析取范式
DNF	析取范式（DNF）
empty string	空串
equivalent	等价的
expression	表达式
identity function	恒等函数
inclusion	包含映射
Kleene star	Kleene 星
left inverse	左逆
literal	文字
map	映射
natural domain	自然定义域
not	非
one-to-one	一一的
onto	满射的
operators	运算符
or	或
output	输出
prefix	前缀
proposition	命题
replication	重复
right inverse	右逆
substring	子串
suffix	后缀
symbols	符号
tokens	记号
truth tables	真值表
two-sided inverse	双侧逆
well-defined	良定义的
word	字
A computable set	可计算集
Ackermann function	Ackermann 函数
action set	动作集
action symbol	动作符号
beehive	蜂巢
blank	空白符
blinker	闪烁子
block	方块
cellular automaton	元胞自动机
Collatz conjecture	Collatz 猜想
computation	计算
configuration	格局
current symbol	当前符号
decides	判定
deterministic	确定性的
eater	吞噬子
Exclusive Or XOR	异或（XOR）
Fermat number	Fermat 数
Fermat primes	Fermat 素数
function computed by the machine	机器计算的函数
G odel's multiplicative encoding	Gödel 乘法编码
gates	门
general recursive	一般递归的
generations	代
glider	滑翔机
glider gun	滑翔机枪
Goldbach's conjecture	Goldbach 猜想
halting configuration	停机格局
halting states	停机状态
halts	停机
hyperoperation	超运算
initial configuration	初始格局
input symbol	输入符号
instruction	指令
instructions	指令
Legendre's conjecture	Legendre 猜想
level n	第 $n$ 级
loading	装载
McCarthy's 91 function	McCarthy 的 $91$ 函数
medium weight spaceship	中量级飞船
methuselah	长寿型
minimization	极小化
next state	下一状态
next-state function	下一状态函数
partial recursive	偏递归的
power tower	幂塔
present state	当前状态
primitive recursive functions	原始递归函数
proper subtraction	截断减法
rabbit	兔子
recognizes	识别
recursion	递归
recursive	递归的
recursive function	递归函数
recursive set	递归集
set of states	状态集
spaceship	飞船
states	状态
step	步骤
symbol	符号
tape alphabet	纸带字母表
tetration	四级超运算
toad	蟾蜍
transition graph	转移图
transition table	转移表
triangular number	三角数
tub	澡盆
working states	工作状态
argument	自变量
domain	定义域
inverse	逆函数
walk	游走
trail	迹
path	路
circuit	回路
cycle	圈
rank	深度
modulus	模数
complete	完备的
zero	零函数
c e	可计算枚举的（c.e.）
r e	递归可枚举的（r.e.）
LOOP	LOOP 程序
`;

const exact = new Map<string, string>();
const decodeUnicodeEscapes = (value: string) => value.replace(/\\u([0-9A-Fa-f]{4})/g, (_, hex) =>
  String.fromCharCode(Number.parseInt(hex, 16)));
for (const line of pairs.trim().split("\n")) {
  const [en, zh] = line.split("\t");
  if (!en || !zh) throw new Error(`bad translation row: ${line}`);
  exact.set(en, decodeUnicodeEscapes(zh));
}

const rawPairs = String.raw`
\smash{K^S}	相对于 $S$ 的停机集 $K^S$
$\phi_e$	第 $e$ 个偏可计算函数 $\phi_e$
$\TM_e^X\!$	以 $X$ 为预言机的第 $e$ 台 Turing 机 $\TM_e^X$
$\TM_e$	第 $e$ 台 Turing 机 $\TM_e$
$\TMfcn^X_e\!$	以 $X$ 为预言机的第 $e$ 个 Turing 可计算函数 $\TMfcn^X_e$
$A\equiv_T B$	$A$ 与 $B$ Turing 等价
$S\leq_T X$	$S$ Turing 可归约到 $X$
$W_e=\set{x\suchthat \TMfcn_e(x)\converges}$	可计算枚举集 $W_e=\set{x\suchthat \TMfcn_e(x)\converges}$
$X$-computable	$X$-可计算的
characteristic function $\charfcn{S}$	特征函数 $\charfcn{S}$
G\"odel number	Gödel 数
have the same behavior, $\TMfcn_{e}\samebehavior\TMfcn_{\hat{e}}$	具有相同行为，$\TMfcn_{e}\samebehavior\TMfcn_{\hat{e}}$
Schröder–Bernstein theorem	Schröder–Bernstein 定理
\probname{Double-$\SAT$}	双解 SAT
$\lang_1\leq_m^p\lang_0$	多项式时间多一归约 $\lang_1\leq_m^p\lang_0$
$\lang_1\leq_p\lang_0$	多项式时间归约 $\lang_1\leq_p\lang_0$
$\lang_1$ is polynomial time reducible to $\lang_0$	$\lang_1$ 可在多项式时间内归约到 $\lang_0$
$\strng(x)$	$x$ 的串表示 $\strng(x)$
$B\leq_m A$	$B$ 多一归约到 $A$
$B\leq_T^pA$	$B$ 可在多项式时间内 Turing 归约到 $A$
$f\in \bigOh(g)$	$f\in\bigOh(g)$
$f=\bigOh(g)$	$f=\bigOh(g)$
$f$ is $\bigTheta(g)$	$f$ 是 $\bigTheta(g)$
$f$ is Big~$\bigOh(g)$	$f$ 是大 $\bigOh(g)$
$f$ is of order at most~$g$	$f$ 的阶至多为 $g$
$k$-colorable	$k$-可着色的
runs in input length time $\map{\hat{t}_{\mathcal{M}}}{\N}{\N\cup\set{\infty}}$	按输入长度计的运行时间 $\map{\hat{t}_{\mathcal{M}}}{\N}{\N\cup\set{\infty}}$
runs in space~$\map{s}{\N}{\R^+\cup\set{0}}$	在空间 $\map{s}{\N}{\R^+\cup\set{0}}$ 内运行
takes time $\map{t_{\mathcal{M}}}{\kleenestar{\Sigma}}{\N\cup\set{\infty}}$	耗时 $\map{t_{\mathcal{M}}}{\kleenestar{\Sigma}}{\N\cup\set{\infty}}$
$\eclass_{\lang,j}$	等价类 $\eclass_{\lang,j}$
$\lang$-distinguishable	$\lang$-可区分的
$\lang$-indistinguishable	$\lang$-不可区分的
$\lang$-machine	$\lang$-机器
$\lang$-related	$\lang$-相关的
$\mathcal{C}\yields\hat{\mathcal{C}}$	将构造 $\mathcal{C}$ 转换为 $\hat{\mathcal{C}}$
$\sigma_0\sim_{\lang}\sigma_1$	$\sigma_0$ 与 $\sigma_1$ 关于 $\lang$ 等价
$\varepsilon$ moves	$\varepsilon$-转移
$0$-distinguishable states	$0$-可区分状态
$q\sim_{n}\hat{q}$	状态 $q$ 与 $\hat q$ 是 $n$-等价的
$q\sim\hat{q}$	状态 $q$ 与 $\hat q$ 等价
$\B=\set{\str{0},\str{1}}$	二元字母表 $\B=\set{\str{0},\str{1}}$
$\lang_0\lang_1$	语言拼接 $\lang_0\lang_1$
$k$-coloring	$k$-着色
concatenation of languages, $\lang_0\concat\lang_1$	语言拼接 $\lang_0\concat\lang_1$
Kleene star of a language $\smash{\kleenestar{\lang}}$	语言的 Kleene 星 $\smash{\kleenestar{\lang}}$
$\kleenestar{\Sigma}=\cup_{k\in\N}\Sigma^k\!$	Kleene 星 $\kleenestar{\Sigma}=\cup_{k\in\N}\Sigma^k$
$\lh{\sigma}$	串长 $\lh{\sigma}$
$\map{f}{D}{C}$	函数 $\map{f}{D}{C}$
$\sigma\tau$	拼接 $\sigma\tau$
$\Sigma^k\!$	$k$ 次幂 $\Sigma^k$
$1$-$1$	一一的
$f(x)=y$	$f$ 将 $x$ 映到 $y$，即 $f(x)=y$
$f^{-1}\!$	逆函数 $f^{-1}$
$x\mapsto y$	$x$ 映到 $y$
$\lambda$-calculus	$\lambda$-演算
$\mu$-recursion	$\mu$-递归
$\mu$-recursive	$\mu$-递归的
$\rightarrow$	蕴含符号 $\rightarrow$
$\TMfcn_{\TM}(\sigma)\mathord{\downarrow}$	$\TM$ 在输入 $\sigma$ 上收敛
$\TMfcn_{\TM}(\sigma)\mathord{\uparrow}$	$\TM$ 在输入 $\sigma$ 上发散
$\TMfcn_{\TM}(\sigma)$	机器 $\TM$ 计算的函数在 $\sigma$ 处的值
G\"{o}del's multiplicative encoding	Gödel 乘法编码
$\varepsilon$~closure	$\varepsilon$-闭包
composition $\map{\composed{g}{f}}{D}{B}$	复合 $\map{\composed{g}{f}}{D}{B}$
concatenation $\sigma\concat\tau$	拼接 $\sigma\concat\tau$
beta reduction	$\beta$-归约
Turing machine	Turing 机
projection	投影函数
successor	后继函数
`;
const rawExact = new Map(rawPairs.trim().split("\n").map((line) => {
  const [en, zh] = line.split("\t");
  if (!en || !zh) throw new Error(`bad raw translation row: ${line}`);
  return [en, decodeUnicodeEscapes(zh)];
}));

const supplementalTerms = [
  ["Halting problem", "停机问题"],
  ["Entscheidungsproblem", "判定问题（Entscheidungsproblem）"],
  ["input string", "输入串"],
  ["nondeterminism", "非确定性"],
  ["NP-complete", "$\\NP$-完全"],
  ["Big O", "大 $O$"],
  ["Big theta", "大 $\\Theta$"],
  ["epsilon transitions", "$\\varepsilon$-转移"],
  ["Church's Thesis", "Church 论题"],
  ["Cook--Levin theorem", "Cook--Levin 定理"],
  ["Kleene's theorem", "Kleene 定理"],
  ["Rice's theorem", "Rice 定理"],
  ["Myhill--Nerode theorem", "Myhill--Nerode 定理"],
  ["P versus NP", "$\\P$ 对 $\\NP$ 问题"],
  ["Turing reducibility", "Turing 可归约性"],
  ["order of growth", "增长阶"],
  ["polynomial time", "多项式时间"],
  ["nondeterministic Pushdown machine", "非确定性下推机"],
  ["RSA encryption", "RSA 加密"],
  ["read/write head", "读写头"],
].map(([en, zh]) => ({ en, zh }));

const personNames = [
  ["Wilhelm Ackermann", "威廉·阿克曼"], ["Leonard Adleman", "伦纳德·阿德曼"],
  ["Manindra Agrawal", "马宁德拉·阿格拉瓦尔"], ["John Backus", "约翰·巴科斯"],
  ["Kevin Bacon", "凯文·贝肯"], ["Yogi Berra", "尤吉·贝拉"],
  ["George Boole", "乔治·布尔"], ["Georg Cantor", "格奥尔格·康托尔"],
  ["Alonzo Church", "阿隆佐·邱奇"], ["Alan Cobham", "艾伦·科巴姆"],
  ["John Conway", "约翰·康威"], ["Stephen Cook", "斯蒂芬·库克"],
  ["Augustus De Morgan", "奥古斯塔斯·德·摩根"], ["Jack Edmonds", "杰克·埃德蒙兹"],
  ["Leonhard Euler", "莱昂哈德·欧拉"], ["Galileo Galilei", "伽利略·伽利莱"],
  ["Martin Gardner", "马丁·加德纳"], ["Kurt Gödel", "库尔特·哥德尔"],
  ["Hermann Grassmann", "赫尔曼·格拉斯曼"], ["William Rowan Hamilton", "威廉·罗恩·哈密顿"],
  ["David Hilbert", "大卫·希尔伯特"], ["Douglas Hofstadter", "道格拉斯·霍夫斯塔特"],
  ["Katherine Johnson", "凯瑟琳·约翰逊"], ["Anatoly Karatsuba", "阿纳托利·卡拉楚巴"],
  ["Richard Karp", "理查德·卡普"], ["Neeraj Kayal", "尼拉杰·卡亚尔"],
  ["Stephen Kleene", "斯蒂芬·克林"], ["Donald Knuth", "唐纳德·克努特"],
  ["Andrey Kolmogorov", "安德雷·柯尔莫哥洛夫"], ["Leonid Levin", "列昂尼德·列文"],
  ["Karl Menger", "卡尔·门格尔"], ["Albert Meyer", "阿尔伯特·迈耶"],
  ["John Myhill", "约翰·迈希尔"], ["Peter Naur", "彼得·诺尔"],
  ["Anil Nerode", "阿尼尔·尼罗德"], ["Raymond Paley", "雷蒙德·佩利"],
  ["Rózsa Péter", "罗莎·培特"], ["Tibor Radó", "蒂博尔·拉多"],
  ["Dennis Ritchie", "丹尼斯·里奇"], ["Ronald Rivest", "罗纳德·李维斯特"],
  ["Julia Robinson", "朱莉娅·罗宾逊"], ["Nitin Saxena", "尼廷·萨克塞纳"],
  ["Adi Shamir", "阿迪·萨莫尔"], ["Claude Shannon", "克劳德·香农"],
  ["Ken Thompson", "肯·汤普森"], ["Alan Turing", "阿兰·图灵"],
  ["John von Neumann", "约翰·冯·诺伊曼"],
  ["Richard Dedekind", "理查德·戴德金"], ["Epimenides", "埃庇米尼得斯"],
  ["Euclid", "欧几里得"], ["Abraham Fraenkel", "亚伯拉罕·弗兰克尔"],
  ["Carl Friedrich Gauss", "卡尔·弗里德里希·高斯"], ["Morris Klein", "莫里斯·克莱因"],
  ["Gottfried Wilhelm Leibniz", "戈特弗里德·威廉·莱布尼茨"], ["Emil Post", "埃米尔·波斯特"],
  ["Willard Van Orman Quine", "威拉德·范·奥曼·蒯因"], ["Bernhard Riemann", "伯恩哈德·黎曼"],
  ["J. Barkley Rosser", "J. 巴克利·罗瑟"], ["Bertrand Russell", "伯特兰·罗素"],
  ["Brook Taylor", "布鲁克·泰勒"], ["Ernst Zermelo", "恩斯特·策梅洛"],
  ["Craig Fass", "克雷格·法斯"],
].map(([en, zh]) => ({ en, zh }));

function plain(term: string): string {
  return term
    .replace(/~+/g, " ")
    .replace(/\\protect/g, "")
    .replace(/\\(?:smash|textit|textsc|textbf|mathrm|operatorname|probname|compclass|set|str)\s*\{([^{}]*)\}/g, "$1")
    .replace(/\\(?:map|lh|kleenestar|strng|bigOh|bigTheta)\s*\{([^{}]*)\}/g, "$1")
    .replace(/\\/g, "")
    .replace(/[$^_{}(),.;:=!]/g, " ")
    .replace(/\s+/g, " ")
    .trim();
}

const sections: Record<string, Array<Record<string, unknown>>> = {};
for (const candidate of candidates.definitions as Candidate[]) {
  const source = candidate.occurrences[0]!.file.split("/")[0]!;
  const key = plain(candidate.en);
  const translated = candidate.en === "Schröder–Bernstein theorem"
    ? "Schröder–Bernstein 定理"
    : rawExact.get(candidate.en) ?? exact.get(key) ?? candidate.zh;
  (sections[source] ??= []).push({
    en: candidate.en,
    zh: translated,
    ...(translated ? {} : { needs_translation: true }),
  });
}

// rank 在 languages/ 的图遍历部分指顶点到根的距离，即“深度”；
// automata/ 另用 rank(L) 表示接受 L 所需的最少状态数，按该章语境译“秩”。
(sections.automata ??= []).push({ en: "rank", zh: "秩" });

await writeFile(join(import.meta.dir, "toc-glossary.json"), JSON.stringify({
  _meta: {
    status: "draft_for_user_review",
    term_count: candidates.definitions.length,
    rule: "\\definend{X} 是本书正式定义术语；译文中保留宏，并写作 \\definend{中文（English）}。人名另见 person_names。",
  },
  ...sections,
  supplemental_terms: supplementalTerms,
  person_names: {
    _note: "西文人名正文首次写 English（中文），此后仅 English；标题中只写 English。",
    list: personNames,
  },
}, null, 2) + "\n");

const missing = Object.values(sections).flat().filter((entry) => entry.needs_translation);
console.log(`terms=${candidates.definitions.length} translated=${candidates.definitions.length - missing.length} missing=${missing.length}`);
