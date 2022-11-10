//
//  ViewController.swift
//  TwitterStats
//
//  Created by Giorgi Samkharadze on 02.11.22.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate, twitterManagerDelegate{
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    
    var twitman = twitterManager()
    let delay : Double = 3.0
    
    
    var PositiveScore1 = 0
    var NegativeScore1 = 0
    var NeutralScore1 = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        twitman.delegate = self
        textField.delegate = self
        textField.layer.cornerRadius = 25.0
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    @IBAction func predictPressed(_ sender: Any) {
        twitman.fetchTweets(textField.text!)
        if textField.text!.count != 0 {
        
        DispatchQueue.main.async {
        self.performSegue(withIdentifier: "GoTo2nd", sender: self)
        
        }
        } else {
            textField.placeholder = "Please Type Something!"
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "How People feel about..."
            return false
        }
    }
    
    func didUpdateReacts(positive: Int, negative: Int, neutral: Int) {
        DispatchQueue.main.async {
            self.PositiveScore1 = positive
            self.NegativeScore1 = negative
            self.NeutralScore1 = neutral
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "GoTo2nd" {
               let destinationVC = segue.destination as! SecondViewController
               destinationVC.infovalue = textField.text
               destinationVC.negtivevalue = "\(NegativeScore1)% Negative"
               destinationVC.positivevalue = "\(PositiveScore1)% Positive"
               destinationVC.neutralvalue = "\(NeutralScore1)% Neutral"
               var charindex = 0.0
               for i in 0..<8 {
                   Timer.scheduledTimer(withTimeInterval: 0.5 * charindex, repeats: false) { timer in
                       destinationVC.Label1.text! += "."
                       if destinationVC.Label1.text! == "Wait...."{
                           destinationVC.Label1.text! = "Wait"
                       }
                       
                   }
                   charindex += 1
               }
           }
        
//        if segue.identifier == "GoTo2nd" {
//            let destinationVC2 = segue.destination as! SecondViewController
//            var charindex = 0.0
//            for i in 0..<10 {
//                Timer.scheduledTimer(withTimeInterval: 0.5 * charindex, repeats: false) { timer in
//                    destinationVC2.Label1.text! += "."
//                    if destinationVC2.Label1.text! == "Wait...."{
//                        destinationVC2.Label1.text! = "Wait"
//                    }
//                    
//                }
//                charindex += 1
//            }
//            
//        }
       }
    
}
