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

struct MapView: View {
    let coordinate: CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion(
        )
        
    var body: some View {
        Map(coordinateRegion: $region)
            .onAppear{
                setRegion(coordinate: coordinate)
            }
    }
    
    func setRegion(coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004))
    }}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        if let latlng = getLatLngFromName(name: "Arrowhead Stadium") {
            let mapLatLng = CLLocationCoordinate2D(latitude: latlng.latDouble, longitude: latlng.lonDouble)
            MapView(coordinate: mapLatLng)
        }
        
    }
}
