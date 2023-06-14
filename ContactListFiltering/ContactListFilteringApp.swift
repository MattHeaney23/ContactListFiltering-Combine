//
//  ContactListFilteringApp.swift
//  ContactListFiltering
//
//  Created by Matt on 12/06/2023.
//

import SwiftUI

@main
struct ContactListFilteringApp: App {
    
    //The starting value is 3 to start in the contacts tab, where the work for this solution is. The other tabs are for display purposes only
    @State var selectedTabTag = 3
    
    init() {
        //This is required due to the tab bar being transparent on scroll
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            
            TabView(selection: $selectedTabTag) {
                
                OutOfScopeView()
                    .tabItem {
                        Label("Profile", systemImage: "person.circle.fill")
                    }
                    .tag(1)
                
                OutOfScopeView()
                    .tabItem {
                        Label("Chats", systemImage: "rectangle.3.group.bubble.left.fill")
                    }
                    .tag(2)
                
                NavigationView {
                    ContactListView()
                        .navigationTitle("Contacts")
                }
                .tabItem {
                    Label("Contacts", systemImage: "person.3.fill")
                }
                .tag(3)
                
                OutOfScopeView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                .tag(4)
            }
        }
    }
}
