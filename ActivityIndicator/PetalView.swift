//
//  PetalView.swift
//  ActivityIndicator
//
//  Created by Carlos De la Mora on 3/25/20.
//  Copyright © 2020 Carlos De la Mora. All rights reserved.
//

import SwiftUI
import Combine

struct PetalView: View {
    var duration: Double
    var positionNumber: Int
    var numberOfPetals: Int
    var scale: CGFloat = 2.0
    //var viewForNumber:(Int) -> some View
    
    @Binding var animationParameter: Int

    var body: some View {
        DisplayView()
            .opacity(self.opacity(for: positionNumber))
            .scaleEffect(self.scale(for: positionNumber))
            .animation(.linear(duration: duration))
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
        PetalView(duration: 0.3,
                  positionNumber: 12,
                  numberOfPetals: 12,
                  animationParameter: Binding.constant(10))
    }
}

