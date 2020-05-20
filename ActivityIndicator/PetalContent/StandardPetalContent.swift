//
//  StandardPetalContent.swift
//  ActivityIndicator
//
//  Created by Carlos De la Mora on 3/31/20.
//  Copyright © 2020 Carlos De la Mora. All rights reserved.
//

import SwiftUI

struct StandardPetalContent: View {
    var body: some View {
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
        StandardPetalContent()
    }
}
