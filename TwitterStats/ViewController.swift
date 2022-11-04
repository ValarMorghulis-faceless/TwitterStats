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

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
    let tweetCount = 100
    
    let sentimentClassifier = TweetsSentimentClassifier()
    
    let swifter = Swifter(consumerKey:"99efcaaedqXmcnkuaWuJQFbKR" , consumerSecret: "f2RcL9HJwjwa64hYZZSt6RMtL37j511cyd7fwoWSyQ3NJYOhfd")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.layer.cornerRadius = 25.0
        button.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }

    @IBAction func predictPressed(_ sender: Any) {
        fetchTweets()
        }
    
    func fetchTweets() {
        if let searchText = textField.text {
            
            swifter.searchTweet(using: searchText, lang: "en", count: tweetCount, tweetMode: .extended) { results, metadata in
               // print(results)
                
                var tweets = [TweetsSentimentClassifierInput]()
                
                for i in 0..<self.tweetCount{
                    if let tweet = results[i]["full_text"].string{
                        let tweetForClassification = TweetsSentimentClassifierInput(text: tweet)
                        tweets.append(tweetForClassification)
                    }
                }
                
                makePrediction(with: tweets)
                
            } failure: { error in
                print(error)
            }

    }
    
        func makePrediction(with tweets: [TweetsSentimentClassifierInput]){
        do {
            
          let predicions = try self.sentimentClassifier.predictions(inputs: tweets)
            
            var sentimentScore = 0
            
            for pred in predicions {
                let sentiment = pred.label
                if sentiment == "positive" {
                    sentimentScore += 1
                } else if sentiment == "negative" {
                    sentimentScore -= 1
                }
            }
            
            updateUI(with: sentimentScore)
            
        } catch {
            print("there was an error with making prediction, \(error)")
        }
        
    }
    
        func updateUI(with sentimentScore: Int){
        
        
//
//        if sentimentScore > 20 {
//            self.sentimentLabel.text = "😍"
//        } else if sentimentScore > 10 {
//            self.sentimentLabel.text = "😄"
//        } else if sentimentScore > 0 {
//            self.sentimentLabel.text = "🙂"
//        } else if sentimentScore == 0 {
//            self.sentimentLabel.text = "😐"
//        } else if sentimentScore > -10 {
//            self.sentimentLabel.text = "☹️"
//        } else if sentimentScore > -20 {
//            self.sentimentLabel.text = "😡"
//        } else {
//            self.sentimentLabel.text = "🤮"
//        }
//
        
        
        
        print(sentimentScore)
    }
}

}
