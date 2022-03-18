//
//  Diamond.swift
//  SetGameApp
//
//  Created by Bridger Hildreth on 3/6/22.
//

import SwiftUI

struct Diamond: Shape {
    
    private struct DiamondRatios {
        static let widthPercentage: CGFloat = 0.15
        static let offsetPercentage: CGFloat = 0.20
        static let controlHorizontalOffsetPercentage: CGFloat = 0.10
        static let verticalControlPercentage: CGFloat = 0.40
    }
    
    func path(in rect: CGRect) -> Path {
        let leftPoint = CGPoint(x: rect.width/2.0 - (rect.width * DiamondRatios.widthPercentage/2.0), y: rect.height/2.0)
        let topPoint = CGPoint(x: rect.width/2.0, y: rect.height * DiamondRatios.offsetPercentage)
        let bottomPoint = CGPoint(x: rect.width/2.0, y: rect.height - (rect.height * DiamondRatios.offsetPercentage))
        let rightPoint = CGPoint(x: rect.width/2.0 + (rect.width * DiamondRatios.widthPercentage/2.0), y: leftPoint.y)
        
        var diamond = Path()

        diamond.move(to: topPoint)
        diamond.addLine(to: rightPoint)
        diamond.addLine(to: bottomPoint)
        diamond.addLine(to: leftPoint)
        diamond.addLine(to: topPoint)
        
        return diamond
    }
    
}
