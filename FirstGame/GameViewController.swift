//
//  GameViewController.swift
//  FirstGame
//
//  Created by Abhishek Jadhav on 12/11/17.
//  Copyright © 2017 Abhishek Jadhav. All rights reserved.
//

import UIKit


class GameViewController: UIViewController {

    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var tapMeButton: UIButton!
    @IBOutlet weak var scoreLabelValue: UILabel!
    
    var tapInt = 0
    var startInt = 0
    var startTimer = Timer()
    var gameInt = 0
    var gameTimer = Timer()
    var recordData : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeRemainingLabel.layer.cornerRadius = 5.0
        scoreLabel.layer.cornerRadius = 5.0
        tapMeButton.layer.cornerRadius = 5.0
        
        tapInt = 0
        scoreLabelValue.text = String(tapInt)
        
        startInt = 3
        tapMeButton.setTitle(String(startInt), for: .normal)
        tapMeButton.isEnabled = false
        startTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startGameTimer), userInfo: nil, repeats: true)
        
        gameInt = 10
        timeRemainingLabel.text = String(gameInt)
        
        let userDefaults = UserDefaults.standard
        let value = userDefaults.string(forKey: "Record")
        recordData = value
    }

    @IBAction func tapMeButtonPressed(_ sender: Any) {
        
        tapInt += 1
        scoreLabelValue.text = String(tapInt)
    }
    
    @objc func startGameTimer(){
        
        startInt -= 1
        tapMeButton.setTitle(String(startInt), for: .normal)
        
        if startInt == 0{
            startTimer.invalidate()
            tapMeButton.setTitle("Tap Me", for: .normal)
            tapMeButton.isEnabled = true
            gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(gameTime), userInfo: nil, repeats: true)
            
        }
        
    }
    
    @objc func gameTime(){
        gameInt -= 1
        timeRemainingLabel.text = String(gameInt)
        
        if gameInt == 0{
            gameTimer.invalidate()
            tapMeButton.isEnabled = false
            
            let savedString = scoreLabelValue.text
            let userDefaults = UserDefaults.standard
            
            if recordData == nil{
                userDefaults.set(savedString, forKey: "Record")
            }else{
                let score:Int? = Int(scoreLabelValue.text!)
                let record:Int? = Int(recordData)
                
                if score! > record!{
                    userDefaults.set(savedString, forKey: "Record")
                }
                
            }
            
            
            
            Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(endGame), userInfo: nil, repeats: false)
        }
    }
    
    @objc func endGame(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EndViewController") as! EndViewController
        vc.score = scoreLabelValue.text
        self.present(vc, animated: false, completion: nil)
    }

}
