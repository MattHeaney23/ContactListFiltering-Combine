//
//  ContactRow.swift
//  ContactListFiltering
//
//  Created by Matt on 12/06/2023.
//

import Combine
import SwiftUI

struct ContactRow: View {
    
    @StateObject var viewModel: ContactRowViewModel //This only works with State Object
    
    var body: some View {
        
        HStack(spacing: 16) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
            } else {
                ProgressView()
                    .frame(width: 80, height: 80)
            }
            
            VStack(spacing: 4) {
                HStack(){
                    Circle()
                        .foregroundColor(viewModel.contact.currentlyOnline ? .green : .red)
                        .frame(width: 10, height: 10)
                    Text(viewModel.contact.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Text(viewModel.contact.username)
                    .italic()
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if viewModel.contact.currentlyOnline {
                    Text("Online")
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    if let lastOnline = viewModel.contact.displayableLastOnlineTime {
                        Text("Last Seen: \(lastOnline)")
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        //.padding(.vertical, 10)
        .onAppear { viewModel.onRowAppear() }
        .onDisappear { viewModel.onRowDisappear() }
    }
}
