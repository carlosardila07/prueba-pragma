//
//  Cat.swift
//  Prueba pragma
//
//  Created by Carlos Ardila on 7/06/23.
//

import Foundation

struct Cat: Codable {
    var name: String
    var origin: String
    var affectionLevel: Int
    var intelligence: Int
    var image: Image?
    
    enum CodingKeys: String, CodingKey {
        case affectionLevel = "affection_level"
        case name, image, origin, intelligence
    }
}

struct Image: Codable {
    
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "url"
    }
}
