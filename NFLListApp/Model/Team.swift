//
//  Team.swift
//  NFLList
//
//  Created by DuyPhung on 05/08/2022.
//

import Foundation

// MARK: Team struct
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
    let pageLink: String
    let coach: Coach
    
    
    // MARK: Manual decoding
    enum Response: String, CodingKey {
        case id
        case displayName
        case color
        case location
        case abbreviation
        case shortDisplayName
        case logos
        case venue
        case links
        case firstCoaches = "coaches"
    }
    
    enum Logo: String, CodingKey {
        case href
        case width
        case height
    }
    
    enum Venue: String, CodingKey {
        case fullName
    }
    
    enum PageLink: String, CodingKey {
        case href
    }
    
    enum FirstCoaches: String, CodingKey {
        case href = "$ref"
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
        
        var links = try response.nestedUnkeyedContainer(forKey: .links)
        let pageLink = try links.nestedContainer(keyedBy: PageLink.self)
        self.pageLink = try pageLink.decode(String.self, forKey: .href)
        
        let firstCoaches = try response.nestedContainer(keyedBy: FirstCoaches.self, forKey: .firstCoaches)
        var firstCoachesLink = try firstCoaches.decode(String.self, forKey: .href)
        firstCoachesLink = firstCoachesLink.replacingOccurrences(of: "http://", with: "https://")
        let secondCoachLink = getCoachesLinks(urlString: firstCoachesLink)!
        coach = getCoach(urlString: secondCoachLink.link)!
    }
    
    init(id: String, displayName: String, color: String, location: String, abbreviation: String, shortDisplayName: String, logoUrl: String, logoWidth: Int, logoHeight: Int, venueName: String, pageLink: String, coach: Coach) {
        self.id = id
        self.displayName = displayName
        self.color = color
        self.location = location
        self.abbreviation = abbreviation
        self.shortDisplayName = shortDisplayName
        self.logoUrl = logoUrl
        self.logoWidth = logoWidth
        self.logoHeight = logoHeight
        self.venueName = venueName
        self.pageLink = pageLink
        self.coach = coach
    }
}

// MARK: Get team info functions
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

// MARK: DELETE THIS PART!!
let testTeam = [Team(id: "1", displayName: "Atlanta Falcons", color: "000000", location: "Atlanta", abbreviation: "ATL", shortDisplayName: "Falcons", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/atl.png", logoWidth: 500, logoHeight: 500, venueName: "Mercedes-Benz Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/atl/atlanta-falcons", coach: NFLList.Coach(firstName: "Arthur", lastName: "Smith")), NFLList.Team(id: "2", displayName: "Buffalo Bills", color: "04407F", location: "Buffalo", abbreviation: "BUF", shortDisplayName: "Bills", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/buf.png", logoWidth: 500, logoHeight: 500, venueName: "Highmark Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/buf/buffalo-bills", coach: NFLList.Coach(firstName: "Sean", lastName: "McDermott")), NFLList.Team(id: "3", displayName: "Chicago Bears", color: "152644", location: "Chicago", abbreviation: "CHI", shortDisplayName: "Bears", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/chi.png", logoWidth: 500, logoHeight: 500, venueName: "Soldier Field", pageLink: "https://www.espn.com/nfl/team/_/name/chi/chicago-bears", coach: NFLList.Coach(firstName: "Matt", lastName: "Eberflus")), NFLList.Team(id: "4", displayName: "Cincinnati Bengals", color: "FF2700", location: "Cincinnati", abbreviation: "CIN", shortDisplayName: "Bengals", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/cin.png", logoWidth: 500, logoHeight: 500, venueName: "Paul Brown Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/cin/cincinnati-bengals", coach: NFLList.Coach(firstName: "Zac", lastName: "Taylor")), NFLList.Team(id: "5", displayName: "Cleveland Browns", color: "4C230E", location: "Cleveland", abbreviation: "CLE", shortDisplayName: "Browns", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/cle.png", logoWidth: 500, logoHeight: 500, venueName: "FirstEnergy Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/cle/cleveland-browns", coach: NFLList.Coach(firstName: "Kevin", lastName: "Stefanski")), NFLList.Team(id: "6", displayName: "Dallas Cowboys", color: "002E4D", location: "Dallas", abbreviation: "DAL", shortDisplayName: "Cowboys", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/dal.png", logoWidth: 500, logoHeight: 500, venueName: "AT&T Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/dal/dallas-cowboys", coach: NFLList.Coach(firstName: "Mike", lastName: "McCarthy")), NFLList.Team(id: "7", displayName: "Denver Broncos", color: "002E4D", location: "Denver", abbreviation: "DEN", shortDisplayName: "Broncos", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/den.png", logoWidth: 500, logoHeight: 500, venueName: "Empower Field at Mile High", pageLink: "https://www.espn.com/nfl/team/_/name/den/denver-broncos", coach: NFLList.Coach(firstName: "Nathaniel", lastName: "Hackett")), NFLList.Team(id: "8", displayName: "Detroit Lions", color: "035C98", location: "Detroit", abbreviation: "DET", shortDisplayName: "Lions", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/det.png", logoWidth: 500, logoHeight: 500, venueName: "Ford Field", pageLink: "https://www.espn.com/nfl/team/_/name/det/detroit-lions", coach: NFLList.Coach(firstName: "Dan", lastName: "Campbell")), NFLList.Team(id: "9", displayName: "Green Bay Packers", color: "204E32", location: "Green Bay", abbreviation: "GB", shortDisplayName: "Packers", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/gb.png", logoWidth: 500, logoHeight: 500, venueName: "Lambeau Field", pageLink: "https://www.espn.com/nfl/team/_/name/gb/green-bay-packers", coach: NFLList.Coach(firstName: "Matt", lastName: "LaFleur")), NFLList.Team(id: "10", displayName: "Tennessee Titans", color: "2F95DD", location: "Tennessee", abbreviation: "TEN", shortDisplayName: "Titans", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/ten.png", logoWidth: 500, logoHeight: 500, venueName: "Nissan Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/ten/tennessee-titans", coach: NFLList.Coach(firstName: "Mike", lastName: "Vrabel")), NFLList.Team(id: "11", displayName: "Indianapolis Colts", color: "00417E", location: "Indianapolis", abbreviation: "IND", shortDisplayName: "Colts", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/ind.png", logoWidth: 500, logoHeight: 500, venueName: "Lucas Oil Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/ind/indianapolis-colts", coach: NFLList.Coach(firstName: "Frank", lastName: "Reich")), NFLList.Team(id: "12", displayName: "Kansas City Chiefs", color: "BE1415", location: "Kansas City", abbreviation: "KC", shortDisplayName: "Chiefs", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/kc.png", logoWidth: 500, logoHeight: 500, venueName: "GEHA Field at Arrowhead Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/kc/kansas-city-chiefs", coach: NFLList.Coach(firstName: "Andy", lastName: "Reid")), NFLList.Team(id: "13", displayName: "Las Vegas Raiders", color: "000000", location: "Las Vegas", abbreviation: "LV", shortDisplayName: "Raiders", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/lv.png", logoWidth: 500, logoHeight: 500, venueName: "Allegiant Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/lv/las-vegas-raiders", coach: NFLList.Coach(firstName: "Josh", lastName: "McDaniels")), NFLList.Team(id: "14", displayName: "Los Angeles Rams", color: "00295B", location: "Los Angeles", abbreviation: "LAR", shortDisplayName: "Rams", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/lar.png", logoWidth: 500, logoHeight: 500, venueName: "Los Angeles Memorial Coliseum", pageLink: "https://www.espn.com/nfl/team/_/name/lar/los-angeles-rams", coach: NFLList.Coach(firstName: "Sean", lastName: "McVay")), NFLList.Team(id: "15", displayName: "Miami Dolphins", color: "006B79", location: "Miami", abbreviation: "MIA", shortDisplayName: "Dolphins", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/mia.png", logoWidth: 500, logoHeight: 500, venueName: "Hard Rock Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/mia/miami-dolphins", coach: NFLList.Coach(firstName: "Mike", lastName: "McDaniel")), NFLList.Team(id: "16", displayName: "Minnesota Vikings", color: "240A67", location: "Minnesota", abbreviation: "MIN", shortDisplayName: "Vikings", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/min.png", logoWidth: 500, logoHeight: 500, venueName: "U.S. Bank Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/min/minnesota-vikings", coach: NFLList.Coach(firstName: "Kevin", lastName: "O\'Connell")), NFLList.Team(id: "17", displayName: "New England Patriots", color: "02244A", location: "New England", abbreviation: "NE", shortDisplayName: "Patriots", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/ne.png", logoWidth: 500, logoHeight: 500, venueName: "Gillette Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/ne/new-england-patriots", coach: NFLList.Coach(firstName: "Bill", lastName: "Belichick")), NFLList.Team(id: "18", displayName: "New Orleans Saints", color: "020202", location: "New Orleans", abbreviation: "NO", shortDisplayName: "Saints", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/no.png", logoWidth: 500, logoHeight: 500, venueName: "Caesars Superdome", pageLink: "https://www.espn.com/nfl/team/_/name/no/new-orleans-saints", coach: NFLList.Coach(firstName: "Dennis", lastName: "Allen")), NFLList.Team(id: "19", displayName: "New York Giants", color: "052570", location: "New York", abbreviation: "NYG", shortDisplayName: "Giants", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/nyg.png", logoWidth: 500, logoHeight: 500, venueName: "MetLife Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/nyg/new-york-giants", coach: NFLList.Coach(firstName: "Brian", lastName: "Daboll")), NFLList.Team(id: "20", displayName: "New York Jets", color: "174032", location: "New York", abbreviation: "NYJ", shortDisplayName: "Jets", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/nyj.png", logoWidth: 500, logoHeight: 500, venueName: "MetLife Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/nyj/new-york-jets", coach: NFLList.Coach(firstName: "Robert", lastName: "Saleh")), NFLList.Team(id: "21", displayName: "Philadelphia Eagles", color: "06424D", location: "Philadelphia", abbreviation: "PHI", shortDisplayName: "Eagles", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/phi.png", logoWidth: 500, logoHeight: 500, venueName: "Lincoln Financial Field", pageLink: "https://www.espn.com/nfl/team/_/name/phi/philadelphia-eagles", coach: NFLList.Coach(firstName: "Nick", lastName: "Sirianni")), NFLList.Team(id: "22", displayName: "Arizona Cardinals", color: "A40227", location: "Arizona", abbreviation: "ARI", shortDisplayName: "Cardinals", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/ari.png", logoWidth: 500, logoHeight: 500, venueName: "State Farm Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/ari/arizona-cardinals", coach: NFLList.Coach(firstName: "Kliff", lastName: "Kingsbury")), NFLList.Team(id: "23", displayName: "Pittsburgh Steelers", color: "000000", location: "Pittsburgh", abbreviation: "PIT", shortDisplayName: "Steelers", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/pit.png", logoWidth: 500, logoHeight: 500, venueName: "Acrisure Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/pit/pittsburgh-steelers", coach: NFLList.Coach(firstName: "Mike", lastName: "Tomlin")), NFLList.Team(id: "24", displayName: "Los Angeles Chargers", color: "042453", location: "Los Angeles", abbreviation: "LAC", shortDisplayName: "Chargers", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/lac.png", logoWidth: 500, logoHeight: 500, venueName: "Dignity Health Sports Park", pageLink: "https://www.espn.com/nfl/team/_/name/lac/los-angeles-chargers", coach: NFLList.Coach(firstName: "Brandon", lastName: "Staley")), NFLList.Team(id: "25", displayName: "San Francisco 49ers", color: "981324", location: "San Francisco", abbreviation: "SF", shortDisplayName: "49ers", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/sf.png", logoWidth: 500, logoHeight: 500, venueName: "Levi\'s Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/sf/san-francisco-49ers", coach: NFLList.Coach(firstName: "Kyle", lastName: "Shanahan")), NFLList.Team(id: "26", displayName: "Seattle Seahawks", color: "224970", location: "Seattle", abbreviation: "SEA", shortDisplayName: "Seahawks", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/sea.png", logoWidth: 500, logoHeight: 500, venueName: "Lumen Field", pageLink: "https://www.espn.com/nfl/team/_/name/sea/seattle-seahawks", coach: NFLList.Coach(firstName: "Pete", lastName: "Carroll")), NFLList.Team(id: "27", displayName: "Tampa Bay Buccaneers", color: "A80D08", location: "Tampa Bay", abbreviation: "TB", shortDisplayName: "Buccaneers", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/tb.png", logoWidth: 500, logoHeight: 500, venueName: "Raymond James Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/tb/tampa-bay-buccaneers", coach: NFLList.Coach(firstName: "Todd", lastName: "Bowles")), NFLList.Team(id: "28", displayName: "Washington Commanders", color: "650415", location: "Washington", abbreviation: "WSH", shortDisplayName: "Commanders", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/wsh.png", logoWidth: 500, logoHeight: 500, venueName: "FedExField", pageLink: "https://www.espn.com/nfl/team/_/name/wsh/washington-commanders", coach: NFLList.Coach(firstName: "Ron", lastName: "Rivera")), NFLList.Team(id: "29", displayName: "Carolina Panthers", color: "2177B0", location: "Carolina", abbreviation: "CAR", shortDisplayName: "Panthers", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/car.png", logoWidth: 500, logoHeight: 500, venueName: "Bank of America Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/car/carolina-panthers", coach: NFLList.Coach(firstName: "Matt", lastName: "Rhule")), NFLList.Team(id: "30", displayName: "Jacksonville Jaguars", color: "00839C", location: "Jacksonville", abbreviation: "JAX", shortDisplayName: "Jaguars", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/jax.png", logoWidth: 500, logoHeight: 500, venueName: "TIAA Bank Field", pageLink: "https://www.espn.com/nfl/team/_/name/jax/jacksonville-jaguars", coach: NFLList.Coach(firstName: "Doug", lastName: "Pederson")), NFLList.Team(id: "33", displayName: "Baltimore Ravens", color: "2B025B", location: "Baltimore", abbreviation: "BAL", shortDisplayName: "Ravens", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/bal.png", logoWidth: 500, logoHeight: 500, venueName: "M&T Bank Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/bal/baltimore-ravens", coach: NFLList.Coach(firstName: "John", lastName: "Harbaugh")), NFLList.Team(id: "34", displayName: "Houston Texans", color: "00133F", location: "Houston", abbreviation: "HOU", shortDisplayName: "Texans", logoUrl: "https://a.espncdn.com/i/teamlogos/nfl/500/hou.png", logoWidth: 500, logoHeight: 500, venueName: "NRG Stadium", pageLink: "https://www.espn.com/nfl/team/_/name/hou/houston-texans", coach: NFLList.Coach(firstName: "Lovie", lastName: "Smith"))]

