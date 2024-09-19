
在 OCaml 中，函数定义有几种常见方式，每种方式有其特点：

# let
用于定义命名函数。可以是递归的（使用 let rec），也可以是非递归的。示例：

```ocaml
let add x y = x + y
let rec factorial n = if n <= 1 then 1 else n * factorial (n - 1)
```

# fun
用于定义匿名函数（lambda 表达式）。它常用于需要一次性的函数定义，而不需要给函数起个名字。示例：


```ocaml
let add = fun x y -> x + y
let square = fun x -> x * x
```

# function
用于定义基于模式匹配的函数。它常用于需要处理多个模式的函数体中。示例：

```ocaml
let classify_number = function
  | n when n < 0 -> "Negative"
  | 0 -> "Zero"
  | _ -> "Positive"
```

# 联系和区别：
- let 用于定义命名函数或值。可以是简单的函数，也可以是递归的。
- fun 用于创建匿名函数，通常结合 let 使用，例如 let f = fun x -> x + 1。
- function 主要用于函数体内的模式匹配，更适合处理不同的输入模式，而不是定义函数本身。

总的来说，let 和 fun 更侧重于定义函数，而 function 则专注于处理函数中的模式匹配。