//
//  Photo.swift
//  motivate
//
//  Created by Rhys Kentish on 27/10/2020.
//

import Foundation

struct URLs: Decodable {
   let raw: String
   let full: String
   let regular: String
   let small: String
   let thumb: String
}

struct User: Decodable {
    let name: String
}

struct UnsplashImage: Decodable {
    let user: User
    let urls: URLs
}
