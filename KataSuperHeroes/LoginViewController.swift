//
//  LoginViewController.swift
//  KataSuperHeroes
//
//  Created by Luis Cañadas on 05/04/2017.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import UIKit
import BothamUI

protocol LoginView: BothamLoadingUI, BothamUI {
	func showLoginError()
	func openSuperHeroesScreen(_ superHeroesViewController: UIViewController)
}

class LoginViewController: KataSuperHeroesViewController, LoginView {

	@IBOutlet weak var userLabel: UILabel!
	@IBOutlet weak var userTF: UITextField!
	@IBOutlet weak var passwordLabel: UILabel!
	@IBOutlet weak var passwordTF: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

	
	/**
	 * LoginView methods *
	 */
	func showLoginError() {
		let alertController = UIAlertController(title: "Error", message: "Failed login", preferredStyle: .alert)
		let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
		alertController.addAction(defaultAction)
		self.present(alertController, animated: true, completion: nil)
	}
	
	func openSuperHeroesScreen(_ superHeroesViewController: UIViewController) {
//		superHeroesViewController.navigationItem.hidesBackButton = true
		navigationController?.push(viewController: superHeroesViewController)
	}

	/**
	 * LoginView methods *
	 */
	@IBAction func clickLoginButton(_ sender: UIButton) {
		if let loginPresenter = self.presenter! as? LoginPresenter {
			loginPresenter.login(user: userTF.text!, pass: userTF.text!)
		}
	}

}
