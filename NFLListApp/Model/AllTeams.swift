//
//  TeamInfo.swift
//  NFLList
//
//  Created by DuyPhung on 04/08/2022.
//

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

