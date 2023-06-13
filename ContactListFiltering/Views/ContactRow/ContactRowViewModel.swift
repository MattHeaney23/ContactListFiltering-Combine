//
//  ContactRowViewModel.swift
//  ContactListFiltering
//
//  Created by Matt on 13/06/2023.
//

import Combine
import UIKit

class ContactRowViewModel: ObservableObject {
    
    let imageDownloader: NetworkImageService
    let contact: Contact
    var cancellables = Set<AnyCancellable>()
    @Published var image: UIImage? = nil
    
    init(contact: Contact, imageDownloader: NetworkImageService = .shared) {
        self.contact = contact
        self.imageDownloader = imageDownloader
        print("Init for \(self.contact.name)")
        // self.onRowAppear()
        // self.downloadImage()
    }
    
    deinit {
        print("Deinit for \(self.contact.name)")
    }
    
    func onRowAppear() {
        
        guard let url = URL(string: contact.profilePictureURL) else { fatalError("bruh") } //change this
        
        imageDownloader.getImage(url: url)
            .sink(receiveCompletion: { completion in
                print(completion)
            },
            receiveValue: { image in
                self.image = image
                //store to cache here
                print("got the image for \(self.contact.name)!")
            })
            .store(in: &cancellables)
    }
    
    func onRowDisappear() {
        cancellables.forEach {
            $0.cancel()
        }
        
        cancellables.removeAll()
        
        image = nil
    }
}
