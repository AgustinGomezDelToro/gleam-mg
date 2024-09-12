import gleam/string

const intermediate_line = "And if one green bottle should accidentally fall,\n"

pub fn recite(
  start_bottles start_bottles: Int,
  take_down take_down: Int,
) -> String {
  recite_rec(start_bottles, take_down, "")
  |> string.trim
}

fn recite_rec(bottles: Int, take_down: Int, acc: String) -> String {
  case take_down {
    0 -> acc
    _ ->
      recite_rec(
        bottles - 1,
        take_down - 1,
        acc <> generate_lyrics_from_number(bottles),
      )
  }
}

fn generate_lyrics_from_number(number: Int) -> String {
  let string_number_next = number_to_string_number(number - 1)
  let string_number =
    number
    |> number_to_string_number
    |> string.capitalise

  let first_line = case number {
    1 -> string_number <> " green bottle hanging on the wall,\n"
    _ -> string_number <> " green bottles hanging on the wall,\n"
  }

  let last_line = case number - 1 {
    1 ->
      "There'll be "
      <> string_number_next
      <> " green bottle hanging on the wall.\n\n"
    _ ->
      "There'll be "
      <> string_number_next
      <> " green bottles hanging on the wall.\n\n"
  }

  first_line <> first_line <> intermediate_line <> last_line
}

fn number_to_string_number(number: Int) -> String {
  case number {
    0 -> "no"
    1 -> "one"
    2 -> "two"
    3 -> "three"
    4 -> "four"
    5 -> "five"
    6 -> "six"
    7 -> "seven"
    8 -> "eight"
    9 -> "nine"
    // Assume that the program will only be called with numbers between 0 and 10
    _ -> "ten"
  }
}