//
//  ContactRow.swift
//  ContactListFiltering
//
//  Created by Matt on 12/06/2023.
//

import Combine
import SwiftUI

class ContactRowViewModel: ObservableObject {
    
    let imageDownloader: NetworkImageService
    let contact: Contact
    var cancellables = Set<AnyCancellable>()
    @Published var image: UIImage? = nil
    
    init(contact: Contact, imageDownloader: NetworkImageService = .shared) {
        self.contact = contact
        self.imageDownloader = imageDownloader
        print("Init for \(self.contact.name)")
        //self.downloadImage()
    }
    
    deinit {
        print("Deinit for \(self.contact.name)")
    }
    
    func onRowAppear() {
        
        guard let url = URL(string: contact.profilePictureURL) else { fatalError("bruh") }
        
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

struct ContactRow: View {
    
    @ObservedObject var viewModel: ContactRowViewModel
    
    var body: some View {
        
        HStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 80, height: 80)
            } else {
                ProgressView()
                    .frame(width: 80, height: 80)
            }
            
            Spacer()
            
            Text(viewModel.contact.name)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .onAppear {
            viewModel.onRowAppear()
            print("Appear on \(viewModel.contact.name)")
        }.onDisappear {
            viewModel.onRowDisappear()
            print("Disappear on \(viewModel.contact.name)")
        }
    }
}

//struct ContactRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactRow()
//    }
//}
