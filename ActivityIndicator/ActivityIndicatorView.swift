//
//  ActivityIndicatorView.swift
//  ActivityIndicator
//
//  Created by Carlos De la Mora on 3/25/20.
//  Copyright © 2020 Carlos De la Mora. All rights reserved.
//

import SwiftUI
import Combine

struct ActivityIndicatorView <Data: RandomAccessCollection, Content> : View where  Content: View, Data.Element: Hashable {
    
    var duration = 0.1
   
    init(diameter: CGFloat = 110,
         animationScale: CGFloat = 1.0,
         dataSource: Data,
         contentBuilder: @escaping (Data.Element) -> Content) {
        self.diameter = diameter
        self.dataSource = dataSource
        self.contentBuilder = contentBuilder
        self.numberOfPetals = dataSource.count
        self.animationScale = animationScale
        self.getIndex = { element in
                    let enumeration = dataSource.enumerated()
                    return enumeration.first(where: { (index, value) -> Bool in
                        value == element
                    })!.0
        }
    }
    
    private let animationScale: CGFloat
    private let diameter: CGFloat
    private var numberOfPetals: Int
    private let dataSource: Data
    private let contentBuilder: (Data.Element) -> Content
    private let getIndex: (Data.Element) -> Int
    
    //private let ensambledView:
    @State var animationParameter = 0
    var body: some View {
        ensamble()
        .onAppear {
            self.changeRotation()
        }
    }
   
    func angle(for i: Int)-> Angle {
        return Angle(radians: 2*Double(-i)*Double.pi/Double(numberOfPetals))
    }
    
    
    
    func ensamble() -> some View {
        GeometryReader { geometry in
            ForEach(self.dataSource, id: \.self) { element in
                PetalView(content: self.contentBuilder(element),
                          duration: self.duration,
                          positionNumber: self.getIndex(element),
                          numberOfPetals: self.numberOfPetals,
                          scale: self.animationScale,
                          animationParameter: self.$animationParameter)
                    .rotationEffect(self.angle(for: self.getIndex(element)))
                    .position(self.petalPosition(for: self.getIndex(element), size: geometry.size))
            }
        }.frame(width: diameter, height: diameter)
    }
    
    private func scaleToFit(_ size: CGSize) -> CGFloat {
        let theta = 2*CGFloat.pi/CGFloat(numberOfPetals)
        let value = 2*tan(theta/2.0)
        return 0.5*value/(1 + value)*size.smallestSide/size.largestSide
    }
    
    private func petalPosition(for i: Int, size: CGSize) -> CGPoint {
        let radius = (1 - scaleToFit(size))*size.smallestSide/2 - 20
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
        ActivityIndicatorView(animationScale: 1.5, dataSource: 0...7) { element in
            //DisplayView()
            StandardPetalContent()
            //ImagePetalContent()
        }
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


