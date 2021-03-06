// Created by Michele Mola

import UIKit

// --- Part 1 ---
let players: [[String: Any]] = [
  ["name": "Joe Smith", "height": 42.0, "hasSoccerExperience": true, "guardianNames": "Jim and Jan Smith"],
  ["name": "Jill Tanner", "height": 36.0, "hasSoccerExperience": true, "guardianNames": "Clara Tanner"],
  ["name": "Bill Bon", "height": 43.0, "hasSoccerExperience": true, "guardianNames": "Sara and Jenny Bon"],
  ["name": "Eva Gordon", "height": 45.0, "hasSoccerExperience": false, "guardianNames": "Wendy and Mike Gordon"],
  ["name": "Matt Gill", "height": 40.0, "hasSoccerExperience": false, "guardianNames": "Charles and Sylvia Gill"],
  ["name": "Kimmy Stein", "height": 41.0, "hasSoccerExperience": false, "guardianNames": "Bill and Hillary Stein"],
  ["name": "Sammy Adams", "height": 45.0, "hasSoccerExperience": false, "guardianNames": "Jeff Adams"],
  ["name": "Karl Saygan", "height": 42.0, "hasSoccerExperience": true, "guardianNames": "Heather Bledsoe"],
  ["name": "Suzane Greenberg", "height": 44.0, "hasSoccerExperience": true, "guardianNames": "Henrietta Dumas"],
  ["name": "Sal Dali", "height": 41.0, "hasSoccerExperience": false, "guardianNames": "Gala Dali"],
  ["name": "Joe Kavalier", "height": 39.0, "hasSoccerExperience": false, "guardianNames": "Sam and Elaine Kavalier"],
  ["name": "Ben Finkelstein", "height": 44.0, "hasSoccerExperience": false, "guardianNames": "Aaron and Jill Finkelstein"],
  ["name": "Diego Soto", "height": 41.0, "hasSoccerExperience": true, "guardianNames": "Robin and Sarika Soto"],
  ["name": "Chloe Alaska", "height": 47.0, "hasSoccerExperience": false, "guardianNames": "David and Jamie Alaska"],
  ["name": "Arnold Willis", "height": 43.0, "hasSoccerExperience": false, "guardianNames": "Claire Willis"],
  ["name": "Phillip Helm", "height": 44.0, "hasSoccerExperience": true, "guardianNames": "Thomas Helm and Eva Jones"],
  ["name": "Les Clay", "height": 42.0, "hasSoccerExperience": true, "guardianNames": "Wynonna Brown"],
  ["name": "Herschel Krustofski", "height": 45.0, "hasSoccerExperience": true, "guardianNames": "Hyman and Rachel Krustofski"]
]


// --- Part 2 ---
var teamSharks = [[String: Any]]()
var teamDragons = [[String: Any]]()
var teamRaptors = [[String: Any]]()

var soccerLeague = [teamSharks, teamDragons, teamRaptors]

let teamNameAndPracticeDate = [["teamName": "Sharks", "date": "March 17, 3pm"], ["teamName": "Dragons", "date": "March 17, 1pm"], ["teamName": "Raptors", "date": "March 18, 1pm"]]
var avgHeightForTeam = Array(repeating: 0.0, count: soccerLeague.count)

var experiencedPlayers = [[String: Any]]()
var notExperiencedPlayers = [[String: Any]]()

let numberOfPlayers = players.count
let numberOfTeams = soccerLeague.count

if numberOfPlayers % numberOfTeams != 0 {
  print("Impossible to create teams with the same number of players")
}

let numberOfPlayersForTeam = numberOfPlayers / numberOfTeams

for player in players {
  // Type casting and check with guard let
  guard let isExperienced = player["hasSoccerExperience"] as? Bool else { break }
  if (isExperienced) {
    experiencedPlayers.append(player)
  } else {
    notExperiencedPlayers.append(player)
  }
}

let numberOfExperiencedPlayers = experiencedPlayers.count
let numberOfNotExperiencedPlayers = notExperiencedPlayers.count

if (numberOfExperiencedPlayers % numberOfTeams != 0 || numberOfNotExperiencedPlayers % numberOfTeams != 0) {
  print("Unbalanced teams")
}

/*
 Sort with different methods (DESC and ASC) to minimize average heights between teams. The highest experienced player will be in team with the lowest not experienced player.
*/

// Sort experienced players group for DESC
experiencedPlayers.sort(by: {
  guard let h0 = $0["height"] as? Double , let h1 = $1["height"] as? Double else { return false }
    return h0 > h1
})

// Sort not experienced players group for ASC
notExperiencedPlayers.sort(by: {
  guard let h0 = $0["height"] as? Double , let h1 = $1["height"] as? Double else { return false }
    return h1 > h0
})


/*
 Function to assign players to the teams
 I assign one player at a time to the team (Our example: First player in experieced group -> First team, Second player in experienced group -> Second team, Third player in experienced group -> Third team, Fourth player in experienced group -> First team)
*/
func assignPlayers(forGroup group: [[String: Any]]) {
  var index = 0
  for i in 0..<group.count {
    index = i % numberOfTeams == 0 ? 0 : index + 1
    soccerLeague[index].append(group[i])
  }
}

// Call function to add experieced players to the teams
assignPlayers(forGroup: experiencedPlayers)

// Call function to add not experieced players to the teams
assignPlayers(forGroup: notExperiencedPlayers)


// Average height for team
for (index, team) in soccerLeague.enumerated() {
  for player in team {
    if let height = player["height"] as? Double {
      avgHeightForTeam[index] += height
    }
  }
  avgHeightForTeam[index] /= Double(numberOfPlayersForTeam)
}


// --- Part 3 ---
var letters = [String]()

// Create letters array
for (index, team) in soccerLeague.enumerated() {
  for player in team {
    guard let name = player["name"] as? String, let guardianNames = player["guardianNames"] as? String, let teamName = teamNameAndPracticeDate[index]["teamName"], let date = teamNameAndPracticeDate[index]["date"]  else { break }
    letters.append("Name: \(name), Team Name: \(teamName), Guardian Name(s): \(guardianNames), Practice dates/times: \(date)")
  }
}

// Print letter in letters array
for (index, letter) in letters.enumerated() {
  if index % numberOfPlayersForTeam == 0 {
    guard let name = teamNameAndPracticeDate[index/numberOfPlayersForTeam]["teamName"] else { break }
    print("Team: \(name), AVG Height: \(avgHeightForTeam[index/numberOfPlayersForTeam])")
  }
  print(letter)
}




