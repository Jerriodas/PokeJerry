//
//  SpecialPrint.swift
//  PokeJerry
//
//  Created by Jerry Gordillo on 11/04/20.
//  Copyright © 2020 JerriodasCorp. All rights reserved.
//

import Foundation

func specialPrint(_ items: Any..., separator: String = "", terminator: String = "\n") {
    if ConfigPrints.activePrints {
        print(items, separator, terminator)
    }
}
