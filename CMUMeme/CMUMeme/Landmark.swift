//
//  Landmark.swift
//  CMUMeme
//
//  Created by Kevin Bender on 9/9/17.
//  Copyright © 2017 HamHack. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import AudioToolbox

class Landmark {
    var name: String!
    var location: CLLocation!
    var radius: Double
    var meme: UIImage
    var description: String
    var notificationQueue: [UIAlertController]!
    var notificationTimer: Timer!
    var notificationIndex=0
    var canPresent=true
    var controller:UIViewController!
    init(name1: String, location1:CLLocation, radius1: Double, imgName: String, des:String)
    {
        name=name1
        location=location1
        radius=radius1
        meme = UIImage(named: imgName)!
        description=des
        notificationQueue = [UIAlertController]()
    }
    
    func isInRadius(currentLocation:CLLocation)->Bool
    {
        
        return location.distance(from: currentLocation)<=radius
        
    }
    
    func addDialogue(speaker: String, dialogue: String) {
    
        let alertController = UIAlertController(title: speaker, message:dialogue, preferredStyle: UIAlertControllerStyle.alert)
        //  alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        notificationQueue.append(alertController)
    }
    
    func playDialogue(controller:GameController)-> Bool {
        if(notificationQueue.count<=0){
            return true;
        }
        print("MADE IT")
        controller.shouldShowNotification=false
        // notificationTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: "notify", userInfo: nil, repeats: true)
        let dismiss = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
            controller.shouldShowNotification=true
            //Start your second timer
        })
        notificationQueue[notificationIndex].addAction(dismiss)
        controller.present(notificationQueue[notificationIndex], animated: true, completion: nil)
        notificationIndex += 1
        return notificationIndex>=notificationQueue.count
    }
    
}
