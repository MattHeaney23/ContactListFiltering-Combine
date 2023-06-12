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
        List(viewModel.contactsToDisplay) { contact in
            ContactRow(viewModel: ContactRowViewModel(contact: contact))
        }
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView()
    }
}
