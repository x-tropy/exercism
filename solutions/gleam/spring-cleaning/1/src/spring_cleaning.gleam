import gleam/string

pub fn extract_error(problem: Result(a, b)) -> b {
  let assert Error(s) = problem
  s
}

pub fn remove_team_prefix(team: String) -> String {
  case string.starts_with(team, "Team ") {
    True -> string.drop_start(team, 5)
    False -> team
  }
}

pub fn split_region_and_team(combined: String) -> #(String, String) {
  let assert [region, team] = string.split(combined, ",")
  #(region, remove_team_prefix(team))
}
