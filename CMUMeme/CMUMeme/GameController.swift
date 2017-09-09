//
//  GameController.swift
//  CMUMeme
//
//  Created by Kevin Bender on 9/9/17.
//  Copyright © 2017 HamHack. All rights reserved.
//

import UIKit
import CoreLocation
import AudioToolbox

class GameController: UIViewController, CLLocationManagerDelegate,UIAlertViewDelegate
{
    

    @IBOutlet var distLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var desLabel: UILabel!
    

    
    
    var previousLocation: CLLocation!
    var locationManager: CLLocationManager!
    var gameTimer: Timer!
    var locations: [Landmark]!
    var locationIndex = 0
    var notificationTriggered=false;

    override func viewDidLoad() {
        //previousLocation=CLLocation()
        print("Game VIEWDIDLOAD STARTED")
        super.viewDidLoad()
        locationManager = CLLocationManager()
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.delegate=self;
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        locationManager.distanceFilter=1
        locationManager.startUpdatingLocation()
        previousLocation=locationManager.location!
        print("Game VIEWDIDLOAD COMPLETE")

        load();
        // Do any additional setup after loading the view.
        desLabel.lineBreakMode = .byWordWrapping // notice the 'b' instead of 'B'
        desLabel.numberOfLines = 0
        gameTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: "update", userInfo: nil, repeats: true)
        print("Game VIEWDIDLOAD COMPLETE")
        

    }
    
    var shouldShowNotification = true
    
    
    
    
     func update(){
        
        if(locationIndex>=locations.count&&shouldShowNotification){
            gameTimer.invalidate()
            print("Finished")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "EndViewController") as! UIViewController
            self.present(newViewController, animated: true, completion: nil)
            
            
        }
            else if(locationIndex<locations.count){
        let l = locationManager.location
        let x=l!.distance(from: locations[locationIndex].location)
        distLabel.text = String(describing: Int(x)) + " meters"
        desLabel.text=locations[locationIndex].description
        imageView.image=locations[locationIndex].meme
        if(locations[locationIndex].isInRadius(currentLocation: l!) && !notificationTriggered){
            notificationTriggered=true;
            locations[locationIndex].playDialogue(controller: self)
        }
        if(shouldShowNotification&&notificationTriggered){
            if(locations[locationIndex].playDialogue(controller: self)){
                notificationTriggered=false;
                locationIndex += 1
                if(locationIndex<locations.count){
                    shouldShowNotification=true;
                }
            }
        }
        }
    }
 

    
    @IBAction func updateButton(_ sender: UIButton, forEvent event: UIEvent) {
    
        print(String(previousLocation.distance(from: locationManager.location!)))
        previousLocation=locationManager.location!
    }
    func load(){//load location data and dialogue
        locations=[Landmark]()
        let wts: CLLocation = CLLocation(latitude: CLLocationDegrees(exactly: 40.4441553)!, longitude: CLLocationDegrees(exactly: -79.94286720000002)!)
        let stever: CLLocation = CLLocation(latitude: CLLocationDegrees(exactly: 40.4461735)!, longitude: CLLocationDegrees(exactly: -79.94264079999999)!)
        let signal: CLLocation = CLLocation(latitude: CLLocationDegrees(exactly: 40.44463)!, longitude: CLLocationDegrees(exactly: -79.943045)!)
        let gates: CLLocation = CLLocation(latitude: CLLocationDegrees(exactly: 40.4435476)!, longitude: CLLocationDegrees(exactly: -79.94461839999997)!)
        let scaife: CLLocation = CLLocation(latitude: CLLocationDegrees(exactly: 40.4418248)!, longitude: CLLocationDegrees(exactly: -79.94732269999997)!)
        let baker: CLLocation = CLLocation(latitude: CLLocationDegrees(exactly: 40.441764)!, longitude: CLLocationDegrees(exactly: -79.945442)!)
        let ucstones: CLLocation = CLLocation(latitude: CLLocationDegrees(exactly: 40.444249)!, longitude: CLLocationDegrees(exactly: -79.941946)!)
        
        locations.append( Landmark(name1: "Stever House", location1: stever, radius1: 30, imgName: "stever.jpg", des: "The home of cheaters, ask a freshman if you don't know"))
        locations[0].addDialogue(speaker: "Carnegie Pepper", dialogue: "What! Nothing in Stever? But I had such a strong feeling!")
        locations[0].addDialogue(speaker: "Carnegie Pepper", dialogue: "I guess I was wro-")
        locations[0].addDialogue(speaker: "Carnegie Pepper", dialogue: "Wait, what is that I hear?")
        // cue the beep boop sound
        locations[0].addDialogue(speaker: "Carnegie Pepper", dialogue: "Such a common sound of CMU, yet so irritating. Take me there!")
        locations.append( Landmark(name1: "Beep Boop", location1: signal, radius1: 15, imgName: "beepBoop.jpg", des: "Where is the most common CMU sound heard?"))

        locations[1].addDialogue(speaker: "Carnegie Pepper", dialogue: "Look! There's a mysterious figure near the cut!")
        locations[1].addDialogue(speaker: " ", dialogue: "You see a round, shadowy figure, near the 'walk to the sky' statue.")
        locations[1].addDialogue(speaker: "Carnegie Pepper", dialogue: "Quick, Naruto run to the statue!")
        print(1)

        locations.append( Landmark(name1: "Walking to the Sky", location1: wts, radius1: 15, imgName: "wts.jpg", des: "Naruto run to the sky"))
        locations[2].addDialogue(speaker: "Carnegie Pepper", dialogue: "We missed him!")
        locations[2].addDialogue(speaker: "Carnegie Pepper", dialogue: "But it doesn't matter... because he has a very distinct smell. Take a sniff!")
        locations[2].addDialogue(speaker: "", dialogue: "You take a smell of the air around, but you immediately regret it. The putrid odor of the surrounding area gives you a nauseating feeling.")
        locations[2].addDialogue(speaker: "You", dialogue: "(almost puking) Ugh! Why did you make me do that?")
        locations[2].addDialogue(speaker: "Carnegie Pepper", dialogue: "Now you know... Where will you find someone who smells like that?")
        locations[2].addDialogue(speaker: "You", dialogue: "Um... Hamerschlag Hall?")
        locations[2].addDialogue(speaker: "Carnegie Pepper", dialogue: "The smell was worse than that!")
        locations[2].addDialogue(speaker: "Carnegie Pepper", dialogue: "Take me to a place where you’ll find a lot of people who don’t shower!")
        print(2)

        locations.append( Landmark(name1: "Gates-Hillman Complex", location1: gates, radius1: 55, imgName: "gates.jpg", des: "Where would you definitely not find a shower?"))
        locations[3].addDialogue(speaker: "Carnegie Pepper", dialogue: "He's nowhere to be found!")
        locations[3].addDialogue(speaker: "Carnegie Pepper", dialogue: "Ooh, SCS students! Let's ask them")
        locations[3].addDialogue(speaker: "You", dialogue: "How would they know?")
        locations[3].addDialogue(speaker: "Carnegie Pepper", dialogue: "They're SCS students, they know everything!")
        locations[3].addDialogue(speaker: "", dialogue: "Carnegie Pepper finds a random CS major")
        locations[3].addDialogue(speaker: "Carnegie Pepper", dialogue: "Hey! Can you help me?")
        locations[3].addDialogue(speaker: "", dialogue: "He proceeds to explain everything that had happened to the SCS student")
        locations[3].addDialogue(speaker: "SCS student", dialogue: "It sounds like this person wants to hide from you. He must be at some place which is very difficult to reach.")
        locations[3].addDialogue(speaker: "Carnegie Pepper", dialogue: "Oh yes! Let's go there")
        
        
        locations.append( Landmark(name1: "Scaife Hall", location1: scaife, radius1: 40, imgName: "scaife.jpg", des: "The most difficult place to find on campus"))
        locations[4].addDialogue(speaker: "Carnegie Pepper", dialogue: "No leads here either! Dammit!")
        locations[4].addDialogue(speaker: "Carnegie Pepper", dialogue: "Wait a second... What's written on your arm?")
        locations[4].addDialogue(speaker: "", dialogue: "You look at your arm and see a long, smudged mark. It looks like a sentence was written, but then rubbed out. However, you can make out the words 'same building' as the last two words of the sentence.")
        locations[4].addDialogue(speaker: "You", dialogue: "This must be from last night")
        locations[4].addDialogue(speaker: "Carnegie Pepper", dialogue: "Same Building?")
        locations[4].addDialogue(speaker: "You", dialogue: "Hmm… Maybe this is where the mystery figure is hiding! Let’s go there")
        print(0)

        
        locations.append( Landmark(name1: "Baker / Porter Hall", location1: baker, radius1: 50, imgName: "baker.jpg", des: "Is it two buildings? Is it one building? Who knows?"))
        locations[5].addDialogue(speaker: "Carnegie Pepper", dialogue: "So... Baker and Porter are the same building? Really? This is going to keep me up at night")
        locations[5].addDialogue(speaker: "You", dialogue: "Hey look, a piece of paper!")
        locations[5].addDialogue(speaker: "", dialogue: "You pick up the piece of paper and start reading it.")
        locations[5].addDialogue(speaker: "You", dialogue: "'Ha! You thought they'd be here, but they aren't. You will never free your stones!")
        locations[5].addDialogue(speaker: "Carnegie Pepper", dialogue: "Nooooooooooooo!")
        locations[5].addDialogue(speaker: "You", dialogue: "'free your stones'?")
        locations[5].addDialogue(speaker: "Carnegie Pepper", dialogue: "Yes, free the stones. My friend is a bunch of stones... But now we'll never find him!")
        locations[5].addDialogue(speaker: "You", dialogue: "We will find him! I know where he is.")
        locations[5].addDialogue(speaker: "Carnegie Pepper", dialogue: "You do?")
        locations[5].addDialogue(speaker: "You", dialogue: "Yes! I'll take you there and we'll free the stones")
        
        locations.append( Landmark(name1: "UC Stones", location1: ucstones, radius1: 30, imgName: "ucstones.jpg", des: "Go to the caged stones"))
        locations[6].addDialogue(speaker: "Carnegie Pepper", dialogue: "I can't believe it! I thought I'd never see you again!")
        locations[6].addDialogue(speaker: "UC Stones", dialogue: "Hey, old friend. How's it going?")
        locations[6].addDialogue(speaker: "You", dialogue: "After saying that, the UC Stones squirm, and a mysterious figure starts speaking from the shadows.")
        locations[6].addDialogue(speaker: "???", dialogue: "Well, well, well. Look who it is.")
        locations[6].addDialogue(speaker: "???", dialogue: "I've been waiting for you, Carnegie Pepper.")
        locations[6].addDialogue(speaker: "Carnegie Pepper", dialogue: "You... Reveal yourself.")
        locations[6].addDialogue(speaker: "???", dialogue: "Oh, I've already revealed myself to you, but I'll do it again.")
        // reveal Andrew Melon
        locations[6].addDialogue(speaker: "Carnegie Pepper", dialogue: "You!")
        locations[6].addDialogue(speaker: "Andrew Melon", dialogue: "Yes, me!")
        locations[6].addDialogue(speaker: "Carnegie Pepper", dialogue: "Free the UC Stones!")
        locations[6].addDialogue(speaker: "Andrew Melon", dialogue: "Why should I do that, when you chose David Pepper over me?")
        locations[6].addDialogue(speaker: "Carnegie Pepper", dialogue: "That was a long time ago!")
        locations[6].addDialogue(speaker: "Andrew Melon", dialogue: "You still have his name!")
        locations[6].addDialogue(speaker: "Carnegie Pepper", dialogue: "Let it go!")
        locations[6].addDialogue(speaker: "Andrew Melon", dialogue: "MCS > TEPPER")
        locations[6].addDialogue(speaker: "Carnegie Pepper", dialogue: "I know, but-")
        locations[6].addDialogue(speaker: "Andrew Melon", dialogue: "But there's nothing you can say to me that'll make things better")
        locations[6].addDialogue(speaker: "Andrew Melon", dialogue: "I don't want to see your face anymore!")
        locations[6].addDialogue(speaker: "", dialogue: "Andrew Melon storms off")
        locations[6].addDialogue(speaker: "Carnegie Pepper", dialogue: "The breakup was rough on him")
        locations[6].addDialogue(speaker: "UC Stones", dialogue: "Help! I don't like being trapped")
        locations[6].addDialogue(speaker: "Carnegie Pepper", dialogue: "Almost forgot, we have to free him! Quick!")
        // cue minigame
        locations[6].addDialogue(speaker: "Carnegie Pepper", dialogue: "We can finally free the UC stones!")
        // cue credits
        
        
    }
    /*OLD VERSION OF LOAD
    func load(){
        locations=[Landmark]()
        let wts: CLLocation = CLLocation(latitude: CLLocationDegrees(exactly: 40.4441553)!, longitude: CLLocationDegrees(exactly: --79.94286720000002)!)
        let ham: CLLocation = CLLocation(latitude: CLLocationDegrees(exactly: 40.44117639653405)!, longitude: CLLocationDegrees(exactly: --79.9390621483326)!)
        
        
        locations.append(Landmark(name1: "Hamerschlag House", location1: ham, radius1: 40, imgName: "ham.jpg", des:"No cooties allowed here"))
        
        locations[0].addDialogue(speaker: "Carnegie Pepper", dialogue: "Hello")
        locations[0].addDialogue(speaker: "Carnegie Pepper", dialogue: "memes")
        locations.append(Landmark(name1: "Walking to the Sky", location1: wts, radius1: 15, imgName: "wts.jpg", des: "Naruto run to the sky"))
        
        let stever: CLLocation = CLLocation(latitude: CLLocationDegrees(exactly: 40.4461735)!, longitude: CLLocationDegrees(exactly: -79.94264079999999)!)
        locations.append( Landmark(name1: "Stever House", location1: stever, radius1: 30, imgName: "stever.jpg", des: "The home of cheaters, ask a freshman if you don't know"))

        
    }
 */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
