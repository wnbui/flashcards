//
//  ViewController.swift
//  flashcards
//
//  Created by William Bui on 9/13/22.
//

import UIKit

// Flashcard struct (class)
struct Flashcard {
    var question: String
    var answer: String
    var extraAnswerOne: String
    var extraAnswerTwo: String
    var extraAnswerThree: String
}

class ViewController: UIViewController {
    
    // Array to hold your flashcards
    var flashcards = [Flashcard]()
    
    // Current flashcard index
    var currentIndex = 0
    
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String, extraAnswerTwo: String, extraAnswerThree: String, isExisting: Bool) {
        let flashcard = Flashcard(question: question, answer: answer, extraAnswerOne: extraAnswerOne, extraAnswerTwo: extraAnswerTwo, extraAnswerThree: extraAnswerThree)
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        btnOptionOne.setTitle(extraAnswerOne, for: .normal)
        btnOptionTwo.setTitle(extraAnswerTwo, for: .normal)
        btnOptionThree.setTitle(extraAnswerThree, for: .normal)
        
        if isExisting {
            flashcards[currentIndex] = flashcard
        }
        else
        {
            // Adding new flashcards
            flashcards.append(flashcard)
            
            // Logging to the console
            print("Added a new Flashcard , take a look -> ", flashcards)
            print("We now have \(flashcards.count) flashcards")
            
            // Update current index
            currentIndex = flashcards.count - 1
            print("Our current index is \(currentIndex)")
        }
        
        // Update buttons
        updateNextPrevButtons()
        
        // Update labels
        updateLabels()
        
        // Save flashcard
        saveAllFlashcardsToDisk()
    }
    
    func updateLabels() {
        //Get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        // Update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    func updateNextPrevButtons(){
        // Disable next button if at the end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        }
        else {
            nextButton.isEnabled = true
        }
        // Disable prev button if at the beginning
        if currentIndex == 0 {
            prevButton.isEnabled = false
        }
        else {
            prevButton.isEnabled = true
        }
    }
    
    func saveAllFlashcardsToDisk() {
        // From flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer, "extraAnswerOne": card.extraAnswerOne, "extraAnswerTwo": card.extraAnswerTwo, "extraAnswerThree": card.extraAnswerThree]
        }
        // Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        // Log it
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards() {
        // Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            // In here we know for sure we hae a dictionary array
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraAnswerOne: dictionary["extraAnswerOne"]!, extraAnswerTwo: dictionary["extraAnswerTwo"]!, extraAnswerThree: dictionary["extraAnswerThree"]!)
            }
            // Put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Read saved flashcards
        readSavedFlashcards()
        
        // Adding our initial flashcard if needed
        if flashcards.count == 0 {
            updateFlashcard(question: "What is the question?", answer: "This is the answer", extraAnswerOne: "one", extraAnswerTwo: "two", extraAnswerThree: "three", isExisting: true)
        }
        else {
            updateLabels()
            updateNextPrevButtons()
        }
        
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
    
    // main flashcard and answer
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
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
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
    
    // Action buttons
    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isHidden = true
    }
    @IBAction func didTapOptionTwo(_ sender: Any) {
        frontLabel.isHidden = !frontLabel.isHidden
    }
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        // Decrease current index
        currentIndex = currentIndex - 1
        
        // Update labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
    }
    @IBAction func didTapOnNext(_ sender: Any) {
        // Increase current index
        currentIndex = currentIndex + 1
        
        // Update labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
    }
    func deleteCurrentFlashcard(){
        // Delete current flashcard
        flashcards.remove(at: currentIndex)
        
        // Special case:  Check if last card was deleted
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        
        updateNextPrevButtons()
        
        updateLabels()
        
        saveAllFlashcardsToDisk()
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        // Show confirmation
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        present(alert, animated: true)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
    }
}
