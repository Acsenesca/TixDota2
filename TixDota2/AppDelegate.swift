//
//  AppDelegate.swift
//  TixDota2
//
//  Created by Stevanus Prasetyo Soemadi on 29/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    lazy fileprivate var navigationController: UINavigationController = UINavigationController()
	
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {

            // In iOS 13 setup is done in SceneDelegate
        } else {
			let window = UIWindow(frame: UIScreen.main.bounds)
            self.window = window
			let storage = HeroStorage()
			let listOfHeroes = storage.load(key: HeroStorageKey.listOfHeroes.rawValue)

			let vm = HeroViewModel()
			vm.requestListHeroes(completionHandler: { showAlert in
				vm.shouldShowAlert = showAlert
				
				if showAlert {
					vm.heroes.value = listOfHeroes
				}
				
				let viewController = HeroViewController(viewModel: vm)
				let nav = UINavigationController(rootViewController: viewController)
				viewController.title = "All"

				window.rootViewController = nav
				window.makeKeyAndVisible()
			})
		}

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Not called under iOS 13 - See SceneDelegate sceneWillResignActive
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Not called under iOS 13 - See SceneDelegate sceneDidEnterBackground
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Not called under iOS 13 - See SceneDelegate sceneWillEnterForeground
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Not called under iOS 13 - See SceneDelegate sceneDidBecomeActive
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
