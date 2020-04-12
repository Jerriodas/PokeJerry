//
//  CoreServiceProtocol.swift
//  PokeJerry
//
//  Created by Jerry Gordillo on 11/04/20.
//  Copyright © 2020 JerriodasCorp. All rights reserved.
//

import Foundation

// Diferencia resultados y pasar informacion del WS
enum ServiceResponse <ResponseModel> {
    case success (data: [ResponseModel])
    case notSuccess
    case notConnectedToInternet
}

//Protocolo a implementar en la clase base
protocol CoreServiceProtocol {
    associatedtype ServiceModel
}

extension CoreServiceProtocol {
    // Nuestra URL Base
    var baseURL: String {
        return "https://pokeapi.co/api/v2/"
    }
    
    // Armamos la URL de peticion con la base y los Endpoints que le mandemos
    func callToWebService(httpMethod: HTTPMethod, body: Encodable? = nil, endpoint: Endpoint, completion: @escaping (ServiceResponse<ServiceModel>) -> Void) {
        let path = baseURL + endpoint.getURL()
        guard let url = URL(string: path) else { completion(.notSuccess); return }
        
        var urlRequest = URLRequest(url: url)
        
        // Añadir body, metodo, header y tiempo
        if let body = body {
            urlRequest.httpBody = body.toJSONData()
        }
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = endpoint.getHeaders()
        urlRequest.timeoutInterval = 60
        
        
        //Crea la URL Session
        URLSession(configuration: .ephemeral).dataTask(with: urlRequest) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse, let httpCode = ResponseStatusCode(rawValue: httpResponse.statusCode) else {
                self.process(error: error, completion: completion)
                return
            }
            
            specialPrint(String(data: data ?? Data(), encoding: .utf8))
            
            switch httpCode {
            case .successCode:
                self.handleSuccessRequest(data: data, statusCode: httpCode, completion: completion)
            case .successCreated:
                self.handleSuccessCreated(data: data, statusCode: httpCode, completion: completion)
            case .acepted:
                self.handleAceptedRequest(data: data, statusCode: httpCode, completion: completion)
            case .badRequest:
                self.handleBadRequest(data: data, statusCode: httpCode, completion: completion)
            case .unauthorizedCode:
                self.handlerUnknowedError(completion: completion)
            case .internalServerError:
                self.handlerUnknowedError(completion: completion)
            case .unknowedError:
                self.handlerUnknowedError(completion: completion)
            }
        }.resume()
    }
    
    
    // Este parse lo re escriben
    func parse(_ data: Data?, statusCode: ResponseStatusCode) -> [ServiceModel]? {
        return nil
    }
    func parseSuccessCreated(_ data: Data?, statusCode: ResponseStatusCode) -> [ServiceModel]? {
        return nil
    }
    func parseError (_ data: Data?, statusCode: ResponseStatusCode) -> Error? {
        return nil
    }
    
    
    // Manda a llamar el parse
    func handleSuccessRequest(data: Data?, statusCode: ResponseStatusCode, completion: @escaping (ServiceResponse<ServiceModel>) -> Void) {
        if let parseData = parse(data, statusCode: statusCode) {
            completion(.success(data: parseData))
        } else {
            completion(.success(data: []))
        }
    }
    
    func handleAceptedRequest(data: Data?, statusCode: ResponseStatusCode, completion: @escaping (ServiceResponse<ServiceModel>) -> Void) {
        if let parseData = parse(data, statusCode: statusCode) {
            completion(.success(data: parseData))
        } else {
            completion(.success(data: []))
        }
    }
    
    func handleSuccessCreated(data: Data?, statusCode: ResponseStatusCode, completion: @escaping (ServiceResponse<ServiceModel>) -> Void) {
        if let parseData = parseSuccessCreated(data, statusCode: statusCode) {
            completion(.success(data: parseData))
        } else {
            completion(.success(data: []))
        }
    }
    
    func handleBadRequest(data: Data?, statusCode: ResponseStatusCode, completion: @escaping (ServiceResponse<ServiceModel>) -> Void) {
        if let error = self.parseError(data, statusCode: statusCode) {
            completion(.notSuccess)
        } else {
            completion(.notSuccess)
        }
    }
    
    func process(error: Error?, completion: @escaping (ServiceResponse<ServiceModel>) -> Void) {
        if let nsError = error as NSError?, nsError.code == NSURLErrorNotConnectedToInternet {
            self.handleNoInternetConnection(completion: completion)
        } else {
            self.handlerUnknowedError(completion: completion)
        }
    }
    
    
    func handleNoInternetConnection(completion: @escaping (ServiceResponse<ServiceModel>) -> Void) {
        completion(.notConnectedToInternet)
    }
    
    func handlerUnknowedError(completion: @escaping (ServiceResponse<ServiceModel>) -> Void) {
        completion(.notSuccess)
    }
}
