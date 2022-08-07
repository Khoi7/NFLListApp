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

struct LocationLatLng: Codable{
    let lat: String
    let lon: String
    var latDouble: Double {
        (lat as NSString).doubleValue
    }
    var lonDouble: Double {
        (lon as NSString).doubleValue
    }
}

func getLatLngFromName(name: String) -> LocationLatLng? {
    let nameConverted = name.replacingOccurrences(of: " ", with: "%20")
    let urlString = "https://geocode.maps.co/search?q=\(nameConverted)"
    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            do {
                let latLng = try JSONDecoder().decode([LocationLatLng].self, from: data)
                return latLng[0]
            } catch {
                return nil
            }
        }
    }
    return nil
}
