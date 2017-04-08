//
//  SuperHeroesKataViewController.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 12/01/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import Foundation
import BothamUI

class KataSuperHeroesViewController: BothamViewController, BothamLoadingViewController {

    let loadingView: UIView = {
        let loadingView = BothamLoadingView()
        loadingView.color = UIColor.loadingColor
        return loadingView
    }()

    var pullToRefreshHandler: BothamPullToRefreshHandler!

	func showLoader() {
		guard !view.subviews.contains(loadingView) else {
			return
		}
		
		loadingView.isHidden = false
		loadingView.bounds = view.bounds
//		loadingView.autoresizingMask = [
//			.flexibleBottomMargin,
//			.flexibleLeftMargin,
//			.flexibleRightMargin,
//			.flexibleTopMargin
//		]
		loadingView.autoresizingMask = []
		loadingView.center = CGPoint(x:self.view.frame.width/2, y:self.view.frame.height/2)
		
		view.addSubview(loadingView)
	}
	
	func hideLoader() {
		loadingView.removeFromSuperview()
		loadingView.isHidden = true
	}

}
