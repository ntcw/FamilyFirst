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
    var onDoneButton: ((String, String) -> Void)?

    var delegate: AddStuffControllerDelegate?
    @IBOutlet var titleTextfield: UITextField!

    @IBOutlet var button: UIButton!

    @IBOutlet var myTextView: UITextView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "multi")?.draw(in: view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor(patternImage: image)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        myTextView.text = "Insert Information"
        myTextView.textColor = UIColor.lightGray
        myTextView.delegate = self
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
            if title != "" {
                onDoneButton?(title, myTextView.text)
            }
        }
        dismiss(animated: true)
    }

    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
