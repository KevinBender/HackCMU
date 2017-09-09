//
//  ViewController.swift
//  CMUMeme
//
//  Created by Kevin Bender on 9/8/17.
//  Copyright © 2017 HamHack. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController
{
    @IBOutlet weak var locationLabel: UILabel!
    //var locationManager: CLLocationManager!
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "plaid.jpg")!)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

      //  var locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
       // print("locations = \(locValue.latitude) \(locValue.longitude)")
        print("hello")
    }
    

    @IBAction func touch(_ sender: UIButton) {
        //simple()

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "BeginViewController") as! UIViewController
        self.present(newViewController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

