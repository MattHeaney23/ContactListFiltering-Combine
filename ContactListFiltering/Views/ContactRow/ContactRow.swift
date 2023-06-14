//
//  ContactRow.swift
//  ContactListFiltering
//
//  Created by Matt on 12/06/2023.
//

import Combine
import SwiftUI

struct ContactRow: View {
    
    //MARK: Dependancies
    @StateObject var viewModel: ContactRowViewModel
    
    //MARK: Views - Body
    var body: some View {
        
        HStack(spacing: 16) {
            userProfilePicture()
            userInfoComponent()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .onAppear { viewModel.onRowAppear() }
        .onDisappear { viewModel.onRowDisappear() }
    }
    
    //MARK: Views - Profile Picture
    @ViewBuilder
    func userProfilePicture() -> some View {
        switch viewModel.loadingState {
        case .error(_): profilePictureErrorImage()
        case .loading: profilePictureLoadingIndicator()
        case .ready(let image): profilePicture(image: image)
        }
    }
    
    func profilePictureErrorImage() -> some View {
        Image(systemName: "person.crop.circle.badge.exclamationmark.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
    }
    
    func profilePictureLoadingIndicator() -> some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundColor(.gray.opacity(0.1))
            .frame(width: 80, height: 80)
            .overlay {
                ProgressView()
                    .opacity(1)
            }
    }
    
    func profilePicture(image: UIImage) -> some View {
        Image(uiImage: image)
            .resizable()
            .frame(width: 80, height: 80)
            .cornerRadius(8)
    }
    
    //MARK: Views - User Info Component
    func userInfoComponent() -> some View {
        VStack(spacing: 4) {
            HStack(){
                onlineIndicatorCircle()
                nameText()
            }
            usernameText()
            onlineStateText()
        }
    }
    
    func nameText() -> some View {
        Text(viewModel.contact.name)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func onlineIndicatorCircle() -> some View{
        Circle()
            .foregroundColor(viewModel.contact.currentlyOnline ? .green : .red)
            .frame(width: 10, height: 10)
    }
    
    func usernameText() -> some View {
        Text(viewModel.contact.username)
            .italic()
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func onlineStateText() -> some View {
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
