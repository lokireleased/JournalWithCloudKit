//
//  EntryDetailViewController.swift
//  JournalCloudKit
//
//  Created by tyson ericksen on 12/9/19.
//  Copyright © 2019 tyson ericksen. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entries: Journal? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.delegate = self
        
        
    }
    
    func updateViews() {
        guard let entry = entries else { return }
            
        titleTextField.text = entry.title
        bodyTextView.text = entry.bodyText
        
        
    }

    @IBAction func mainViewTapped(_ sender: UITapGestureRecognizer) {
        bodyTextView.resignFirstResponder()
        titleTextField.resignFirstResponder()
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, !title.isEmpty, let bodyText = bodyTextView.text, !bodyText.isEmpty else { return }
        JournalController.shared.addEntryWith(title: title, bodyText: bodyText) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}

extension EntryDetailViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
