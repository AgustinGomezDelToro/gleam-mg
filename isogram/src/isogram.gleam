import gleam/string.{lowercase, replace, to_graphemes}
import gleam/list.{length, unique}

pub fn is_isogram(phrase phrase: String) -> Bool {
  let graphemes =
    phrase
    |> lowercase
    |> replace(" ", "")
    |> replace("-", "")
    |> to_graphemes()

  length(graphemes) == length(unique(graphemes))
}