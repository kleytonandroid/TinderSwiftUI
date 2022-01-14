//
//  User.swift
//  TinderUI
//
//  Created by Kleyton Santos on 14/01/22.
//

import Foundation

struct User: Identifiable {
    
    var id = UUID().uuidString
    var name: String
    var place: String
    var profilePic: String
}
