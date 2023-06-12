//
//  ContactRow.swift
//  ContactListFiltering
//
//  Created by Matt on 12/06/2023.
//

import Combine
import SwiftUI

class ContactRowViewModel: ObservableObject {
    
    //let network = NetworkService()
    let imageDownloader = NetworkImageService()
    let contact: Contact
    var cancellables = Set<AnyCancellable>()
    @Published var image: UIImage? = nil
    
    init(contact: Contact) {
        self.contact = contact
        self.downloadImage()
    }
    
    private func downloadImage() {
        
        guard let url = URL(string: contact.profilePictureURL) else { fatalError("bruh") }
        
        imageDownloader.getImage(url: url)
            .sink(receiveCompletion: { completion in
                print(completion)
            },
                  receiveValue: { image in
                self.image = image
                print("got the image for \(self.contact.name)!")
            })
            .store(in: &cancellables)
        
    }
    
    
}

struct ContactRow: View {
    
    @ObservedObject var viewModel: ContactRowViewModel
    
    var body: some View {
        
        HStack {
            if let image = viewModel.image {
                Image(uiImage: image)
            }
            
            Text(viewModel.contact.name)
                .padding(.vertical, 100)
        }
    }
}

//struct ContactRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactRow()
//    }
//}
