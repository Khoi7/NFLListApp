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
import SwiftUI

func hexToRgbColor(hex: String) -> [String:Double] {
    let scanner = Scanner(string: hex)
    var hexNumber: UInt64 = 0
    scanner.scanHexInt64(&hexNumber)
    
    let r = Double((hexNumber & 0xff0000) >> 16) / 255
    let g = Double((hexNumber & 0x00ff00) >> 8) / 255
    let b = Double((hexNumber & 0x0000ff)) / 255
    
    return ["red": r,"green": g,"blue": b]
}
