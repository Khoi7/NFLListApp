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

struct TeamInfoPage: View {
    let team: Team
    let color: [String:Double]
    
    init(team: Team) {
        self.team = team
        self.color = hexToRgbColor(hex: team.color
        )
    }
    
    var mapLatLng: CLLocationCoordinate2D? {
        if let latlng = getLatLngFromName(name: team.venueName) {
            return CLLocationCoordinate2D(latitude: latlng.latDouble, longitude: latlng.lonDouble)
        }
        return nil
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Color(red: color["red"]!, green: color["green"]!, blue: color["blue"]!)
                .ignoresSafeArea()
            GeometryReader { geo in
                VStack {
                    HStack {
                        Spacer()
                        TeamLogoCard(team: team)
                        Spacer()
                        VStack {
                            Text(team.displayName).foregroundColor(.white)
                                .fontWeight(.heavy)
                                .font(.system(size: 25))
                            Text("(\(team.abbreviation))").foregroundColor(.white)
                                .fontWeight(.heavy)
                                .font(.system(size: 20))
                        }
                        Spacer()
                    }
                    ScrollView(.vertical, showsIndicators: true) {
//                            RoundedRectangle(cornerRadius: 40)
//                                .frame(width: geo.size.width * 0.95, height:.)
//                                .foregroundColor(.white)
//                                .padding(.bottom, 10)
//                                .overlay(alignment: .top) {
//                                    TeamInfoCard(team: team, mapLatLng: mapLatLng!)
//                                        .padding(.top, 30)
//                                }
                        TeamInfoCard(team: team, mapLatLng: mapLatLng!)
                            .padding(.top, 30)
                            .padding(.bottom, 20)
                            .background {
                                RoundedRectangle(cornerRadius: 40)
                                    .foregroundColor(.white)
                            }
                            .frame(width:geo.size.width * 0.95)
                    }
                }
                .frame(maxWidth:.infinity, alignment: .top)
                .edgesIgnoringSafeArea(.bottom)
            }
        }
        
    }
}

struct TeamInfoPage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TeamInfoPage(team: testTeam[21])
        }
    }
}
