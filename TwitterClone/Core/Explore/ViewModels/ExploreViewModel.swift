//
//  ExploreViewModel.swift
//  TwitterClone
//
//  Created by Murad Bashirli on 29.01.23.
//

import SwiftUI

class ExploreViewModel: ObservableObject {
    @Published var users = [User]()
    let service = UserService()
    @Published var searchText = ""
    var searchableUsers: [User]{
        if searchText.isEmpty{
            return users
        }
        else
        {
            let lowercasedQuery = searchText.lowercased()
            
            return users.filter({
                $0.username.contains(lowercasedQuery) ||
                $0.fullName.lowercased().contains(lowercasedQuery)
            })
        }
    }
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchUsers { users in
            self.users = users
        }
    }
}
