//
//  EndpointHandler.swift
//  PokeJerry
//
//  Created by Jerry Gordillo on 11/04/20.
//  Copyright © 2020 JerriodasCorp. All rights reserved.
//

import Foundation

// Agrega los endpoints para el servicio a implementar
enum Endpoint {
    static var baseHeaders: Dictionary<String,String> {
        ["Content-Type":"application/json"]
    }
    case getAllPokemon
    case getPokemonDetail
    
    func getURL() -> String {
        switch self {
        case .getAllPokemon:
            return "pokemon?limit=964"
        case .getPokemonDetail:
            return "pokemon/%@"
        }
    }
    
    func getHeaders() -> [String : String] {
        var returnHeaders = Endpoint.baseHeaders
        switch self {
        case .getAllPokemon:
            break //returnHeaders[""] = ""
        case .getPokemonDetail:
            break
        }
        return returnHeaders
    }
}
