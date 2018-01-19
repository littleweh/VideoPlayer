//
//  AppDelegate.swift
//  VideoPlayerKVO
//
//  Created by 典萱 高 on 2018/1/19.
//  Copyright © 2018年 LostRfounds. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?)
        -> Bool {

            window = UIWindow(frame: UIScreen.main.bounds)
            let videoPlayerViewController = VideoPlayerViewController()
            videoPlayerViewController.view.backgroundColor = UIColor.black
            window?.rootViewController = videoPlayerViewController
            window?.makeKeyAndVisible()
            return true
    }

}
