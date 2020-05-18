//
//  ActivityIndicatorView.swift
//  ActivityIndicator
//
//  Created by Carlos De la Mora on 3/25/20.
//  Copyright © 2020 Carlos De la Mora. All rights reserved.
//

import SwiftUI

struct ActivityIndicatorView: View {
    let numberOfPetals = 12
    var duration = 0.1
    @State var animationParameter = 0
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<self.numberOfPetals) { i in
                PetalView(duration: self.duration,
                          positionNumber: i,
                          numberOfPetals: self.numberOfPetals,
                          animationParameter: self.$animationParameter)
                    .rotationEffect(self.angle(for:i))
                    .position(self.petalPosition(for: i, size: geometry.size))
            }
        }.frame(width: 200, height: 200)
        .onAppear {
            self.changeRotation()
        }
    }
    
    func angle(for i: Int)-> Angle {
        return Angle(radians: 2*Double(-i)*Double.pi/Double(numberOfPetals))
    }
    
    private func scale(_ size: CGSize) -> CGFloat {
        let theta = 2*CGFloat.pi/CGFloat(numberOfPetals)
        let value = 2*tan(theta/2.0)
        return 0.5*value/(1 + value)*size.smallestSide/size.largestSide
    }
    
    private func petalPosition(for i: Int, size: CGSize) -> CGPoint {
        let radius = (1 - scale(size))*size.smallestSide/2 - 20
        let angle = self.angle(for: i)
        let xPosition = radius*CGFloat(cos(angle.radians))
        let yPosition = radius*CGFloat(sin(angle.radians))
        return CGPoint(x: size.width/2 + xPosition, y: size.height/2 + yPosition)
    }
    
    func changeRotation() {
       DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.animationParameter += 1
            self.changeRotation()
       }
    }
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView()
    }
}

extension CGSize {
    var smallestSide: CGFloat {
        return min(width, height)
    }
    
    var largestSide: CGFloat {
        return max(width, height)
    }
}
