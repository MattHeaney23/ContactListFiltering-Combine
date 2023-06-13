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
    
    @Published var searchTerm: String = ""
    
    init() {
        fetchStoredContactDetails()
        registerSubscribers()
    }
    
    private func registerSubscribers() {
        $searchTerm
            .flatMap { self.searchFilter(newSearchTerm: $0) }
            .sink { self.contactsToDisplay = $0 }
            .store(in: &cancellables)
    }
    
    private func searchFilter(newSearchTerm: String) -> Just<[Contact]> {
        if newSearchTerm == "" {
            return Just(self.allContacts)
        } else {
            return Just(self.allContacts)
                .map {
                    $0.filter { $0.name.containsNotCaseSensitive(newSearchTerm) }
                }
        }
    }
    
    func fetchStoredContactDetails() {
        
        guard let url = URLs.contactListURL else {
            //handle error
            return
        }
        
        networkService.fetchData(url: url)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    print("Completed: \(completion)")
                },
                receiveValue: { [weak self] value in
                    let orderedValue = value.sorted { ($0.name, $0.currentlyOnline ? 0 : 1) < ($1.name, $1.currentlyOnline ? 0 : 1) }
                    self?.allContacts = orderedValue
                    self?.contactsToDisplay = orderedValue
                })
            .store(in: &cancellables)
    }
}
