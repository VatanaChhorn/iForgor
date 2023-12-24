//
//  Theme.swift
//  iForgor
//
//  Created by Vatana Chhorn on 24/12/2023.
//

import Foundation
import SwiftUI

enum Theme: CaseIterable {
    case theme1, theme2, theme3, error
    
    var headerColor: Color {
        switch self {
        case .theme1:
            return Color(hex: "F78316")
        case .theme2, .theme3, .error:
            return Color(hex: "FFFFFF")
        }
    }
    
    var textColor: Color {
        switch self {
        case .theme1:
            return Color(hex: "262D33")
        case .theme2, .theme3, .error:
            return Color(hex: "FFFFFF")
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .theme1:
            return Color(hex: "FFD980")
        case .theme2:
            return Color(hex: "6D75E7")
        case .theme3, .error:
            return Color(hex: "FF4F52")
        }
    }
}
