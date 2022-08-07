/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 1
  Author: Vu Duy Khoi
  ID: s3694615
  Created  date: 29/07/2022
  Last modified: 07/08/2022
  Acknowledgement:
        https://gist.github.com/nntrn/ee26cb2a0716de0947a0a4e9a157bc1c
        https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor
        https://geocode.maps.co/
*/

import Foundation

struct AllTeams: Decodable {
    var links = [String]()
    
    enum Response: String, CodingKey {
        case items
    }
    
    enum Team: String, CodingKey {
        case ref = "$ref"
    }
        
    init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: Response.self)
        var items = try response.nestedUnkeyedContainer(forKey: .items)
        while !items.isAtEnd {
            let team = try items.nestedContainer(keyedBy: Team.self)
            let teamLink = try team.decode(String.self, forKey: .ref)
            links.append(teamLink.replacingOccurrences(of: "http://", with: "https://"))
        }
        
    }
}

func getAllTeamsLinks() -> [String] {
    let urlString = "https://sports.core.api.espn.com/v2/sports/football/leagues/nfl/teams?limit=32"
    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            do {
                let allTeams = try JSONDecoder().decode(AllTeams.self, from: data)
                return allTeams.links
            } catch {
                return [] as [String]
            }
        }
    }
    return [] as [String]
}

