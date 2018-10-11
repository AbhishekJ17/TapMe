//
//  ViewController.swift
//  FirstGame
//
//  Created by Abhishek Jadhav on 12/11/17.
//  Copyright © 2017 Abhishek Jadhav. All rights reserved.
//

import UIKit
//import GoogleMobileAds

class ViewController: UIViewController {

    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var highScoreLabelValue: UILabel!
    @IBOutlet weak var startGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highScoreLabel.layer.cornerRadius = 5.0
        startGameButton.layer.cornerRadius = 5.0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let userDefaults = UserDefaults.standard
        let value = userDefaults.string(forKey: "Record")
        highScoreLabelValue.text = value != nil ? value : "0"
        
    }

}

