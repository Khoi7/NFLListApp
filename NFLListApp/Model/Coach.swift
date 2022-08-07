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

struct CoachLinks: Decodable {
    let link: String
    
    enum Response: String, CodingKey {
        case items
    }
    
    enum CoachLink: String, CodingKey {
        case href = "$ref"
    }
    
    init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: Response.self)
        var items = try response.nestedUnkeyedContainer(forKey: .items)
        let coachLink = try items.nestedContainer(keyedBy: CoachLink.self)
        var tempLink = try coachLink.decode(String.self, forKey: .href)
        tempLink = tempLink.replacingOccurrences(of: "http://", with: "https://")
        link = tempLink
    }
}

struct Coach: Codable {
    let firstName: String
    let lastName: String
    var fullName: String {
        firstName + " " + lastName
    }
}

func getCoachesLinks(urlString: String) -> CoachLinks?{
    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            do {
                let links = try JSONDecoder().decode(CoachLinks.self, from: data)
                return links
            } catch {
                return nil
            }
        }
    }
    return nil
}

func getCoach(urlString: String) -> Coach? {
    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            do {
                let coach = try JSONDecoder().decode(Coach.self, from: data)
                return coach
            } catch {
                return nil
            }
        }
    }
    return nil
}
