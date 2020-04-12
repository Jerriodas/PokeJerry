//
//  GetAllPokemonProtocol.swift
//  PokeJerry
//
//  Created by Jerry Gordillo on 11/04/20.
//  Copyright © 2020 JerriodasCorp. All rights reserved.
//

import Foundation

protocol GetAllPokemonProtocol {
    func getAllPokemons(completion: @escaping (ServiceResponse<Pokemon>) -> Void)
}
