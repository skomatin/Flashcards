//
//  ViewController.swift
//  Flashcards
//
//  Created by Saikiran Komatineni on 2/5/20.
//  Copyright © 2020 Saikiran Komatineni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    
    @IBOutlet weak var op1: UIButton!
    @IBOutlet weak var op2: UIButton!
    @IBOutlet weak var op3: UIButton!
    @IBOutlet weak var op4: UIButton!
    
    @IBAction func option1(_ sender: Any) {
        op1.backgroundColor = UIColor.green
    }
    
    @IBAction func option2(_ sender: Any) {
        op2.isHidden = true
    }
    
    @IBAction func option3(_ sender: Any) {
        op3.isHidden = true
    }
    
    @IBAction func option4(_ sender: Any) {
        op4.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnFlashCard(_ sender: Any) {
        if frontLabel.isHidden {
            frontLabel.isHidden = false
        }
        else {
            frontLabel.isHidden = true
        }
        
    }
    
    func updateFlashcard(question: String, Answer: String, option2: String, option3: String, option4: String) {
        frontLabel.text = question
        backLabel.text = Answer
        
        op1.setTitle(Answer, for: .normal)
        op2.setTitle(option2, for: .normal)
        op3.setTitle(option3, for: .normal)
        op4.setTitle(option4, for: .normal)
        
        op1.backgroundColor = nil
        op2.isHidden = false
        op3.isHidden = false
        op4.isHidden = false
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

