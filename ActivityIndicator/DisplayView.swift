//
//  DisplayView.swift
//  ActivityIndicator
//
//  Created by Carlos De la Mora on 3/31/20.
//  Copyright © 2020 Carlos De la Mora. All rights reserved.
//

import SwiftUI

struct DisplayView: View {
    var body: some View {
        //Text("🌸").rotationEffect(Angle(radians: Double.pi/2)).scaleEffect(2.0/3.0)
//        switch numberId % 2 {
//        case 0:
//           return Text("😡").rotationEffect(Angle(radians: Double.pi/2)).scaleEffect(2.0/3.0)
//        default:
//          return  Text("😀").rotationEffect(Angle(radians: Double.pi/2)).scaleEffect(2.0/3.0)
//        }
        
        GeometryReader { geometry in
            Color
                .red
                .cornerRadius(min(geometry.size.width, geometry.size.height))
                .frame(width: 20, height: 6)
        }
    }
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
    }
}
