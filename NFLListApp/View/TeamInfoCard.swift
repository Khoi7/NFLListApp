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

import SwiftUI
import MapKit

struct TeamInfoCard: View {
    let team: Team
    let mapLatLng: CLLocationCoordinate2D
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Coach: \(team.coach.fullName)")
                .fontWeight(.bold)
            Text("Location: \(team.location)")
                .fontWeight(.bold)
            Text("Venue: \(team.venueName)")
                .fontWeight(.bold)
            MapView(coordinate: mapLatLng)
                .frame(height:400)
            Link("The \(team.shortDisplayName)' home page on ESPN", destination: URL(string:team.pageLink)!)
                .padding(.top, 20)
        }
    }
}

struct TeamInfoCard_Previews: PreviewProvider {
    
    static var previews: some View {
        TeamInfoCard(team: testTeam[0], mapLatLng: CLLocationCoordinate2D(latitude: getLatLngFromName(name: testTeam[0].venueName)!.latDouble, longitude: getLatLngFromName(name: testTeam[0].venueName)!.lonDouble))
            .previewLayout(.sizeThatFits)
    }
}
