pub fn expected_minutes_in_oven() -> Int {
  40
}

pub fn remaining_minutes_in_oven(actual_minutes_in_oven: Int) -> Int {
  let expected = expected_minutes_in_oven()
  expected - actual_minutes_in_oven
}

pub fn preparation_time_in_minutes(layers: Int) -> Int {
  layers * 2
}

pub fn total_time_in_minutes(layers: Int, actual_minutes_in_oven: Int) -> Int {
  let prep_time = preparation_time_in_minutes(layers)
  prep_time + actual_minutes_in_oven
}

pub fn alarm() -> String {
  "Ding!"
}
