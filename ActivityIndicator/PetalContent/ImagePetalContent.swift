//
//  ImagePetalContent.swift
//  ActivityIndicator
//
//  Created by Carlos De la Mora on 5/19/20.
//  Copyright © 2020 Carlos De la Mora. All rights reserved.
//

import SwiftUI

struct ImagePetalContent: View {
    var body: some View {
        Image("icon").clipShape(Circle()).scaleEffect(0.3).rotationEffect(Angle(radians: .pi/2))
    }
}

struct ImagePetalContent_Previews: PreviewProvider {
    static var previews: some View {
        ImagePetalContent()
    }
}
