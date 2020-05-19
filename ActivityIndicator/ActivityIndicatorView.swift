//
//  ActivityIndicatorView.swift
//  ActivityIndicator
//
//  Created by Carlos De la Mora on 3/25/20.
//  Copyright © 2020 Carlos De la Mora. All rights reserved.
//

import SwiftUI

struct ActivityIndicatorView< DataSource: RandomAccessCollection, ID, Content> : View where ID == DataSource.Element.ID, Content: View, DataSource.Element : Identifiable{
    
    var duration = 0.1
    var diameter: CGFloat
    private var numberOfPetals: Int
    private let dataSource: DataSource
    private let contentBuilder: (DataSource.Element) -> Content
    @State var animationParameter = 0
    var body: some View {
        makeContent()
        .onAppear {
            self.changeRotation()
        }
    }
    
    init(diameter: CGFloat = 120,
         dataSource: DataSource,
         contentBuilder: @escaping (DataSource.Element) -> Content) {
        self.diameter = diameter
        self.dataSource = dataSource
        self.contentBuilder = contentBuilder
        self.numberOfPetals = dataSource.count
    }
    
    func makeContent() -> some View {
        GeometryReader { geometry in
            ForEach(self.dataSource) { element in
                PetalView(content: self.contentBuilder(element),
                          duration: self.duration,
                          positionNumber: self.getIntIndex(element: element),
                          numberOfPetals: self.numberOfPetals,
                          scale: 1.2,
                          animationParameter: self.$animationParameter)
                    .rotationEffect(self.angle(for: self.getIntIndex(element: element)))
                    .position(self.petalPosition(for: self.getIntIndex(element: element), size: geometry.size))
            }
        }.frame(width: diameter, height: diameter)
    }
    
    func angle(for i: Int)-> Angle {
        return Angle(radians: 2*Double(-i)*Double.pi/Double(numberOfPetals))
    }
    
    func getIntIndex(element: DataSource.Element) -> Int {
        let enumeration = dataSource.enumerated()
        return enumeration.first(where: { (index, value) -> Bool in
            value.id == element.id
        })!.0
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
        ActivityIndicatorView<Range<Int>, Int, DisplayView >(dataSource: 0..<13) { _ in
            DisplayView()
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


extension Int: Identifiable {
    public var id:Int {
        return self
    }
}

extension ActivityIndicatorView {
    
}
