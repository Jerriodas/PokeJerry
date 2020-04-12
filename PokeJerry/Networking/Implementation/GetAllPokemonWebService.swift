//
//  GetAllPokemonWebService.swift
//  PokeJerry
//
//  Created by Jerry Gordillo on 11/04/20.
//  Copyright © 2020 JerriodasCorp. All rights reserved.
//

import Foundation

class GetAllPokemonWebService: CoreServiceProtocol, GetAllPokemonProtocol {
    typealias ServiceModel = Pokemon
    
    func getAllPokemons(completion: @escaping (ServiceResponse<Pokemon>) -> Void) {
        callToWebService(httpMethod: .get, endpoint: .getAllPokemon, completion: completion)
    }
    
    func parse(_ data: Data?, statusCode: ResponseStatusCode) -> [Pokemon]? {
        guard let data = data, let responseModel = try? JSONDecoder().decode(GetAllPokemonResponse.self, from: data) else { return nil }
        return responseModel.results
    }
}
