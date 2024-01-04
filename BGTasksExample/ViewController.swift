//
//  ViewController.swift
//  BGTasksExample
//
//  Created by test on 04.01.2024.
//

import UIKit
import BackgroundTasks

class ViewController: UIViewController {

    let taskId = "com.ri.BGTasksExample.backgroundTask"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            
            self.schedule()
        })
    }

    private func schedule() {
        BGTaskScheduler.shared.getPendingTaskRequests { requests in
            print("\(requests.count) BGTasks pending...")
            
            guard requests.isEmpty else {
                return
            }
            
            do {
                let newTask = BGAppRefreshTaskRequest(identifier: self.taskId)
                newTask.earliestBeginDate = Date().addingTimeInterval(86400 * 3)
                try BGTaskScheduler.shared.submit(newTask)
            } catch {
                
            }
        }
    }

}

