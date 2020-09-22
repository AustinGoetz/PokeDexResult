//
//  PokemonController.swift
//  Pokedex
//
//  Created by Austin Goetz on 9/22/20.
//  Copyright © 2020 Warren. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    
    static let baseURL = URL(string: "https://pokeapi.co/api/v2")
    static let pokemonEndpoint = "pokemon"
    
    static func fetchPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, PokemonError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        let pokemonURL = baseURL.appendingPathComponent(pokemonEndpoint)
        
        let finalURL = pokemonURL.appendingPathComponent(searchTerm.lowercased())
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.invalidData)) }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch (let decodingError) {
                return completion(.failure(.thrownError(decodingError)))
            }
        }.resume()
    }
    
    static func fetchSprite(for pokemon: Pokemon, completion: @escaping (Result<UIImage, PokemonError>) -> Void) {
        
        let spriteURL = pokemon.sprites.shinySpriteURL
        
        URLSession.shared.dataTask(with: spriteURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.invalidData)) }
            
            guard let image = UIImage(data: data) else { return completion(.failure(.invalidData)) }
            return completion(.success(image))
        }.resume()
    }
}
