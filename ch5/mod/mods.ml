let b = "bigred"
let inc x = x + 1
module M = struct
  let y = 42
end


(*
1. ocamlc -c mods.ml, 生成 mods.cmo
2. utop 中 #load "mods.cmo";; 加载 mods.cmo
3. open Mods;; 打开 Mods 模块, 如此可以直接引用 inc 等名称了   
*)