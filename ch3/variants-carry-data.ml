(* variants 类似 C enum 的用法 *)
type color = Red | Green

(* variants 可以携带数据，而不单单是定义几个枚举值 *)
type point = float * float
type shape = 
  | Point of point
  | Circle of point * float
  | Rect of point * point

(* shape functions *)
let area = function 
  | Point _ -> 0.0
  | Circle (_, r) -> Float.pi *. (r ** 2.0)
  | Rect ((x1, y1), (x2, y2)) -> begin
    let w = x2 -. x1 in
    let h = y2 -. y1 in
    w *. h
  end

let center = function
  | Point p -> p
  | Circle (p, _) -> p
  | Rect ((x1, y1), (x2, y2)) -> ((x1 +. x2) /. 2.0, (y1 +. y2) /. 2.0)

(* 递归定义 *)
type intlist = Nil | Cons of int * intlist
let lst3 = Cons (3, Nil) (* similar to 3::[] *)
let lst123 = Cons (1, Cons (2, lst3)) (* similar to 1::2::3::[] *)

(* 注意这里 :int 表示返回值类型 *)
let rec sum (lst: intlist): int = 
  match lst with
  | Nil -> 0
  | Cons (x, xs) -> x + sum xs

let rec length (lst: intlist): int =
  match lst with
  | Nil -> 0
  | Cons (_, xs) -> 1 + length xs

(* 这里是定义了binding， empty 是一个函数，类型是
intlist -> bool
 *)
let empty: intlist -> bool = function
  | Nil -> true
  | _ -> false


(* 互相递归定义 *)
type node = {value: int; next: mylist}
and mylist = Nil | Node of node