//
//  SuperHeroDetailPresenter.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 09/03/2017.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation

import BothamUI

protocol SuperHeroDetailUI: BothamUI, BothamLoadingUI {
}

class SuperHeroDetailPresenter: BothamPresenter {

    var view: SuperHeroViewProtocol?
    fileprivate let superHeroID: String
    fileprivate let getSuperHero: GetSuperHero

    init(view: SuperHeroViewProtocol, superHeroID: String, getSuperHero: GetSuperHero) {
        self.view = view
        self.superHeroID = superHeroID
        self.getSuperHero = getSuperHero
    }

    func viewDidLoad() {
        let superHeroesRepository = SuperHeroesRepository()
        let getSuperHero = GetSuperHero(repository: superHeroesRepository)

        self.view?.showLoader()

        getSuperHero.execute(superHeroID, {superHero in
            self.view?.hideLoader()
            if let value = superHero.value {
                self.view?.show(superHero: value)
            }
        })
    }

}
