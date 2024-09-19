let double x = x + x
let square x = x * x

let quad x = double (double x)

let fourth x = square (square x)

(* 上述两者的共同模式
## 将一个函数应用到一个表达式两次  ##

考虑到 currying 特性， ocaml function 只接受一个参数，所以 twice 的返回相当于

fun x -> f (f x)， 返回一个匿名函数，接受一个参数，返回 f (f x)

ocaml 里面的fun 相当于其他语言的 lambda 表达式，匿名函数
*)
let twice f x = f (f x)


let apply f x = f x

let pipeline x f = f x
let (|>) = pipeline  (* |> 是一种语法糖 *)
let x = 5 |> double

let compose f g x = f (g x)
(* compose 的函数签名： 
val compose : ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b = <fun>
*)


 let square_then_double = compose double square
 (* 注意顺序： compse double square 先执行 square *)
 (* pieline 写法更加自然
 
 let square_then_double x = x |> square |> double 
 
 *)


 let both f g x = (f x, g x)
 (* both 的函数签名：
  val both : ('a -> 'b) -> ('a -> 'c) -> 'a -> 'b * 'c = <fun>
  

utop # let ds = both double square;;
val ds : int -> int * int = <fun>
─( 23:30:32 )─< command 20 >─────────────────────────────────────────────────────────────────────────────────────────────{ counter: 0 }─
utop # ds 3;;
*)

let cond p f g x =
  if p x then f x else g x

