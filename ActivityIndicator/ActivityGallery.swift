//
//  ActivityGallery.swift
//  ActivityIndicator
//
//  Created by Carlos De la Mora on 5/19/20.
//  Copyright © 2020 Carlos De la Mora. All rights reserved.
//

import SwiftUI

struct ActivityGallery: View {
    var types = ["standard", "text", "emoji", "image"]
    var body: some View {
        VStack {
            ActivityIndicatorView(dataSource: 0...12) { _ in
                StandardPetalContent()
            }
            
            ActivityIndicatorView(dataSource: "SwiftK1ck".reversed().map({"\($0)"})) { element in
                TextPetalContent(element).foregroundColor(.blue)
            }
            
            ActivityIndicatorView(dataSource: 0...12) { _ in
                TextPetalContent("🌸").scaleEffect(0.5)
            }
            
            ActivityIndicatorView(animationScale: 1.5, dataSource: 0...7) { _ in
                ImagePetalContent()
            }
        }
        
//        List(types, id: \.self) { type in
//
//            switch type {
//            case "standard":
//                return ActivityIndicatorView(dataSource: 0...12) { _ in
//                    StandardPetalContent()
//                }
//            default:
//                return ActivityIndicatorView(dataSource: 0...12) { _ in
//                    StandardPetalContent()
//                }
//                return ActivityIndicatorView(dataSource: Array("SwiftKick").reversed().map({$0})) { element in
//                    TextPetalContent(element)
//                }
//            case "emoji":
//                return ActivityIndicatorView(dataSource: 0...12) { _ in
//                    TextPetalContent("🌸")
//                }
//            case "image":
//                return ActivityIndicatorView(dataSource: 0...7) { _ in
//                    ImagePetalContent()
//                }
//           }
        
    }
}

struct ActivityGallery_Previews: PreviewProvider {
    static var previews: some View {
        ActivityGallery()
    }
}
