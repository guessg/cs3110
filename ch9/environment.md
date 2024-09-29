# environment model 环境模型

# 对比替换模型

替换模型是eager 模式，效率不高。env model 是 lazy 模式，仅仅在需要时候才发生替换。


对应的，env model 的表示是

```bash
<env, e> --> e'

<env, e> ==> e'
```

其实 env 是所谓的环境，也就是程序内存的一部分（binding variables to values）。e 表示程序


# 环境模型的基本术语

```bash
# {} represent the empty environment,
{} 空环境

# {x1:v1, x2:v2, ...} represent the environment that binds x1 to v1, etc.,
含有 x1:v1, x2:v2 的环境

# env[x -> v] represent the environment env with the variable x additionally bound to the value v, and
将 x->v 加入环境

# env(x) represent the binding of x in env.
取出变量 variable x 的值 v
```


# lambda calculus 在 env model 中的 evaluating

## lambda calculus 的表示

```bash
e ::= x | e1 e2 | fun x -> e

v ::= fun x -> e
```

## 三条规则 rules
- <env, x>  ==> env(x)
> loopup the variable name in the environment.

- <env, fun x -> e> ==> fun x -> e
> 匿名函数 evaluate 自身

- application rule
```bash
<env, e1 e2> ==> v 
    if <env, v1> ==> fun x --> e
    and <env, e2> ==> v2
    and <env[x->x2], e> ==> v
```
> this rule for application says to evaluate the left-hand side e1 to a function fun x -> e, the right-hand side to a value v2, then to evaluate the body e of the function in an extended environment that maps the function’s argument x to v2:

== BUT, it's WRONG ==

## 正确的做法
### 闭包 
> A closure has two parts:
- a code part, which contains a function fun x -> e, and
- an environment part, which contains the environment env at the time that function was defined.


借助闭包，将某个时刻的 env 和 fun 一起封装保存起来。引入记号
$$ (| fun x -> e, env |) $$

### 规则 1： 匿名函数 fun 闭包
```ocaml
<env, fun x -> e> ==> (| fun x -> e, env |)
```
### 规则 2: application
```ocaml
<env, e1 e2> ==> v
  if <env, e1> ==> (| fun x -> e, defenv |)
  and <env, e2> ==> v2
  and <defenv[x -> v2], e> ==> v
```

defenv 意思是：
> That rule uses the closure’s environment defenv (whose name is meant to suggest the “defining environment”) to evaluate the function body e.

### 规则 3： let 
```ocaml
<env, let x = e1 in e2> ==> v
  if <env, e1> ==> v1
  and <env[x -> v1], e2> ==> v
```
> That’s because the defining environment for the body e2 is the same as the current environment env when the let expression is being evaluated.