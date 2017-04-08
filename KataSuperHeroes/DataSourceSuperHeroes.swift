//
//  DataSourceSuperHeroes.swift
//  KataSuperHeroes
//
//  Created by Luis Cañadas on 18/03/2017.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation

protocol DataSourceSuperHeroes {
    func getAll() -> [SuperHero]
}
