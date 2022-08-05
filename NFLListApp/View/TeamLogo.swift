//
//  TeamLogo.swift
//  NFLList
//
//  Created by DuyPhung on 06/08/2022.
//

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

struct TeamLogo_Previews: PreviewProvider {
    static var previews: some View {
        TeamLogoRow(team: allTeams[0])
    }
}
