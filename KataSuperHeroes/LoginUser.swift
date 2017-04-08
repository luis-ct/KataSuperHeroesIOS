//
//  LoginUser.swift
//  KataSuperHeroes
//
//  Created by Luis Cañadas on 05/04/2017.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import Foundation
import Result

class LoginUser {

	/**
	* Passing MarvelAPIClientProtocol to testing
	*/
	init() {
		
	}
	
	func execute(_ completionHandler: @escaping (Result<Bool, SuperHeroError>) -> Void) {
		
		let result: Result<Bool, SuperHeroError> = Result.success(true)

		self.delay(3.0) {
			completionHandler(result)
		}

	}
	
	fileprivate func delay(_ delay: Double, closure: @escaping ()->()) {
		DispatchQueue.main.asyncAfter(
			deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure
		)
	}

}
