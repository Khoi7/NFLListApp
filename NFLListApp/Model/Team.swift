//
//  Team.swift
//  NFLList
//
//  Created by DuyPhung on 05/08/2022.
//

import Foundation

struct Team: Decodable, Identifiable {
    let id: String
    let displayName: String
    let color: String
    let location: String
    let abbreviation: String
    let shortDisplayName: String
    let logoUrl: String
    let logoWidth: Int
    let logoHeight: Int
    let venueName: String
    
    enum Response: String, CodingKey {
        case id
        case displayName
        case color
        case location
        case abbreviation
        case shortDisplayName
        case logos
        case venue
    }
    
    enum Logo: String, CodingKey {
        case href
        case width
        case height
    }
    
    enum Venue: String, CodingKey {
        case fullName
    }
    
    init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: Response.self)
        id = try response.decode(String.self, forKey: .id)
        displayName = try response.decode(String.self, forKey: .displayName)
        color = try response.decode(String.self, forKey: .color)
        location = try response.decode(String.self, forKey: .location)
        abbreviation = try response.decode(String.self, forKey: .abbreviation)
        shortDisplayName = try response.decode(String.self, forKey: .shortDisplayName)
        
        var logos = try response.nestedUnkeyedContainer(forKey: .logos)
        let logo = try logos.nestedContainer(keyedBy: Logo.self)
        logoUrl = try logo.decode(String.self, forKey: .href)
        logoWidth = try logo.decode(Int.self, forKey: .width)
        logoHeight = try logo.decode(Int.self, forKey: .height)
        
        let venue = try response.nestedContainer(keyedBy: Venue.self, forKey: .venue)
        venueName = try venue.decode(String.self, forKey: .fullName)
    }
}

func getTeam(urlString: String) -> Team? {
    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            do {
                let team = try JSONDecoder().decode(Team.self, from: data)
                return team
            } catch {
                return nil
            }
        }
    }
    return nil
}

func getAllTeams() -> [Team] {
    let teamsLinks = getAllTeamsLinks()
    var teams = [Team]()
    for link in teamsLinks {
        if let team = getTeam(urlString: link) {
            teams.append(team)
        }
    }
    return teams
}

let allTeams = getAllTeams()
