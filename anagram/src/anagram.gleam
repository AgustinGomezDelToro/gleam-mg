import gleam/list.{filter, sort}
import gleam/string.{compare, concat, lowercase, to_graphemes}

pub fn find_anagrams(word: String, candidates: List(String)) -> List(String) {
  let original = word |> lowercase
  let word_sort = fn(w) { w |> to_graphemes |> sort(compare) |> concat }
  let sorted = original |> word_sort
  candidates
  |> filter(fn(w) {
    let new_w = lowercase(w)
    new_w != original && sorted == word_sort(new_w)
    })
}