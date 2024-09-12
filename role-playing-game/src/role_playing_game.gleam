import gleam/option.{type Option}

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  case player.name {
    option.Some(n) -> n
    option.None -> "Mighty Magician"
  }
}

pub fn revive(player: Player) -> Option(Player) {
  case player {
    Player(health: h, ..) if h > 0 -> option.None
    Player(level: l, ..) if l >= 10 ->
      option.Some(Player(..player, mana: option.Some(100), health: 100))
    _ -> option.Some(Player(..player, mana: option.None, health: 100))
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player.mana {
    option.None -> #(
      Player(..player, health: max_health(player.health, cost)),
      0,
    )
    option.Some(m) if m > cost -> #(
      Player(..player, mana: option.Some(m - cost)),
      cost * 2,
    )
    _ -> #(player, 0)
  }
}

fn max_health(cur_health: Int, damage: Int) -> Int {
  case cur_health - damage {
    a if a >= 0 -> a
    _ -> 0
  }
}