//
//  ImageSize.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 04/09/2025.
//

import Foundation

enum ImageSize {
    case xxsmall, xsmall, small, medium, large, xlarge, xxlarge, xxxlarge
    
    var size : CGFloat {
        switch self {
        case .xxsmall:
            25
        case .xsmall:
            32
        case .small:
            48
        case .medium:
            60
        case .large:
            72
        case .xlarge:
            84
        case .xxlarge:
            96
        case .xxxlarge:
            136
        }
    }
}
