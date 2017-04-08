//
//  LoginPresenter.swift
//  KataSuperHeroes
//
//  Created by Luis Cañadas on 05/04/2017.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation
import BothamUI

class LoginPresenter: BothamPresenter {
	
	var view: LoginView?
	
	let loginUser: LoginUser
	
	init(view: LoginView) {
		self.view = view
		
		loginUser = LoginUser()
	}
	
	/**
	*  BothamPullToRefreshPresenter *
	*/
	func viewDidLoad() {
		
	}
	
	func login(user: String, pass: String) {
		
		self.view?.showLoader()
		
		loginUser.execute({result in
			self.view?.hideLoader()
			if let value = result.value {
				if value {
					self.loginSuccess()
				} else {
					self.view?.showLoginError()
				}
			} else {
				self.view?.showLoginError()
			}
		})

	}
	
	func loginSuccess() {
		
		let superHeroesViewController = ServiceLocator().provideSuperHeroesViewController()
		view?.openSuperHeroesScreen(superHeroesViewController)
		
	}

}
