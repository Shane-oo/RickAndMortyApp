//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Shane Monck on 1/7/2023.
//

import UIKit


/// Controller to house tabs and root tab controllers
final class RMTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }


    private func setUpTabs() {
        let characterViewController = RMCharacterViewController()
        let locationViewController = RMLocationViewController()
        let episodesViewController = RMEpisodeViewController()
        let settingsiewController = RMSettingsViewController()
    
        // make titles large
        characterViewController.navigationItem.largeTitleDisplayMode = .automatic
        locationViewController.navigationItem.largeTitleDisplayMode = .automatic
        episodesViewController.navigationItem.largeTitleDisplayMode = .automatic
        settingsiewController.navigationItem.largeTitleDisplayMode = .automatic
        
        // wrap navigation around the controllers
        let nav1 = UINavigationController(rootViewController: characterViewController)
        let nav2 = UINavigationController(rootViewController: locationViewController)
        let nav3 = UINavigationController(rootViewController: episodesViewController)
        let nav4 = UINavigationController(rootViewController: settingsiewController)

        // tab bar icons
        nav1.tabBarItem = UITabBarItem(title: "Characters",
                                       image: UIImage(systemName: "figure.wave"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Locations",
                                       image: UIImage(systemName: "location"),
                                       tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Episodes",
                                       image: UIImage(systemName: "videoprojector"),
                                       tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Settings",
                                       image: UIImage(systemName: "gearshape.2"),
                                       tag: 4)
        // make titles large
        for nav in [nav1, nav2, nav3, nav4] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([nav1, nav2, nav3, nav4],
                        animated: true)
    }
}

