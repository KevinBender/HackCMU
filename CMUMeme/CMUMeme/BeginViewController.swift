//
//  BeginViewController.swift
//  CMUMeme
//
//  Created by Kevin Bender on 9/9/17.
//  Copyright © 2017 HamHack. All rights reserved.
//

import UIKit
import CoreLocation
import AudioToolbox

class BeginViewController: UIViewController {

    var gameTimer: Timer!
    var shouldShowNotification=true;
    var notificationIndex=0;
    var notificationQueue: [UIAlertController] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationQueue = [UIAlertController]()
        loadNotifications()
        gameTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: "update", userInfo: nil, repeats: true)        // Do any additional setup after loading the view.
    }

    func update(){
        if(notificationIndex>=notificationQueue.count){
            if(shouldShowNotification){
                gameTimer.invalidate()
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "GameController") as! UIViewController
                self.present(newViewController, animated: true, completion: nil)
            }
            
        }
        else if(shouldShowNotification){
            shouldShowNotification=false
            // notificationTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: "notify", userInfo: nil, repeats: true)
            let dismiss = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
                self.shouldShowNotification=true
                //Start your second timer
            })
            notificationQueue[notificationIndex].addAction(dismiss)
            self.present(notificationQueue[notificationIndex], animated: true, completion: nil)
            notificationIndex += 1

        }
    
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func createUIAlert(speaker: String, dialogue: String){
        let alertController = UIAlertController(title: speaker, message:dialogue, preferredStyle: UIAlertControllerStyle.alert)
        //  alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        notificationQueue.append(alertController)
    
    }
    
    func loadNotifications(){
        createUIAlert(speaker:"???", dialogue:"Wake up! Wake up! Do you know what happened? Where did he go?")
        createUIAlert(speaker:"You", dialogue:"What? Who are you?")
        createUIAlert(speaker:"???", dialogue:"Do you not remember?")
        createUIAlert(speaker:"You", dialogue:"No")
        createUIAlert(speaker:"???", dialogue:"You must have had a complete blackout")
        createUIAlert(speaker:"???", dialogue:"Well, anyways, here's the gist of it: I'm Carnegie Pepper, your boss.")
        createUIAlert(speaker:"Carnegie Pepper", dialogue:"Last night, you were taken by a mysterious figure. A friend of mine and I went on a rescue mission to find you.")
        createUIAlert(speaker:"Carnegie Pepper", dialogue:"We searched the entire campus, until we finally found you, captive of this mysterious person.")
        createUIAlert(speaker:"Carnegie Pepper", dialogue:"We were able to free you eventually, but in the process, the mystery man imprisoned my friend.")
        createUIAlert(speaker:"Carnegie Pepper", dialogue:"He’s a really close friend of mine and of everyone at the university here likes him. AWe need your help to find him. What do you say?")
        createUIAlert(speaker: "You", dialogue: "Sure!")
        createUIAlert(speaker:"Carnegie Pepper", dialogue:"Before we start, I would recommend you looking through the Facebook page ‘Carnegie Mellon memes for Spicy Teens’ to get hints for this adventure.")
        createUIAlert(speaker:"Carnegie Pepper", dialogue:"Okay, this mystery-man is in hiding. I have a feeling he is in a really shady place. This would be a place full of cheaters and fence vandals. Do you know such a place?")
        
    }
}
