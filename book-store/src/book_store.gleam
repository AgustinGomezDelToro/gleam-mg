import gleam/float
import gleam/int
import gleam/list
import gleam/result

// Separate magic numbers for extensibility
const book_price = 800.0

const discount_rates = [#(1, 1.0), #(2, 0.95), #(3, 0.9), #(4, 0.8), #(5, 0.75)]

// Calculate the price of a group of books
fn rate(group_size: Int) -> Float {
  let assert Ok(r) = list.key_find(group_size, in: discount_rates)
  r *. int.to_float(group_size) *. book_price
}

fn quantity_per_title(books: List(Int)) -> List(Int) {
  books
  |> list.sort(int.compare)  // Put list in order...
  |> list.chunk(fn(n) { n }) // so `chunk` captures all copies of a given book...
  |> list.map(list.length)   // then total the number of copies of each book.
}

fn groupings(groups: List(Int), size: Int, remaining: List(Int)) -> List(Int) {
  case remaining {
    [] -> groups
    [copies] -> { // With only one title, no discout - multiple groups of one
      list.repeat(item: 1, times: copies)
      |> list.append(groups)
    }
    _ -> {
      // First, take a group of the size passed in
      let new_groups = [size, ..groups]

      let #(group, rest) =
        remaining
        |> list.sort(int.compare) // Sort largest to smallest to
        |> list.reverse           // maximize number of groups
        |> list.split(at: size)

      let remain =
        list.map(group, fn(n) { n - 1 })
        |> list.filter(fn(n) { n > 0 })
        |> list.append(rest)

      // Then, take groups from larger to smaller, if any
      case int.min(list.length(remain), size) {
        0 -> new_groups
        _ as next_size -> groupings(new_groups, next_size, remain)
      }
    }
  }
}

// Attempt all plausible largest group sizes
fn possible_groupings(quantities: List(Int)) -> List(List(Int)) {
  let n = list.length(quantities)
  list.range(from: n, to: n / 2)
  |> list.map(fn(to_take) { groupings([], to_take, quantities) })
}

// Sum the prices within each grouping, and select the smallest
fn get_lowest_price(groups: List(List(Int))) -> Float {
  groups
  |> list.map(list.map(_, rate))  // Convert to List(Float) of prices
  |> list.map(list.reduce(_, float.add)) // Sum each grouping list
  |> result.values
  |> list.reduce(float.min)
  |> result.unwrap(0.0)
}

pub fn lowest_price(books: List(Int)) -> Float {
  books
  |> quantity_per_title
  |> possible_groupings
  |> get_lowest_price
}