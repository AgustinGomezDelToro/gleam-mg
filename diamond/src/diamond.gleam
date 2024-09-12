import gleam/string
import gleam/list
import gleam/order
import gleam/pair
import gleam/result

pub fn build(letter: String) -> String {
  let letters = get_letters(letter)
  let top_half = build_top_half(letters)
  let bottom_half = list.reverse(top_half) |> list.rest |> result.unwrap([])

  top_half
  |> list.append(bottom_half)
  |> string.join(with: "\n")
}

fn get_letters(letter: String) -> List(String) {
  let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
  list.split_while(alphabet, fn(char) {
     string.compare(char, letter) == order.Eq
     || string.compare(char, letter) == order.Lt
    })
    |> pair.first
}

fn build_top_half(letters: List(String)) -> List(String) {
  let list_length = list.length(letters)
  let width = list_length * 2 - 1
  letters
  |> list.index_map(fn(l, i) {
    case i {
      0 -> l
            |> string.pad_left(to: {width + 1} / 2, with: " ")
            |> string.pad_right(to: width, with: " ")
      i -> { l <> string.repeat(" ", i * 2 - 1) <> l }
            |> string.pad_left(to: width - {list_length - 1 - i}, with: " ")
            |> string.pad_right(to: width, with: " ")
    }
  })
}