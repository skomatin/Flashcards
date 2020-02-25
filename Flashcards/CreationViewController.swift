//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Saikiran Komatineni on 2/25/20.
//  Copyright © 2020 Saikiran Komatineni. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    var initialQuestion: String?
    var initialAnswer: String?
    
    @IBOutlet weak var option1: UITextField!
    @IBOutlet weak var option2: UITextField!
    @IBOutlet weak var option3: UITextField!
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    var flashcardsController: ViewController!
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        
        let alert  = UIAlertController(title: "Missing Text", message: "You need to enter both a question and an answer", preferredStyle: .alert)
        
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
//            self.dismiss(animated: true, completion: nil)
//        }))
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty {
            present(alert, animated: true, completion: nil)
        }
        else {
            flashcardsController.updateFlashcard(question: questionText!, Answer: answerText!, option2: option1.text!, option3: option2.text!, option4: option3.text!)
            dismiss(animated: true)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
