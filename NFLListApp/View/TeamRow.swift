//
//  TeamRow.swift
//  NFLList
//
//  Created by DuyPhung on 06/08/2022.
//

import SwiftUI

struct TeamRow: View {
    let team: Team
    var body: some View {
        HStack {
            TeamLogoRow(team: team)
            Text(team.displayName)
                .fontWeight(.bold)
                .font(.system(size: 16))
                .padding(.leading, 30)
        }
    }
}

struct TeamRow_Previews: PreviewProvider {
    static var previews: some View {
        TeamRow(team: allTeams[8])
    }
}
