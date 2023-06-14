//
//  LoadingComponent.swift
//  AtomicMediaDeveloper
//
//  Created by Matt on 31/05/2023.
//

import SwiftUI

struct LoadingComponent: View {
    
    //MARK: Views - Body
    
    var body: some View {
        VStack(spacing: 8) {
            
            ProgressView()
            Text("Loading...")
                .font(.footnote)
    
        }.frame(maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .bottom)
    }
}

struct LoadingComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(["iPhone SE", "iPhone 14 Pro"], id: \.self) { device in
                LoadingComponent()
                    .previewDevice(PreviewDevice(rawValue: device))
                    .previewInterfaceOrientation(.portrait)
                
                LoadingComponent()
                    .previewDevice(PreviewDevice(rawValue: device))
                    .previewInterfaceOrientation(.landscapeRight)
            }
        }
    }
}
