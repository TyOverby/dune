open Stdune

type t = Public | Private

let to_string = function
  | Public -> "public"
  | Private -> "private"

let pp fmt t = Format.pp_print_string fmt (to_string t)

let to_sexp t = Sexp.Encoder.string (to_string t)

let encode =
  let open Dune_lang.Encoder in
  function
  | Public -> string "public"
  | Private -> string "private"

let decode =
  let open Dune_lang.Decoder in
  plain_string (fun ~loc -> function
    | "public" -> Public
    | "private" -> Private
    | _ -> Errors.fail loc
             "Not a valid visibility. Valid visibility is public or private")

let is_public = function
  | Public -> true
  | Private -> false

let is_private t = not (is_public t)
