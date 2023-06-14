//
//  ContactListViewModel.swift
//  ContactListFiltering
//
//  Created by Matt on 12/06/2023.
//

import Combine
import Foundation

class ContactListViewModel: ObservableObject {
    
    private var allContacts: [Contact] = []
    
    @Published var loadingState: LoadingState<[Contact]> = .loading
    @Published var searchTerm: String = ""

    private let networkService: NetworkService<[Contact]> = NetworkService()
        
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        fetchStoredContactDetails()
        registerSubscribers()
    }
    
    private func registerSubscribers() {
        $searchTerm
            .flatMap { self.searchFilter(newSearchTerm: $0) }
            .sink { self.loadingState = .ready($0) }
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
    
    public func fetchStoredContactDetails() {
        
        guard let url = URLs.contactListURL else {
            self.loadingState = .error(ContactListError.invalidURL)
            return
        }
        
        networkService.fetchData(url: url)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error): self?.loadingState = .error(error)
                    case .finished: return
                    }
                },
                receiveValue: { [weak self] value in
                    let orderedValue = value.sorted { $0.name < $1.name }
                    self?.allContacts = orderedValue
                    self?.loadingState = .ready(orderedValue)
                })
            .store(in: &cancellables)
    }
}
