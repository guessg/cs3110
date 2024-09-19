module ListStack = struct 
  let empty = []
  let is_empty = function
    | [] -> true
    | _ -> false

    let push x s = x :: s

    exception Empty

    let peek = function
      | [] -> raise Empty
      | x :: _ -> x
    
    let pop = function
      | [] -> raise Empty
      | _ :: s -> s
end

(*
module ListStack :
  sig
    val empty : 'a list
    val is_empty : 'a list -> bool
    val push : 'a -> 'a list -> 'a list
    exception Empty
    val peek : 'a list -> 'a
    val pop : 'a list -> 'a list
  end   
*)

let _ = ListStack.(push 2 (push 1 empty))
(*
- : int list = [2; 1]   
*)

let _ = ListStack.(empty |> push 3 |> push 2 |> push 1)
(*
- : int list = [1; 2; 3]
*)


(*
module scope 和 open   

*)

module M = struct
  let x = 42
end
(*
不可以直接访问 x， 而是通过 M.x 来访问
utop # module M = struct
  let x = 42
end;;
module M : sig val x : int end
─( 23:43:59 )─< command 6 >──────────────────────────────────────────────────────────────────{ counter: 0 }─
utop # M.x;;
- : int = 42
─( 23:45:58 )─< command 7 >──────────────────────────────────────────────────────────────────{ counter: 0 }─
utop # open M;;
─( 23:46:02 )─< command 8 >──────────────────────────────────────────────────────────────────{ counter: 0 }─
utop # x;;
- : int = 42
*)

(*
open 相当于 C++ 中的 using namespace， 将模块中的所有定义引入到当前的作用域中

Stdlib 是永远 open 的 module， 所以可以直接使用 List, Array, String 等
*)

module M = struct
  open List

  let uppercase_all = map String.uncapitalize_ascii
end

let lower_trim s = 
  let open String in 
  s |> trim |> lowercase_ascii


(*
 module type 定义
 
 module struct 在系统里会被自动推导出一个 sig， 我们也可以自己手动定义一个 sig
*)

module type LIST_STACK = sig
  (** [Empty] is raised when an operation cannot be applied
      to an empty stack. *)
  exception Empty

  (** [empty] is the empty stack. *)
  val empty : 'a list

  (** [is_empty s] is whether [s] is empty. *)
  val is_empty : 'a list -> bool

  (** [push x s] pushes [x] onto the top of [s]. *)
  val push : 'a -> 'a list -> 'a list

  (** [peek s] is the top element of [s].
      Raises [Empty] if [s] is empty. *)
  val peek : 'a list -> 'a

  (** [pop s] is all but the top element of [s].
      Raises [Empty] if [s] is empty. *)
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

(*
  将 module 和 module type 关联起来   

module type ListStack = sig ... end
module ListStack : ListStack = struct ... end
*)

module ListStack : LIST_STACK = struct
  let empty = []
  let is_empty = function
    | [] -> true
    | _ -> false

  let push x s = x :: s

  exception Empty

  let peek = function
    | [] -> raise Empty
    | x :: _ -> x

  let pop = function
    | [] -> raise Empty
    | _ :: s -> s
end
(*
utop # module ListStack : LIST_STACK = struct
  let empty = []
  let is_empty = function
    | [] -> true
    | _ -> false

  let push x s = x :: s

  exception Empty

  let peek = function
    | [] -> raise Empty
    | x :: _ -> x

  let pop = function
    | [] -> raise Empty
    | _ :: s -> s
end;;
module ListStack : LIST_STACK 
*)