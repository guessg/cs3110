(* 类似 C 语言的 enum 
type t = C1 | ... | Cn
t 是类型名， 必须小些
C1, Cn 是所谓的constructor, 必须大写开头。
相关的， module 名必须是大写开头。
*)
type day = Sun | Mon | Tue | Wed | Thu | Fri | Sat
let int_of_day d =
  match d with
  | Sun -> 1
  | Mon -> 2
  | Tue -> 3
  | Wed -> 4
  | Thu -> 5
  | Fri -> 6
  | Sat -> 7
