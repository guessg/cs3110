# module

## module 语法
```ocaml
module ModuleName = module_expression
```

> struct ... end 是 module_expression 的一种。

```ocaml
module ModuleName = struct
  module_items
end

(* 空 module *)
module E = struct end

module L = List (* List 是已定义的 module expression *)
```
## module type 定义
```ocaml
module type ModuleTypeName = sig
  specifications
end

module type ModuleTypeName = module_type
```

比如
```ocaml
module type LIST_STACK = sig
  exception Empty
  val empty : 'a list
  val is_empty : 'a list -> bool
  val push : 'a -> 'a list -> 'a list
  val peek : 'a list -> 'a
  val pop : 'a list -> 'a list
end

(*
module type LIST_STACK =
  sig
    exception Empty
    val empty : 'a list
    val is_empty : 'a list -> bool
    val push : 'a -> 'a list -> 'a list
    val peek : 'a list -> 'a
    val pop : 'a list -> 'a list
  end
*)
```

## 关联 module 和 module type
```ocaml
module type ListStack = sig ... end

module ListStack : ListStack = struct ... end

(* module 和 module type 的命名空间是隔离的， 即便同名也是允许的 *)
```

```ocaml
module ListStackAlias : LIST_STACK = ListStack
(* equivalently *)
module ListStackAlias = (ListStack : LIST_STACK)

(* 如果不给 module type 一个名字， 裸着 sig...end 显得非常冗长 *)
module M : sig val x : int end = struct let x = 42 end
(* equivalently *)
module M = (struct let x = 42 end : sig val x : int end)
```

可以嵌套
```ocaml
module type X = sig
  val x : int
end

module type T = sig
    (* 要求 innner 是 X 类型*)
  module Inner : X
end

(* M 是 T 类型， M.Inner 满足 X 类型 *)
module M : T = struct
  module Inner : X = struct
    let x = 42
  end
end
```

## M:T 的语义
当我们在定义一个 module 时候使用 M:T， 这时候编译器提供两个保证
1. 签名匹配： T 声明的每一个名称在 M 中都有相同或者更加通用的类型定义
2. Opacity（不透明性？）： M 中定义的任何名称，如果不是出现在 T 中， 那么在 M 以外的代码不可见。


## load 和 use 的区别
- load 加载 cmo， 在 utop 引入 Mods， 需要带上 module name 来使用，比如 Mods.b 
- use 相当于将 ml 源代码在 utop 重写一次。可以直接使用 b 等名称