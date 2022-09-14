//
//  ViewController.swift
//  flashcards
//
//  Created by William Bui on 9/13/22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 2.0
        backLabel.layer.cornerRadius = 20.0
        backLabel.clipsToBounds =  true
        frontLabel.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
    }
    
    
    @IBOutlet weak var card: UIView!
    
    
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var frontLabel: UILabel!
    
    @IBAction func tapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden = !frontLabel.isHidden
    }
    
}

