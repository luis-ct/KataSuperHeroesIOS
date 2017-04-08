//
//  GetSuperHeroesByRange.swift
//  KataSuperHeroes
//
//  Created by Luis Cañadas on 19/03/2017.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation
import Result

class GetSuperHeroesByRange {

    let repository: SuperHeroesRepository

    init(repository: SuperHeroesRepository) {
        self.repository = repository
    }

    func execute(limit: Int, _ completionHandler: @escaping (Result<[SuperHero], SuperHeroError>) -> Void) {
        repository.getRange(limit: limit, completionHandler)
    }
}
