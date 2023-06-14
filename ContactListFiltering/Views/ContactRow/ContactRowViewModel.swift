//
//  ContactRowViewModel.swift
//  ContactListFiltering
//
//  Created by Matt on 13/06/2023.
//

import Combine
import UIKit

class ContactRowViewModel: ObservableObject {

    //MARK: Published States
    @Published var loadingState: LoadingState<UIImage> = .loading
    
    //MARK: Dependacnies
    public let contact: Contact
    private let imageDownloader: NetworkImageService = NetworkImageService()
    
    //MARK: Subscriptions
    private var cancellables = Set<AnyCancellable>()

    //MARK: Initialisers
    init(contact: Contact) {
        self.contact = contact
    }
    
    //MARK: Row Lifecycle Events
    func onRowAppear() {
        
        self.loadingState = .loading
        
        guard let url = URL(string: contact.profilePictureURL) else {
            self.loadingState = .error(ContactProfilePictureError.invalidURL)
            return
        }
        
        imageDownloader.getImage(url: url)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished: return
                case .failure(let error): self?.loadingState = .error(error)
                }
            },
            receiveValue: { [weak self] image in
                self?.loadingState = .ready(image)
            })
            .store(in: &cancellables)
    }
    
    func onRowDisappear() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}
