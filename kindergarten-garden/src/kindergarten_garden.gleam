import gleam/string
import gleam/result
import gleam/list

pub type Student {
  Alice
  Bob
  Charlie
  David
  Eve
  Fred
  Ginny
  Harriet
  Ileana
  Joseph
  Kincaid
  Larry
}

pub type Plant {
  Radishes
  Clover
  Violets
  Grass
}

pub fn plants(diagram: String, student: Student) -> List(Plant) {
  let student_index_in_row = student_number(student) * 2

  case diagram
  |> string.split("\n")
  |> list.fold("", fn(acc, row) { string.append(acc, string.slice(row, student_index_in_row, 2)) })
  |> string.split("")
  |> list.try_map(diagram_to_plant) {
    Ok(plants) -> plants
    Error(_) -> []
  }
}

fn diagram_to_plant(diagram: String) -> Result(Plant, Nil) {
  case diagram {
    "R" -> Ok(Radishes)
    "C" -> Ok(Clover)
    "V" -> Ok(Violets)
    "G" -> Ok(Grass)
    _ -> Error(Nil)
  }
}

fn student_number(student: Student) -> Int {
  case student {
    Alice -> 0
    Bob -> 1
    Charlie -> 2
    David -> 3
    Eve -> 4
    Fred -> 5
    Ginny -> 6
    Harriet -> 7
    Ileana -> 8
    Joseph -> 9
    Kincaid -> 10
    Larry -> 11
  }
}