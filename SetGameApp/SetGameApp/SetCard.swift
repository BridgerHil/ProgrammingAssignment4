//
//  SetCard.swift
//  SetGameApp
//
//  Created by Bridger Hildreth on 3/6/22.
//

import Foundation
import SwiftUI

struct SetCard : Identifiable, Equatable {
    
    static func ==(lhs: SetCard, rhs: SetCard) -> Bool {
        return (lhs.shape == rhs.shape &&
                lhs.shade == rhs.shade &&
                lhs.color == rhs.color &&
                lhs.count == rhs.count &&
                lhs.id == rhs.id)
    }
    
    var shape: Shapes
    var shade: Shades
    var color: Colors
    var count: Int
    var id: Int
    

    var isSelected: Bool
    var isMatched: Bool
    var isMisMatched: Bool
    
    enum Shapes {
        case diamond
        case oval
        case squiggle
        
        static var all = [Shapes.diamond, .oval, .squiggle]
    }
    
    enum Shades {
        case outlined
        case striped
        case filled
        
        static var all = [Shades.outlined, .striped, .filled]
    }
    
    enum Colors {
        case red
        case green
        case blue
        
        static var all = [Colors.red, .green, .blue]
    }
    
    init(shape: Shapes, shade: Shades, color: Colors, count: Int, id: Int) {
        self.shape = shape
        self.shade = shade
        self.color = color
        self.count = count
        self.id = id
        self.isSelected = false
        self.isMatched = false
        self.isMisMatched = false
    }
    
    init(shape: Shapes, shade: Shades, color: Colors, count: Int, id: Int, isSelected: Bool, isMatched: Bool, isMisMatched: Bool) {
        self.shape = shape
        self.shade = shade
        self.color = color
        self.count = count
        self.id = id
        self.isSelected = isSelected
        self.isMatched = isMatched
        self.isMisMatched = isMisMatched

    }
}
