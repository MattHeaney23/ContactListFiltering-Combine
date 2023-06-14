//
//  OutOfScopeView.swift
//  ContactListFiltering
//
//  Created by Matt on 13/06/2023.
//

import SwiftUI

struct OutOfScopeView: View {
    
    //MARK: Views - Body
    
    var body: some View {
        Text("This project focuses only on the **'Contacts'** tab")
            .font(.footnote)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(32)
    }
}

struct OutOfScopeView_Previews: PreviewProvider {
    static var previews: some View {
        OutOfScopeView()
    }
}
