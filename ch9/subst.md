# 替换模型 Substitution model

# 理解 e2\{v1\/x\}

```
let x = v1 in e2 --> e2{v1/x}
```

将表达式 e2 中的 x 替换成 v1

# 理解常见的rule

## Let

let 的类型是 string * expr * expr，因为它表示一个 let 绑定表达式。具体来说：

- string 表示变量的名称。
- 第一个 expr 表示要绑定到该变量的表达式。
- 第二个 expr 表示在该绑定的上下文中要计算的表达式。

例如，

```ocaml
Let ("x", Int 5, Binop (Add, Var "x", Int 3)) 表示 let x = 5 in x + 3。
```

## If of expr * expr * expr

表示一个 if 表达式的抽象语法树（AST）节点。它包含三个部分：

- 条件表达式（expr）：这是 if 语句的条件部分。
- then 分支表达式（expr）：这是当条件为真时要执行的表达式。
- else 分支表达式（expr）：这是当条件为假时要执行的表达式。
  例如，

```ocaml

if x > 0 then 1 else -1 可以表示为：

If (Binop (Gt, Var "x", Int 0), Int 1, Int (-1))
```

在这个例子中：

- `Binop (Gt, Var "x", Int 0)` 是条件表达式，表示 x > 0。
- `Int 1` 是 then 分支表达式，表示条件为真时返回 1。
- `Int (-1)` 是 else 分支表达式，表示条件为假时返回 -1。

这个类型定义使得 If 节点可以在抽象语法树中表示条件分支逻辑。
