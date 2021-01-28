//
//  SettingsViewController.swift
//  TimerApp
//
//  Created by Sam King on 1/21/21.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    var someData: String?
    @IBOutlet weak var dogNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dogNameTextField.delegate = self
        dogNameTextField.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let range = Range(range, in: currentText) else {
            assertionFailure("range not defined")
            return true
        }
        
        let newText = currentText.replacingCharacters(in: range, with: string)
        
        print("current text -> \(currentText)")
        print("new text     -> \(newText)")
        print("")
        
        textField.text = newText.uppercased()
        if newText.uppercased().starts(with: "HONEY") {
            textField.resignFirstResponder()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        return false
    }
}
