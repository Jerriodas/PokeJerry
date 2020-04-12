//
//  EncodingProtocol.swift
//  PokeJerry
//
//  Created by Jerry Gordillo on 11/04/20.
//  Copyright © 2020 JerriodasCorp. All rights reserved.
//

import Foundation

extension Encodable {
    //Para mandar body desde una estructura
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}
