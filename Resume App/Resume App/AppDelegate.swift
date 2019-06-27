//
//  AppDelegate.swift
//  Resume App
//
//  Created by Zach Smoroden on 2019-06-22.
//  Copyright © 2019 Zach Smoroden. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow.init(frame: UIScreen.main.bounds)

        window?.rootViewController = ResumeNavigationViewController()

        /*
         I'm not sure if I like having a mock exposed to the app target but I did it
         in order to ensure that the state of the app is consistent when running the UI tests.

        */
        #if DEBUG
        if CommandLine.arguments.contains("--uitesting") {
            let remoteService = ResumeRemoteService(config: ResumeRemoteConfig())
            let localRepository = ResumeLocalRepository()
            let resumeRepository = ResumeRepository(remoteService: remoteService, localRepository: localRepository)
            try! localRepository.set(resume: Mock.resume2)
            window?.rootViewController = ResumeNavigationViewController(repository: resumeRepository)
        }
        #endif
        window?.makeKeyAndVisible()

        return true
    }
}

