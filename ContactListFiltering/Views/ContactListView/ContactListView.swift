//
//  ContactListView.swift
//  ContactListFiltering
//
//  Created by Matt on 12/06/2023.
//

import SwiftUI

struct ContactListView: View {
    
    @ObservedObject var viewModel: ContactListViewModel = ContactListViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            //Wrap this into a loading state so the user cannot search when it's loading, and handle the error states
            TextField("Search...", text: $viewModel.searchTerm)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 16)
            
            List(viewModel.contactsToDisplay) { contact in
                ContactRow(viewModel: ContactRowViewModel(contact: contact))
            }
            .listStyle(.plain)
        }
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView()
    }
}
