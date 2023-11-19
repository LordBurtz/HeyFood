//
//  ColorAssets.swift
//  leFood
//
//  Created by Fridolin Karger on 18.11.23.
//

import SwiftUI

enum ColorAssets: String {
    case greenCB = "GreenCB"
    case green58 = "Green58"
    case green2A = "Green2A"
    case green92 = "Green92"
    case green0F = "Green0F"
    case green06 = "Green06"
    case green5F = "Green5F"
    
    case grayCB = "GrayDB"
    case grayC4 = "GrayC4"
    case grayA3 = "GrayA3"
    
    var color: Color {
        Color.init(self.rawValue, bundle: .main)
//        switch self {
//        case .greenCB:
//            return Color.init(self.rawValue, bundle: .main)
//        case .green58:
//            return Color.init(self.rawValue, bundle: .main)
//        case .green2A:
//            return Color.init(self.rawValue, bundle: .main)
//        case .green92:
//            return Color.init(self.rawValue, bundle: .main)
//        case .green0F:
//            return Color.init(self.rawValue, bundle: .main)
//        case .grayC4:
//            return Color.init(self.rawValue, bundle: .main)
//        case .grayCB:
//            return Color.init(self.rawValue, bundle: .main)
//        }
    }
}
