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

struct TeamLogoRow: View {
    let team: Team
    var body: some View {
        AsyncImage(url: URL(string: team.logoUrl), scale: 3) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("Error loading team info")
            } else {
                ProgressView()
            }
        }
        .frame(height: 60, alignment: .center)
    }
}

struct TeamLogoCard: View {
    let team: Team
    var body: some View {
        AsyncImage(url: URL(string: team.logoUrl), scale: 3) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("Error loading team info")
            } else {
                ProgressView()
            }
        }
        .frame(height: 100, alignment: .center)
    }
}

struct TeamLogo_Previews: PreviewProvider {
    static var previews: some View {
        TeamLogoCard(team: testTeam[1])
        TeamLogoRow(team: testTeam[0])
    }
}
