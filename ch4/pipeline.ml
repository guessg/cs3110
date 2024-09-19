let rec ( -- ) i j = 
  if i > j then [] else i :: (i + 1 -- j)

let square x = x * x

let sum = List.fold_left (+) 0

let sum_sq n =
  0 -- n
  |> List.map square
  |> sum

let sum_sq' n = 
  sum (List.map square (0 -- n))

let sum_sq'' n =
  let l = 0 -- n in
  let sq_l = List.map square l in
  sum sq_l