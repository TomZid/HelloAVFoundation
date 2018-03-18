//
//  ViewController.swift
//  Audio_Looper
//
//  Created by Tom.Zid on 18/03/2018.
//  Copyright © 2018 TZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let playerController = PlayerManger()
    @IBOutlet weak var controlButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func controlButtonClicked(_ sender: UIButton) {
        var string = "stop"
        if self.playerController.currentState == .stop {
            self.playerController.playAll()
            string = "play"
        }else if self.playerController.currentState == .playing {
            self.playerController.stopAll()
            string = "stop"
        }
        
        self.controlButton.setTitle(string, for: UIControlState.normal)
    }
    
}

