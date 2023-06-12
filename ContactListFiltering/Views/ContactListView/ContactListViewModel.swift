//
//  ContactListViewModel.swift
//  ContactListFiltering
//
//  Created by Matt on 12/06/2023.
//

import Combine
import Foundation

class ContactListViewModel: ObservableObject {
    
    var cancellables = Set<AnyCancellable>()
    private var allContacts: [Contact] = []
    @Published var contactsToDisplay: [Contact] = []
    let networkService: NetworkService<[Contact]> = NetworkService()
    
    init() {
        fetchStoredContactDetails()
    }
    
    func fetchStoredContactDetails() {
        
        guard let url = URLs.contactListURL else {
            //handle error
            return
        }
        
        networkService.fetchData(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print("Completed: \(completion)")
            },
                  receiveValue: { [weak self] value in
                print("value! \(value)")
                self?.allContacts = value
                self?.contactsToDisplay = value
            })
            .store(in: &cancellables)
    }
    
}
