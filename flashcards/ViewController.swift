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
    
    // Button to remember what the correct answer is
    var correctAnswerButton: UIButton!
    
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String, extraAnswerTwo: String, extraAnswerThree: String, isExisting: Bool) {
        let flashcard = Flashcard(question: question, answer: answer, extraAnswerOne: extraAnswerOne, extraAnswerTwo: extraAnswerTwo, extraAnswerThree: extraAnswerThree)
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        btnOptionOne.setTitle(flashcard.extraAnswerOne, for: .normal)
        btnOptionTwo.setTitle(flashcard.extraAnswerTwo, for: .normal)
        btnOptionThree.setTitle(flashcard.extraAnswerThree, for: .normal)
        
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
        
        // Update buttons
        let buttons = [btnOptionOne, btnOptionTwo, btnOptionThree].shuffled()
        let answers = [currentFlashcard.answer, currentFlashcard.extraAnswerOne, currentFlashcard.extraAnswerTwo].shuffled()
        
        for (button, answer) in zip(buttons, answers) {
            // Set the title of this random button, with a random answer
            button?.setTitle(answer, for: .normal)
            
            // If this is the correct answer, save the button
            if answer == currentFlashcard.answer {
                correctAnswerButton = button
            }
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // First start with the flashcard invisible and slightly smaller in size
        card.alpha = 0.0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        // Animation for card
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.card.alpha = 1.0
            self.card.transform = CGAffineTransform.identity
        })
        
        // First start with btnOptionOne invisible and slightly smaller in size
        btnOptionOne.alpha = 0.0
        btnOptionOne.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        // Animation for btnOptionOne
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.btnOptionOne.alpha = 1.0
            self.btnOptionOne.transform = CGAffineTransform.identity
        })
        
        // First start with btnOptionTwo invisible and slightly smaller in size
        btnOptionTwo.alpha = 0.0
        btnOptionTwo.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        // Animation for btnOptionTwo
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.btnOptionTwo.alpha = 1.0
            self.btnOptionTwo.transform = CGAffineTransform.identity
        })
        
        // First start with btnOptionThree invisible and slightly smaller in size
        btnOptionThree.alpha = 0.0
        btnOptionThree.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        // Animation for btnOptionThree
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.btnOptionThree.alpha = 1.0
            self.btnOptionThree.transform = CGAffineTransform.identity
        })
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
        flipFlashcard()
    }
    
    // animate flipping of flashcard
    func flipFlashcard() {
        // frontLabel.isHidden = !frontLabel.isHidden
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {self.frontLabel.isHidden = true})
    }
    
    func animateCardOut() {
        UIView.animate(withDuration: 0.3, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }, completion: { finshhed in
            // Update labels
            self.updateLabels()
            
            // Run other animation
            self.animateCardIn()
        })
    }
    
    func animateCardIn() {
        // Start on the right side (don't anime this)
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        
        // Anime card going back to its original position
        UIView.animate(withDuration: 0.3){
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func animateCardOutReverse() {
        UIView.animate(withDuration: 0.3, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        }, completion: { finshhed in
            // Update labels
            self.updateLabels()
            
            // Run other animation
            self.animateCardInReverse()
        })
    }
    
    func animateCardInReverse() {
        // Start on the right side (don't anime this)
        card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        
        // Anime card going back to its original position
        UIView.animate(withDuration: 0.3){
            self.card.transform = CGAffineTransform.identity
        }
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
        // If correct answer flip flashcard, else disable button and show front label
        if btnOptionOne == correctAnswerButton {
            flipFlashcard()
        } else {
            frontLabel.isHidden = false
            btnOptionOne.isEnabled = false
        }
    }
    @IBAction func didTapOptionTwo(_ sender: Any) {
        // If correct answer flip flashcard, else disable button and show front label
        if btnOptionTwo == correctAnswerButton {
            flipFlashcard()
        } else {
            frontLabel.isHidden = false
            btnOptionTwo.isEnabled = false
        }
    }
    @IBAction func didTapOptionThree(_ sender: Any) {
        // If correct answer flip flashcard, else disable button and show front label
        if btnOptionThree == correctAnswerButton {
            flipFlashcard()
        } else {
            frontLabel.isHidden = false
            btnOptionThree.isEnabled = false
        }
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        // Decrease current index
        currentIndex = currentIndex - 1
        
        // Update labels
        updateLabels()
        
        // Flip flashcard back to question
        frontLabel.isHidden = false
        
        // Update buttons
        updateNextPrevButtons()
        
        // Animate card
        animateCardOutReverse()
    }
    @IBAction func didTapOnNext(_ sender: Any) {
        // Increase current index
        currentIndex = currentIndex + 1
        
        // Update labels
        updateLabels()
        
        // Flip flashcard back to question
        frontLabel.isHidden = false
        
        // Update buttons
        updateNextPrevButtons()
        
        // Animate card
        animateCardOut()
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
