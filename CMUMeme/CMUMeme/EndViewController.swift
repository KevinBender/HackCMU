//
//  EndViewController.swift
//  CMUMeme
//
//  Created by Kevin Bender on 9/9/17.
//  Copyright © 2017 HamHack. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {

    @IBOutlet var freeImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func freeTheStones(_ sender: UIButton) {
        freeImage.image = UIImage(named: "freestones.png")
        let alertController = UIAlertController(title: "Carnegie Pepper", message:"You have freed the UC Stones and are a hero to the CMU!", preferredStyle: UIAlertControllerStyle.alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(dismiss)
        self.present(alertController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
