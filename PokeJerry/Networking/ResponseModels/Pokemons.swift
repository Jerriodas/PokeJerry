//
//  Pokemons.swift
//  PokeJerry
//
//  Created by Jerry Gordillo on 11/04/20.
//  Copyright © 2020 JerriodasCorp. All rights reserved.
//

import Foundation

struct GetAllPokemonResponse: Decodable {
    var results: [Pokemon]
}
struct Pokemon: Decodable {
    var name: String
}
