//
//  AppDelegate.swift
//  BGTasksExample
//
//  Created by test on 04.01.2024.
//

import UIKit
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let taskId = "com.ri.BGTasksExample.backgroundTask"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        // Register handler for task
        BGTaskScheduler.shared.register(forTaskWithIdentifier: taskId, using: nil) { task in
            
            // Handle the task when its run
            guard let task = task as? BGAppRefreshTask else { return }
            self.handleTask(task: task)
        }
        
        let count = UserDefaults.standard.integer(forKey: "task_run_count")
        print("Task ran \(count) times!")
        
        return true
    }
    
    private func handleTask(task: BGAppRefreshTask) {
        let count = UserDefaults.standard.integer(forKey: "task_run_count")
        UserDefaults.standard.set(count + 1, forKey: "task_run_count")
        
        task.expirationHandler = {
            
        }
        
        task.setTaskCompleted(success: true)
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

