let extract o =
  match o with 
  | Some x -> string_of_int x
  | None -> ""


let rec lst_max = function 
  | [] -> None
  | h::t -> begin
    (* recursive here to the last level and return from buttom *)
    match lst_max t with
      | None -> Some h
      | Some m  -> Some (max h m)
  end

let max_e = lst_max [1;2;3]
