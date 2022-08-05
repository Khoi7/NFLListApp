//
//  TeamListView.swift
//  NFLList
//
//  Created by DuyPhung on 06/08/2022.
//

import SwiftUI

struct TeamListView: View {
    var body: some View {
        List(allTeams) { team in
            TeamRow(team: team)
        }
    }
}

struct TeamListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamListView()
    }
}
