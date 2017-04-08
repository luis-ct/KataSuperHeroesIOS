//
//  GetSuperHero.swift
//  KataSuperHeroes
//
//  Created by Luis Cañadas on 18/03/2017.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation
import Result

class GetSuperHero {

    let repository: SuperHeroesRepository

    init(repository: SuperHeroesRepository) {
        self.repository = repository
    }

    func execute(_ idSuperHero: String, _ completionHandler: @escaping (Result<SuperHero, SuperHeroError>) -> Void) {
        repository.getById(idSuperHero, completionHandler)
    }

}
