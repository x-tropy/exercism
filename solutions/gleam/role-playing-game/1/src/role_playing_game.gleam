import gleam/option.{type Option}
import gleam/int

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  option.unwrap(player.name, "Mighty Magician")
}

pub fn revive(player: Player) -> Option(Player) {
  case player.health, player.level >= 10 {
    0, True -> option.Some(Player(..player, health: 100, mana: option.Some(100)))
    0, False -> option.Some(Player(..player, health: 100))
    _, _ -> option.None
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player.mana {
    option.None -> #(Player(..player, health: int.max(player.health - cost, 0)), 0)
    option.Some(mana) -> {
      case mana >= cost {
        True -> #(Player(..player, mana: option.Some(mana - cost)), cost * 2)
        False -> #(player, 0)
      }
    }
  }
}
