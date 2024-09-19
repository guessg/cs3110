(* curried *)
let add x y = x + y

(* uncurried *)
let add' t = fst t + snd t

let add'' (x, y) = x + y

(* 
将一个非柯里化的函数 f 转成柯里化版本
原本 f 接受 (x, y)
现在 curry f 接受 x y
*)
let curry f x y = f (x, y)

(*
uncurry f 接受 (x, y)
*)
let uncurry f (x, y) = f x y