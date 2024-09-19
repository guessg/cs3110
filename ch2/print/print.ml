
(* 打印字符串 *)

(* _ 表示没有绑定返回值到某个变量 *)
let _ = print_endline "hello world"

(* () 表示返回值是unit， 但是没有绑定到某个变量 *)
let () = print_endline "hello world"


(* 打印数字 *)
let _ = print_int 5;;

(* printf 
%F 表示接受浮点数
%! 表示刷新输出缓冲区
*)
let print_stat name num = 
  Printf.printf "%s: %F\n%!"  name num;;

(** [print_stat name num] prints [name: num]. *)
let print_stat name num =
  print_string name;
  print_string ": ";
  print_float num;
  print_newline ()