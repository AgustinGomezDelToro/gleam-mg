import gleam/list.{type ContinueOrStop}
import gleam/string
import gleam/queue.{type Queue}

const bracket_characters = ["(", ")", "[", "]", "{", "}"]


pub fn is_paired(value: String) -> Bool {
  let input =
    value
    |> prepare_input
    |> string.to_graphemes

  is_balanced(input)
}

fn prepare_input(input: String) -> String {
  input
  |> string.split("")
  |> list.filter(is_bracket)
  |> string.join("")
}

fn is_bracket(char: String) -> Bool {
  list.contains(bracket_characters, char)
}

fn is_balanced(characters: List(String)) -> Bool {
    characters
    |> list.fold_until(queue.new(), fn(acc, c) { check_balance(c, acc) })
    |> queue.length == 0
}

fn check_balance(
  input: String,
  stack: Queue(String),
) -> ContinueOrStop(Queue(String)) {
  case is_opening(input) {
    True -> list.Continue(queue.push_front(stack, input))
    _ -> {
      case queue.pop_front(stack) {
        Ok(#(top, rest)) -> {
          case closing_bracket(top) {
            t if t == input -> list.Continue(rest)
            _ -> list.Stop(stack)
          }
        }
        Error(_) -> list.Stop(queue.push_front(stack, input))
      }
    }
  }
}

fn is_opening(bracket: String) -> Bool {
  bracket == "(" || bracket == "[" || bracket == "{"
}

fn closing_bracket(bracket: String) -> String {
  case bracket {
    "(" -> ")"
    "[" -> "]"
    "{" -> "}"
    _ -> ""
  }
}