//
//  TextPetalContent.swift
//  ActivityIndicator
//
//  Created by Carlos De la Mora on 5/19/20.
//  Copyright © 2020 Carlos De la Mora. All rights reserved.
//

import SwiftUI

struct TextPetalContent: View {
    var inputString: String
    var body: some View {
        switch inputString {
        case "1":
            return Text("i").rotationEffect(Angle(radians: .pi/2))
        default:
            return Text(inputString).rotationEffect(Angle(radians: .pi/2))
        }
    }
    
    init(_ inputString: String) {
        self.inputString = inputString
    }
}

struct TextContent_Previews: PreviewProvider {
    static var previews: some View {
        TextPetalContent("👊")
    }
}
