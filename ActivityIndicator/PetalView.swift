//
//  PetalView.swift
//  ActivityIndicator
//
//  Created by Carlos De la Mora on 3/25/20.
//  Copyright © 2020 Carlos De la Mora. All rights reserved.
//

import SwiftUI
import Combine

struct PetalView<Content: View >: View {
    var duration: Double
    var positionNumber: Int
    var numberOfPetals: Int
    var scale: CGFloat
    var contentView: Content
    
    @Binding var animationParameter: Int

    var body: some View {
        contentView
            .opacity(self.opacity(for: positionNumber))
            .scaleEffect(self.scale(for: positionNumber))
            .animation(.linear(duration: duration))
    }
    
    init(content: Content,
         duration: Double,
         positionNumber: Int,
         numberOfPetals: Int = 12,
         scale: CGFloat = 1.0,
         animationParameter: Binding<Int>) {
        contentView = content
        self.duration = duration
        self.positionNumber = positionNumber
        self.numberOfPetals = numberOfPetals
        self.scale = scale
        self._animationParameter = animationParameter
    }
    
    private func opacity(for i: Int) -> Double {
        return 1.0 - 0.7*Double((i + animationParameter)%numberOfPetals)/Double(numberOfPetals)
    }
    
    private func scale(for i: Int) -> CGFloat {
        return scale - CGFloat((i + animationParameter)%numberOfPetals)/CGFloat(numberOfPetals)*(scale - 1)
    }

}

struct PetalView_Previews: PreviewProvider {
    
    static var previews: some View {
        PetalView(content:StandardPetalContent(),
                  duration: 0.3,
                  positionNumber: 12,
                  numberOfPetals: 12,
                  animationParameter: Binding.constant(1))
    }
}

