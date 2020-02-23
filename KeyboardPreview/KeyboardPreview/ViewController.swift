//
//  ViewController.swift
//  KeyboardPreview
//
//  Created by Filip Němeček on 23/02/2020.
//  Copyright © 2020 Filip Němeček. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var keyboardTypePicker: UIPickerView!
    @IBOutlet var returnKeyPicker: UIPickerView!
    
    private var textContentType: TextContentType?
    
    private let keyboardTypes: [(type: UIKeyboardType, name: String)] = [
        (.default, "Default"),
        (.asciiCapable, "ASCII Capable"),
        (.numbersAndPunctuation, "Numbers and Punctuation"),
        (.URL, "URL"),
        (.numberPad, "Number Pad"),
        (.phonePad, "Phone Pad"),
        (.namePhonePad, "Name Phone Pad"),
        (.emailAddress, "E-mail Address"),
        (.decimalPad, "Decimal Pad"),
        (.twitter, "Twitter"),
        (.webSearch, "Web Search"),
        (.asciiCapableNumberPad, "ASCII Capable Number Pad")
    ]
    
    private let returnKeys: [(keyType: UIReturnKeyType, name: String)] = [
        (UIReturnKeyType.default, "Default"),
        (.go, "Go"),
        (.google, "Google"),
        (.join, "Join"),
        (.next, "Next"),
        (.route, "Route"),
        (.search, "Search"),
        (.send, "Send"),
        (.yahoo, "Yahoo"),
        (.done, "Done"),
        (.emergencyCall, "Emergency Call"),
        (.continue, "Continue")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardTypePicker.dataSource = self
        keyboardTypePicker.delegate = self
        returnKeyPicker.dataSource = self
        returnKeyPicker.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tap)
        
        textField.textContentType = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContentTypeSegue" {
            guard let nvc = segue.destination as? UINavigationController else {
                preconditionFailure()
            }
            
            guard let contentTypeViewController = nvc.topViewController as? ContentTypeSelectionViewController else {
                preconditionFailure()
            }
            
            contentTypeViewController.didSelectContentType = textContentTypeSelected
            contentTypeViewController.previousContentType = textContentType
        }
    }
    
    @objc func viewTapped() {
        view.endEditing(true)
    }

    @IBAction func lookSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            textField.keyboardAppearance = .default
        case 1:
            textField.keyboardAppearance = .light
        case 2:
            textField.keyboardAppearance = .dark
        default:
            preconditionFailure("Cannot happen")
        }
        
        textField.reloadInputViews()
    }
    
    func textContentTypeSelected(_ contentType: TextContentType?) {
        textContentType = contentType
        textField.textContentType = contentType?.type
        textField.reloadInputViews()
    }
    

}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView === keyboardTypePicker {
            return keyboardTypes.count
        } else {
            return returnKeys.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView === keyboardTypePicker {
            return keyboardTypes[row].name
        } else {
            return returnKeys[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView === keyboardTypePicker {
            textField.keyboardType = keyboardTypes[row].type
        } else {
            textField.returnKeyType = returnKeys[row].keyType
        }
        
        textField.reloadInputViews()
    }
    
}

