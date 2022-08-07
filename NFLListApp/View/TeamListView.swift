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

struct TeamListView: View {
    let teamList: [Team]
    var body: some View {
        NavigationView {
            List(allTeams) { team in
                NavigationLink {
                    TeamInfoPage(team: team)
                } label: {
                    TeamRow(team: team)
                }
            }
            .navigationTitle("NFL Teams")
        }
    }
}

struct TeamListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamListView(teamList: testTeam)
    }
}
