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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnFlashCard(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
}

