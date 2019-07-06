//
//  AddStuffController.swift
//  FamilyFirst
//
//  Created by Benedikt Langer on 24.06.19.
//  Copyright © 2019 Niklas. All rights reserved.
//

import UIKit

protocol AddStuffControllerDelegate {
    func addToArray(addtional: String)
}

class AddStuffController: UIViewController, UITextViewDelegate {
    
    var additional: Additional?
    
    var onDoneButton:((String, String)->())?
    
    var delegate: AddStuffControllerDelegate?
    @IBOutlet weak var titleTextfield: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var myTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.black.cgColor
        
        myTextView.text = "Insert Information"
        myTextView.textColor = UIColor.lightGray
        myTextView.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func titleTextAction(_ sender: UITextField) {
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Insert Information"
            textView.textColor = UIColor.lightGray
        }
    }
    @IBAction func Done(_ sender: UIButton) {
        if let title = titleTextfield.text {
            onDoneButton?(title, myTextView.text)
        }
        dismiss(animated: true)
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
