//
//  Modelo.swift
//  JSONENUIKit
//
//  Created by Rubén Segura Romo on 2/4/25.
//

import Foundation

struct Modelo: Codable {
	var data: [UserList]
}

struct User: Codable {
	var data: UserList
}

struct UserList: Codable {
	var id: Int
	var first_name: String
	var email: String
	var avatar: String
}
