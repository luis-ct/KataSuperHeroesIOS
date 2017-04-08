//
//  SuperHeroesPresenter.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 09/03/2017.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation
import BothamUI

class SuperHeroesPresenter: BothamPullToRefreshPresenter, BothamNavigationPresenter {

    var view: SuperHeroesView?

    let getSuperHeroes: GetSuperHeroes
    let getSuperHeroesByRange: GetSuperHeroesByRange

    init(view: SuperHeroesView) {
        self.view = view

        let repository: SuperHeroesRepository = SuperHeroesRepository()
        getSuperHeroes = GetSuperHeroes(repository: repository)
        getSuperHeroesByRange = GetSuperHeroesByRange(repository: repository)
    }

    /**
     *  BothamPullToRefreshPresenter *
     */
    func viewDidLoad() {

        self.view?.showLoader()

        getSuperHeroes.execute({superHeroes in
            self.view?.hideLoader()
            if let value = superHeroes.value {
                if value.count > 0 {
                    self.view?.show(items: value)
                } else {
                    self.view?.showEmptyCase()
                }
            } else {
                self.view?.showEmptyCase()
            }
        })
    }

    func didStartRefreshing() {

        getSuperHeroesByRange.execute(limit: 10, {superHeroes in
            self.view?.stopRefreshing()
            guard let value = superHeroes.value else {
                self.view?.showNoMoreItems()
                return
            }

            guard value.count > 0 else {
                self.view?.showNoMoreItems()
                return
            }

            self.view?.show(items: value)
        })

    }

    /**
     *  BothamNavigationPresenter *
     */
    func itemWasTapped(_ item: SuperHero) {

        let superHeroDetailViewController = ServiceLocator().provideSuperHeroDetailViewController(item.idSuperHero)
        view?.openSuperHeroDetailScreen(superHeroDetailViewController)

    }
}
