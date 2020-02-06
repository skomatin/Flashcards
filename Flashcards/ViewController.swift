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
        op1.isHidden = true
    }
    
    @IBAction func option2(_ sender: Any) {
        op2.isHidden = true
    }
    
    @IBAction func option3(_ sender: Any) {
        op3.backgroundColor = UIColor.green
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
    
}

