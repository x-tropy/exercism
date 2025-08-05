import gleam/set.{type Set}
import gleam/list
import gleam/result
import gleam/string

pub fn new_collection(card: String) -> Set(String) {
  set.new()
  |> set.insert(card)
}

pub fn add_card(collection: Set(String), card: String) -> #(Bool, Set(String)) {
  case set.contains(collection, card) {
    True -> #(True, collection)
    False -> #(False, set.insert(collection, card))
  }
}

//You cannot trade a card you don't have, 
// and you shouldn't trade a card for one that you already have.
pub fn trade_card(
  my_card: String,
  their_card: String,
  collection: Set(String),
) -> #(Bool, Set(String)) {
  let tradable = !set.contains(collection, their_card)
    && set.contains(collection, my_card)

  let after_trade = collection 
  |> set.delete(my_card) 
  |> set.insert(their_card)

  #(tradable, after_trade)
}

pub fn boring_cards(collections: List(Set(String))) -> List(String) {
  collections
  |> list.reduce(fn(acc, e){
    set.intersection(acc, e)
  })
  |> result.unwrap(set.new())
  |> set.to_list
}

pub fn total_cards(collections: List(Set(String))) -> Int {
  collections
  |> list.reduce(fn(acc, e){
    set.union(acc, e)
  })
  |> result.unwrap(set.new())
  |> set.to_list
  |> list.length
}

pub fn shiny_cards(collection: Set(String)) -> Set(String) {
  collection
  |> set.filter(fn(e) {
    string.starts_with(e, "Shiny ")
  })
}
