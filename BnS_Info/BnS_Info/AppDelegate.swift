//
//  AppDelegate.swift
//  BnS_Info
//
//  Created by Jihye Jegal on 2017. 5. 4..
//  Copyright © 2017년 Jihye Jegal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //self.window = UIWindow(frame: UIScreen.main.bounds)
        
        //1.메인 스토리보드에 접근
        if let lgv = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginView") as? LoginViewController {
            if let w = self.window, let rootViewController = w.rootViewController {
                w.rootViewController?.addChildViewController(lgv)
                var currentController = rootViewController
                while let presentedController = currentController.presentedViewController {
                    currentController = presentedController // top view까지 이동
                }
                currentController.present(lgv, animated: true, completion: nil)
            }
        }
        
        //2.그 메인 스토리보드에서 로그인 뷰를 찾아서 인스턴스화
        
        
        //self.window?.rootViewController = lgv
        //self.window?.makeKeyAndVisible()
        //self.window?.rootViewController?.addChildViewController(lgv)
        //self.window?.rootViewController?.present(lgv, animated: true, completion: nil)
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

