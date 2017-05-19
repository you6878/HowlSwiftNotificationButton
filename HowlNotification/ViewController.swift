//
//  ViewController.swift
//  HowlNotification
//
//  Created by 유명식 on 2017. 5. 18..
//  Copyright © 2017년 swift. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController,UNUserNotificationCenterDelegate {
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let answer_1 = UNNotificationAction(identifier: "Good", title: "강의가 만족스럽다.", options: [.foreground])
        let answer_2 = UNNotificationAction(identifier: "Bad", title: "강의가 설명이 부족하다.", options: [.foreground])
        
        let category = UNNotificationCategory(identifier: "SelectBox", actions: [answer_1,answer_2], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        
        UNUserNotificationCenter.current().delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func notificationButton(_ sender: Any) {
    
    
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey:
            "Hello!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey:
            "Hello_message_body", arguments: nil)
        content.categoryIdentifier = "SelectBox"
        // Deliver the notification in five seconds.
        content.sound = UNNotificationSound.default()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1,
                                                        repeats: false)
        
        // Schedule the notification.
        let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
        
        
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case "Good":
            label.text = "강의에 만족 하셨습니다."
            
        case "Bad":
            label.text = "강의에 만족하지 않으셨습니다."
        default:
            break
        }
        
    }
    

}

