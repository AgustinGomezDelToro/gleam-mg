import gleam/order.{type Order}
import gleam/float
import gleam/list

pub type City {
  City(name: String, temperature: Temperature)
}

pub type Temperature {
  Celsius(Float)
  Fahrenheit(Float)
}

pub fn fahrenheit_to_celsius(f: Float) -> Float {
  {f -. 32.0} /. 1.8
}

fn temperature_to_celcius(t: Temperature) -> Float {
  case t {
    Celsius(t) -> t
    Fahrenheit(t) -> fahrenheit_to_celsius(t)
  }
}

pub fn compare_temperature(left: Temperature, right: Temperature) -> Order {
  float.compare(temperature_to_celcius(left), temperature_to_celcius(right))
}

pub fn sort_cities_by_temperature(cities: List(City)) -> List(City) {
  list.sort(cities, fn(city1, city2){
    compare_temperature(city1.temperature, city2.temperature)
  })
}