# 编译单元
compile unit 是同一目录中的一对 OCaml 源文件。它们共享相同的基本名称，称为 x，但它们的扩展名不同：一个文件是 x.ml，另一个是 x.mli。文件 x.ml 称为 implementation，x.mli 称为 interface。

foo.mli
```ocaml
val x : int
val f : int -> int
```

foo.ml
```ocaml
let x = 0
let y = 12
let f x = x + y
```

上面两个文件会被编译器处理成等价形式
```ocaml
module Foo : sig
  val x : int
  val f : int -> int
end = struct
  let x = 0
  let y = 12
  let f x = x + y
end
```

# 不完整编译
### 缺失 interface 文件
不要求 foo.ml 一定需要存在 foo.mli。编译器自动根据 implement 生成签名。可以缺少 interface 签名描述

### 缺少 implement 文件

考虑下面的 bad case。这里的 OCaml 文件组织就是不起作用。要成为编译单元，listStack.ml 的接口必须位于 listStack.mli 中。它不能位于具有任何其他名称的文件中。因此，该代码划分无法规定 ListStack:Stack。
> en: To be a compilation unit, the interface for listStack.ml must be in listStack.mli. It can’t be in a file with any other name. So there’s no way with that code division to stipulate that ListStack : Stack
```ocaml 
(********************************)
(* stack.mli *)
type 'a t
val empty : 'a t
val push : 'a -> 'a t -> 'a t
(* etc. *)

(********************************)
(* listStack.ml *)
type 'a t = 'a list
let empty = []
let push = List.cons
(* etc. *)

(********************************)
(* customStack.ml *)
(* omitted *)
```

good case
```ocaml
(********************************)
(* stack.ml *)
module type S = sig
  type 'a t
  val empty : 'a t
  val push : 'a -> 'a t -> 'a t
  (* etc. *)
end

(********************************)
(* listStack.ml *)
module M : Stack.S = struct
  type 'a t = 'a list
  let empty = []
  let push = List.cons
  (* etc. *)
end

(********************************)
(* customStack.ml *)
module M : Stack.S = struct
  (* omitted *)
end
```