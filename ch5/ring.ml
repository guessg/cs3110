module type Ring = sig
  type t
  val zero : t
  val one : t
  val ( + ) : t -> t -> t
  val ( * ) : t -> t -> t
  val ( ~- ) : t -> t  (* additive inverse *) (* 波浪线表示一元运算*)
  val to_string : t -> string
end


module IntRing : Ring = struct
  type t = int
  let zero = 0
  let one = 1
  let ( + ) = Stdlib.( + )
  let ( * ) = Stdlib.( * )
  let ( ~- ) = Stdlib.( ~- )
  let to_string = string_of_int
end

module FloatRing : Ring = struct
  type t = float
  let zero = 0.
  let one = 1.
  let ( + ) = Stdlib.( +. )
  let ( * ) = Stdlib.( *. )
  let ( ~- ) = Stdlib.( ~-. )
  let to_string = string_of_float
end

(* 第二种约束写法： 公开 t 是 int 

语法：
T with type x = t

T with module M = N  // 用于指定两个模块中所有类型的相等性

T with constraint1 and constraint2 and ... constraintN


*)
module type INT_RING = Ring with type t = int


module IntRing : INT_RING = struct
  type t = int
  let zero = 0
  let one = 1
  let ( + ) = Stdlib.( + )
  let ( * ) = Stdlib.( * )
  let ( ~- ) = Stdlib.( ~- )
  let to_string = string_of_int
end


module type FLOAT_RING = Ring with type t = float

module FloatRing : FLOAT_RING = struct
  type t = float
  let zero = 0.
  let one = 1.
  let ( + ) = Stdlib.( +. )
  let ( * ) = Stdlib.( *. )
  let ( ~- ) = Stdlib.( ~-. )
  let to_string = string_of_float
end


module type XY = sig
  type x
  type y
end

module type T = sig
  module A : XY
end

module B = struct
  type x = int
  type y = float
end

module type U = T with module A = B
(* U 是 T module， 同时指明 T 里面的 A module 是 B, 

因此， U module 相当于

module type U = sig
  type x = int
  type y = float
end

*)

module C : U = struct
  module A = struct
    type x = int
    type y = float
    let x = 42
  end
end