//
//  ViewController.swift
//  Flashcards
//
//  Created by Saikiran Komatineni on 2/5/20.
//  Copyright © 2020 Saikiran Komatineni. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var option2: String
    var option3: String
    var option4: String
}

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
    @IBOutlet weak var op1: UIButton!
    @IBOutlet weak var op2: UIButton!
    @IBOutlet weak var op3: UIButton!
    @IBOutlet weak var op4: UIButton!
    
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    var correctAnswerButton: UIButton!
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.deleteCurrentFlashcard()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func deleteCurrentFlashcard() {
        if currentIndex != 0 {
            flashcards.remove(at: currentIndex)
        }
        
        if currentIndex > flashcards.count - 1 {
            currentIndex = currentIndex - 1
        }
        
        updateLabels()
        updateNxtPrevButtons()
        saveAllFlashcardsToDisk()
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        
//        updateLabels()
            animateCardOut()
        updateNxtPrevButtons()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        animateCardOut()
        
        updateNxtPrevButtons()
    }
    
    @IBAction func option1(_ sender: Any) {
//        op1.backgroundColor = UIColor.green
        if op1 == correctAnswerButton {
            flipFlashcard()
        } else {
            frontLabel.isHidden = false
            op1.isHidden = true
        }
    }
    
    @IBAction func option2(_ sender: Any) {
//        op2.isHidden = true
        if op2 == correctAnswerButton {
            flipFlashcard()
        } else {
            frontLabel.isHidden = false
            op2.isHidden = true
        }
    }
    
    @IBAction func option3(_ sender: Any) {
//        op3.isHidden = true
        if op3 == correctAnswerButton {
            flipFlashcard()
        } else {
            frontLabel.isHidden = false
            op3.isHidden = true
        }
    }
    
    @IBAction func option4(_ sender: Any) {
//        op4.isHidden = true
        if op4 == correctAnswerButton {
            flipFlashcard()
        } else {
            frontLabel.isHidden = false
            op4.isHidden = true
        }
    }
    
    func updateLabels() {
        let currentFlashcard = flashcards[currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        
        op1.setTitle(currentFlashcard.answer, for: .normal)
        op2.setTitle(currentFlashcard.option2, for: .normal)
        op3.setTitle(currentFlashcard.option3, for: .normal)
        op4.setTitle(currentFlashcard.option4, for: .normal)
        
        op1.backgroundColor = nil
        op2.isHidden = false
        op3.isHidden = false
        op4.isHidden = false
        
        let buttons = [op1, op2, op3, op4].shuffled()
        let answers = [currentFlashcard.answer, currentFlashcard.option2, currentFlashcard.option3, currentFlashcard.option4].shuffled()
        
        for (button, answer) in zip(buttons, answers) {
            button?.setTitle(answer, for: .normal)
            
            if answer == currentFlashcard.answer {
                correctAnswerButton = button
            }
        }
    }
    
    func saveAllFlashcardsToDisk() {
        let dictionaryArray = flashcards.map { (card) -> [String:String] in
            return ["question": card.question, "answer": card.answer, "option2": card.option2, "option3": card.option3, "option4": card.option4]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("Flashcards saved to Userdefaults")
    }
    
    func readSavedFlashcards() {
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, option2: dictionary["option2"]!, option3: dictionary["option3"]!, option4: dictionary["option4"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        card.alpha = 0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.card.alpha = 1
            self.card.transform = CGAffineTransform.identity
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readSavedFlashcards()
        
        if flashcards.count == 0 {
            updateFlashcard(question: "What is 1+1", Answer: "2", option2: "1", option3: "3", option4: "0", isExisting: false)
        }
        else {
            updateLabels()
            updateNxtPrevButtons()
        }
        
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnFlashCard(_ sender: Any) {
        
        flipFlashcard()
    }
    
    func flipFlashcard() {
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            if self.frontLabel.isHidden {
                self.frontLabel.isHidden = false
            }
            else {
                self.frontLabel.isHidden = true
            }
        })
            
    }
    
    func animateCardIn() {
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity
        })
    }
    
    func animateCardOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }, completion: { finished in
            self.updateLabels()
            self.animateCardIn()
        })
    }
    
    func updateNxtPrevButtons() {
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        }
        else {
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0 {
            prevButton.isEnabled = false
        }
        else {
            prevButton.isEnabled = true
        }
    }

    func updateFlashcard(question: String, Answer: String, option2: String, option3: String, option4: String, isExisting: Bool) {
        
        let flashcard = Flashcard(question: question, answer: Answer, option2: option2, option3: option3, option4: option4)
        
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        op1.setTitle(flashcard.answer, for: .normal)
        op2.setTitle(flashcard.option2, for: .normal)
        op3.setTitle(flashcard.option3, for: .normal)
        op4.setTitle(flashcard.option4, for: .normal)
        
        op1.backgroundColor = nil
        op2.isHidden = false
        op3.isHidden = false
        op4.isHidden = false
        
        if isExisting {
            flashcards[currentIndex] = flashcard
        }
        else {
        
            flashcards.append(flashcard)
            print("Added new Flashcard")
            print("We now have \(flashcards.count) flashcards")
            
            currentIndex = flashcards.count - 1
            print("Our current index is \(currentIndex)")
        }
        
        updateNxtPrevButtons()
        
        updateLabels()
        
        saveAllFlashcardsToDisk()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
        }
    }
    
    
}

