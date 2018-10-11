//
//  EndViewController.swift
//  FirstGame
//
//  Created by Abhishek Jadhav on 20/11/17.
//  Copyright © 2017 Abhishek Jadhav. All rights reserved.
//
import UIKit
import Social
import MessageUI


class EndViewController: UIViewController {
    
    @IBOutlet weak var shareScoreLabel: UILabel!
    @IBOutlet weak var shareTwitterButton: UIButton!
    @IBOutlet weak var shareEmailButton: UIButton!
    @IBOutlet weak var shareSMSButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    
    var score : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        shareScoreLabel.layer.cornerRadius = 5.0
        shareTwitterButton.layer.cornerRadius = 5.0
        shareEmailButton.layer.cornerRadius = 5.0
        shareSMSButton.layer.cornerRadius = 5.0
        scoreLabel.layer.cornerRadius = 5.0
        restartButton.layer.cornerRadius = 5.0
    
        scoreLabel.text = score
    }

   
    @IBAction func restartButtonPressed(_ sender: Any) {
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareTwitterButtonPressed(_ sender: Any) {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            let twitter:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitter.setInitialText("My final score was: \(scoreLabel.text!)")
            self.present(twitter, animated: true, completion: nil)
        }else{
            let alertController = UIAlertController(title: "Accounts", message: "Please log into your twitter account within the settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func shareEmailButtonPressed(_ sender: Any){
        
        if MFMailComposeViewController.canSendMail(){
            let mail: MFMailComposeViewController = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(nil)
            mail.setSubject("I bet you can't beat me!")
            mail.setMessageBody("My final score was: \(scoreLabel.text!)", isHTML: true)
            self.present(mail, animated: true, completion: nil)
        }else{
            let alertController = UIAlertController(title: "Accounts", message: "Please log into your email account", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func shareSMSButtonPressed(_ sender: Any){
        
        if MFMessageComposeViewController.canSendText(){
            let message: MFMessageComposeViewController = MFMessageComposeViewController()
            message.messageComposeDelegate = self
            message.recipients = nil
            message.body = "My final score was: \(scoreLabel.text!)"
            self.present(message, animated: true, completion: nil)
        }else{
            let alertController = UIAlertController(title: "Warning", message: "This device cannot send message", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}


extension EndViewController : MFMailComposeViewControllerDelegate{
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension EndViewController: MFMessageComposeViewControllerDelegate{
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
}
