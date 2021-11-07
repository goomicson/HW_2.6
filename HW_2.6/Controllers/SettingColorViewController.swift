//
//  SettingColorViewController.swift
//  HW_2.6
//
//  Created by Сергей on 06.11.2021.
//

import UIKit

class SettingColorViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Outlets
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var actualColorView: UIView!
    
    @IBOutlet var doneButton: UIButton!
    
    //MARK: Properties
    var redColor = Float (0.0)
    var greenColor = Float (0.0)
    var blueColor = Float (0.0)
    
    var shareingColor = UIColor (red: 0, green: 0, blue: 0, alpha: 0)
    
    var delegationOfColor: SettingColorViewControllerDelegate!
    
    
    
    //MARK: Loading View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.text = String(format: "%.2f",(redColor))
        greenTextField.text = String(format: "%.2f",(greenColor))
        blueTextField.text = String(format: "%.2f",(blueColor))
        
        redSlider.value = Float(redColor)
        greenSlider.value = Float(greenColor)
        blueSlider.value = Float(blueColor)
        
        redLabel.text = String(format: "%.2f",(redColor))
        greenLabel.text = String(format: "%.2f",(greenColor))
        blueLabel.text = String(format: "%.2f",(blueColor))
        
        actualColorView.backgroundColor = shareingColor
        //dismiss keyboard by taping
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        //Toolbar
        let toolBar = UIToolbar(frame: CGRect (x: 0, y: 0, width: view.frame.size.width, height: 50))
        let spacing = UIBarButtonItem (barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self,action: #selector(buttonPressed))
        toolBar.items = [spacing, doneButton]
        toolBar.sizeToFit()
        redTextField.inputAccessoryView = toolBar
        greenTextField.inputAccessoryView = toolBar
        blueTextField.inputAccessoryView = toolBar
    }
    @objc private func buttonPressed () {
        redTextField.resignFirstResponder()
        greenTextField.resignFirstResponder()
        blueTextField.resignFirstResponder()
    }
    
    //MARK: IBActions
    @IBAction func changingColor() {
        redColor = redSlider.value
        greenColor = greenSlider.value
        blueColor = blueSlider.value
        
        redTextField.text = String(format: "%.2f",(redSlider.value))
        greenTextField.text = String(format: "%.2f",(greenSlider.value))
        blueTextField.text = String(format: "%.2f",(blueSlider.value))
        
        redLabel.text = String(format: "%.2f",(redColor))
        greenLabel.text = String(format: "%.2f",(greenColor))
        blueLabel.text = String(format: "%.2f",(blueColor))
        
        actualColorView.backgroundColor = UIColor(red: CGFloat(redColor), green: CGFloat(greenColor), blue: CGFloat(blueColor), alpha: 1)
    }
    
    
    @IBAction func changingColorByTyping() {
        redSlider.value = Float(redTextField.text!) ?? redSlider.value
        greenSlider.value = Float(greenTextField.text!) ?? greenSlider.value
        blueSlider.value = Float(blueTextField.text!) ?? blueSlider.value
        
        redLabel.text = String(redColor)
        
        redColor = redSlider.value
        greenColor = greenSlider.value
        blueColor = blueSlider.value
        
        checkingTextField ()
        redLabel.text = String(format: "%.2f",(redColor))
        
        
        
        actualColorView.backgroundColor = UIColor(red: CGFloat(redColor), green: CGFloat(greenColor), blue: CGFloat(blueColor), alpha: 1)
    }
    
    @IBAction func doneAction() {
        delegationOfColor.setNewColors(redColorForView: redColor, greenColorForView: greenColor, blueColorForView: blueColor)
        delegationOfColor.movingVariables(red: redColor, green: greenColor, blue: blueColor)
        dismiss(animated: true)
    }
    
    //MARK: Return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        redTextField.resignFirstResponder()
        greenTextField.resignFirstResponder()
        blueTextField.resignFirstResponder()
        return true
    }
}

//MARK: Extensions
extension SettingColorViewController {
    private func showAlert (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}

extension SettingColorViewController {
    func checkingTextField (){
        if let check = Float(redTextField.text!){
            if check >= 0 && check <= 1 {
                print ("Good")
            } else {
                redTextField.text = ""
                showAlert(title: "Error", message: "Enter another value")
            }
        } else {
            showAlert(title: "Error", message: "Enter another value")
            redTextField.text = ""
        }
        
        if let check = Float(greenTextField.text!){
            if check >= 0 && check <= 1 {
                print ("Good")
            } else {
                showAlert(title: "Error", message: "Enter another value")
                greenTextField.text = ""
            }
        } else {
            showAlert(title: "Error", message: "Enter another value")
            greenTextField.text = ""
        }
        
        if let check = Float(blueTextField.text!){
            if check >= 0 && check <= 1 {
                print ("Good")
            } else {
                showAlert(title: "Error", message: "Enter another value")
                blueTextField.text = ""
            }
        } else {
            showAlert(title: "Error", message: "Enter another value")
            blueTextField.text = ""
        }
    }
}
