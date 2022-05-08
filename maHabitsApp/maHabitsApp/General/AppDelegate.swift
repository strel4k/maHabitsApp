//
//  AppDelegate.swift
//  maHabitsApp
//
//  Created by Alexander on 29.04.2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
                
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.tintColor = Colors.purpleColor

        let habitsViewController = HabitsViewController()
        habitsViewController.view.backgroundColor = .white
        let habitsNavigationController = UINavigationController(rootViewController: habitsViewController)
        
        let infoViewController = InfoViewController()
        infoViewController.view.backgroundColor = .white
        let infoNavigationController = UINavigationController(rootViewController: infoViewController)
        
        let appearanceNavigationBar = UINavigationBarAppearance()
        appearanceNavigationBar.configureWithOpaqueBackground()
        appearanceNavigationBar.backgroundColor = Colors.navigationBarColor
        
        let appearanceTabBar = tabBarController.tabBar.standardAppearance
        appearanceTabBar.stackedLayoutAppearance.selected.iconColor = Colors.purpleColor
        tabBarController.tabBar.standardAppearance = appearanceTabBar
                       
        habitsNavigationController.tabBarItem = UITabBarItem(
            title: Labels.habitsTabBarTitle,
            image: UIImage(systemName: "rectangle.grid.1x2"),
            selectedImage: UIImage(systemName: "rectangle.grid.1x2.fill"))
        habitsNavigationController.navigationBar.topItem?.title = Labels.today
        habitsNavigationController.navigationBar.barTintColor = Colors.navigationBarColor
        habitsNavigationController.navigationBar.standardAppearance = appearanceNavigationBar
        habitsNavigationController.navigationBar.scrollEdgeAppearance = habitsNavigationController.navigationBar.standardAppearance
        habitsNavigationController.navigationBar.topItem?.rightBarButtonItem?.tintColor = Colors.purpleColor
        
        infoNavigationController.tabBarItem = UITabBarItem(
            title: Labels.info,
            image: UIImage(systemName: "info.circle"),
            selectedImage: UIImage(systemName:"info.circle.fill"))
        infoNavigationController.navigationBar.topItem?.title = Labels.info
        infoNavigationController.navigationBar.barTintColor = Colors.navigationBarColor
        infoNavigationController.navigationBar.standardAppearance = appearanceNavigationBar
        infoNavigationController.navigationBar.scrollEdgeAppearance = infoNavigationController.navigationBar.standardAppearance

        tabBarController.viewControllers = [habitsNavigationController, infoNavigationController]
                        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}
