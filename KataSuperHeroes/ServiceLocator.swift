//
//  RootWireframe.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 12/01/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation
import UIKit
import BothamUI

class ServiceLocator {

    func provideRootViewController() -> UIViewController {
        let navigationController: SuperHeroesNavigationViewController = storyBoard.initialViewController()
        navigationController.viewControllers = [provideLoginViewController()]
        return navigationController
    }

	func provideLoginViewController() -> UIViewController {
		let loginViewController: LoginViewController =
			storyBoard.instantiateViewController("LoginViewController")
		let presenter = LoginPresenter(view: loginViewController)
		loginViewController.presenter = presenter
		
		return loginViewController
	}

    func provideSuperHeroesViewController() -> UIViewController {
        let superHeroesViewController: SuperHeroesViewController = storyBoard.instantiateViewController("SuperHeroesViewController")
        let presenter = SuperHeroesPresenter(view: superHeroesViewController)
        let dataSource = provideSuperHeroesDataSource()
		let delegate = BothamTableViewNavigationDelegate(dataSource: dataSource, presenter: presenter)
        superHeroesViewController.presenter = presenter
        superHeroesViewController.dataSource = dataSource
        superHeroesViewController.delegate = delegate

        superHeroesViewController.pullToRefreshHandler = BothamPullToRefreshHandler(presenter: presenter)

        return superHeroesViewController
    }

    func provideSuperHeroDetailViewController(_ superHeroID: String) -> UIViewController {
        let viewController: SuperHeroDetailViewController =
		storyBoard.instantiateViewController("SuperHeroDetailViewController")
        viewController.presenter = provideSuperHeroDetailPresenter(view: viewController, superHeroID: superHeroID)

        return viewController
    }

    fileprivate func provideSuperHeroesDataSource() -> BothamTableViewDataSource<SuperHero, SuperHeroTableViewCell> {
        return BothamTableViewDataSource<SuperHero, SuperHeroTableViewCell>()
    }

    fileprivate func provideSuperHeroDetailPresenter(view: SuperHeroViewProtocol,
                                                     superHeroID: String) -> SuperHeroDetailPresenter {
        let getSuperHero = GetSuperHero(repository: SuperHeroesRepository())
        return SuperHeroDetailPresenter(view: view, superHeroID: superHeroID, getSuperHero: getSuperHero)
    }

    fileprivate lazy var storyBoard: BothamStoryboard = {
        return BothamStoryboard(name: "SuperHeroes")
    }()

}
