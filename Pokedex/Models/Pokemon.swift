//
//  Pokemon.swift
//  Pokedex
//
//  Created by Austin Goetz on 9/22/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    
    let sprites: Sprite
    let name: String
    let id: Int
    
    struct Sprite: Decodable {
        
        private enum CodingKeys: String, CodingKey {
            case shinySpriteURL = "front_shiny"
        }
        let shinySpriteURL: URL
    }
}
