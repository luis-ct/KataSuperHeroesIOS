//
//  SuperHeroesViewController.swift
//  KataSuperHeroes
//
//  Created by Pedro Vicente Gomez on 12/01/16.
//  Copyright © 2016 GoKarumi. All rights reserved.
//

import UIKit
import BothamUI

protocol SuperHeroesView: BothamLoadingUI, BothamPullToResfreshUI, BothamUI {
    func showEmptyCase()
    func showNoMoreItems()
    func show(items: [SuperHero])
    func openSuperHeroDetailScreen(_ superHeroDetailViewController: UIViewController)
}

class SuperHeroesViewController: KataSuperHeroesViewController, BothamTableViewController, SuperHeroesView {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyCaseView: UILabel!

    var dataSource: BothamTableViewDataSource<SuperHero, SuperHeroTableViewCell>!
    var delegate: UITableViewDelegate!

    override func viewDidLoad() {
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.tableFooterView = UIView()
        tableView.accessibilityLabel = "SuperHeroesTableView"
        tableView.accessibilityIdentifier = "SuperHeroesTableView"
        configureNavigationBarBackButton()

        pullToRefreshHandler.addTo(scrollView: tableView)

        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {}

    fileprivate func configureNavigationBarBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }

    /**
     *  SuperHeroesView *
     */
    func showEmptyCase() {
        emptyCaseView.isHidden = false
        pullToRefreshHandler.remove()
    }

    func showNoMoreItems() {
        pullToRefreshHandler.remove()
    }

    func openSuperHeroDetailScreen(_ superHeroDetailViewController: UIViewController) {
        navigationController?.push(viewController: superHeroDetailViewController)
    }

    func stopRefreshing() {
        pullToRefreshHandler.endRefreshing()
    }
}
