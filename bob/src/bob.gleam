import gleam/string

pub fn hey(remark: String) -> String {
  let remark = string.trim(remark)
  case
    string.ends_with(remark, "?"),
    string.uppercase(remark) == remark && string.lowercase(remark) != remark,
    string.is_empty(remark)
  {
    True, True, _ -> "Calm down, I know what I'm doing!"
    True, _, _ -> "Sure."
    _, True, _ -> "Whoa, chill out!"
    _, _, True -> "Fine. Be that way!"
    _, _, _ -> "Whatever."
  }
}