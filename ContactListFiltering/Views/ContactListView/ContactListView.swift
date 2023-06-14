//
//  ContactListView.swift
//  ContactListFiltering
//
//  Created by Matt on 12/06/2023.
//

import SwiftUI

struct ContactListView: View {
    
    @ObservedObject var viewModel: ContactListViewModel = ContactListViewModel()
    
    //MARK: Views - Body
    
    var body: some View {
        switch viewModel.loadingState {
        case .loading: LoadingComponent()
        case .error(let error): ErrorComponent(error: error)
        case .ready(let contacts): contactList(contacts: contacts)
        }
    }

    //MARK: Views - Contact List
    
    func contactList(contacts: [Contact]) -> some View {
        VStack(spacing: 0) {
            TextField("Search...", text: $viewModel.searchTerm)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 16)
            
            List(contacts) { contact in
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
