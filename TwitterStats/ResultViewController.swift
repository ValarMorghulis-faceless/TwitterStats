//
//  ResultViewController.swift
//  TwitterStats
//
//  Created by Giorgi Samkharadze on 05.11.22.
//

import UIKit

class ResultViewController: UIViewController {

    
    var infovalue : String?
    var resultvalue : String?
    var positivevalue: String?
    var negtivevalue: String?
    var neutralvalue: String?
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var neutralLabel: UILabel!
    @IBOutlet weak var negativeLabel: UILabel!
    @IBOutlet weak var positiveLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.text = infovalue
        resultLabel.text = resultvalue
        neutralLabel.text = neutralvalue
        positiveLabel.text = positivevalue
        negativeLabel.text = negtivevalue
    }
    

    @IBAction func restartPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
