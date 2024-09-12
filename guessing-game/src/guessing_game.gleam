pub fn reply(guess: Int) -> String {
  case guess {
    42 -> "Correct"
    i if i > 43 -> "Too high"
    i if i < 41 -> "Too low"
    _ -> "So close"
  }
}