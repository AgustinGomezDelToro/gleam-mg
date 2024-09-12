import gleam/list
import gleam/int

fn is_valid_multiple(factors) {
  fn(num) {
    factors
    |> list.any(fn(factor) { num % factor == 0 && factor > 0 })
  }
}

pub fn sum(factors factors: List(Int), limit limit: Int) -> Int {
  list.range(1, limit - 1)
  |> list.filter(is_valid_multiple(factors))
  |> int.sum
}