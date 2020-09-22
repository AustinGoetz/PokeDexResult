//
//  PokemonError.swift
//  Pokedex
//
//  Created by Austin Goetz on 9/22/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation

enum PokemonError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case invalidData
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Unable to reach the server with the given URL"
        case .thrownError(let error):
            return "We found an error: \(error.localizedDescription) \n-\n \(error)"
        case .invalidData:
            return "Data was not found, or was invalid"
        }
    }
}
