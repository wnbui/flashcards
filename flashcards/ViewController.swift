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
        
        btnOptionOne.layer.cornerRadius = 10.0
        btnOptionOne.layer.borderWidth = 5.0
        btnOptionOne.layer .borderColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
        btnOptionOne.layer.shadowRadius = 15.0
        btnOptionOne.layer.shadowOpacity = 2.0
        
        btnOptionTwo.layer.cornerRadius = 10.0
        btnOptionTwo.layer.borderWidth = 5.0
        btnOptionTwo.layer .borderColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
        btnOptionTwo.layer.shadowRadius = 15.0
        btnOptionTwo.layer.shadowOpacity = 2.0
        
        btnOptionThree.layer.cornerRadius = 10.0
        btnOptionThree.layer.borderWidth = 5.0
        btnOptionThree.layer .borderColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
        btnOptionThree.layer.shadowRadius = 15.0
        btnOptionThree.layer.shadowOpacity = 2.0
    }
    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
    @IBAction func tapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden = !frontLabel.isHidden
    }
    
    // multiple choice btns
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // We know the destination of the segue is the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        // We know the Navigation Controller only contains a Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        // We set the flashcardsController property to self
        creationController.flashcardsController = self
        
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
        }
    }
    
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isHidden = true
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        frontLabel.isHidden = !frontLabel.isHidden
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true
    }
 
    func unpdateFlashcard(question: String, answer: String, extraAnswerOne: String, extraAnswerTwo: String, extraAnswerThree: String) {
        frontLabel.text = question
        backLabel.text = answer
        
        btnOptionOne.setTitle(extraAnswerOne, for: .normal)
        btnOptionTwo.setTitle(extraAnswerTwo, for: .normal)
        btnOptionThree.setTitle(extraAnswerThree, for: .normal)
    }
}

