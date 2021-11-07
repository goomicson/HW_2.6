//
//  ViewController.swift
//  HW_2.6
//
//  Created by Сергей on 06.11.2021.
//

import UIKit

//MARK: Protocols
protocol SettingColorViewControllerDelegate {
    func setNewColors (redColorForView: Float, greenColorForView: Float, blueColorForView: Float)
    func movingVariables (red: Float, green: Float, blue: Float)
}

class ChoosenColorViewController: UIViewController {
    
    //MARK: IBActions
    @IBOutlet var backgroundView: UIView!
    
    //MARK: Properties
    var redColorForView = Float (1)
    var greenColorForView = Float (1)
    var blueColorForView = Float (1)
    
    //MARK: Loading View
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.backgroundColor = UIColor(red: CGFloat (redColorForView), green: CGFloat(greenColorForView), blue: CGFloat(blueColorForView), alpha: 1)
                                
                                }
                                
    //MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SettingColorViewController else {return}
        settingVC.shareingColor = backgroundView.backgroundColor ?? UIColor(red:1, green: 0, blue: 0, alpha: 1)
        settingVC.delegationOfColor = self
        settingVC.redColor = redColorForView
        settingVC.greenColor = greenColorForView
        settingVC.blueColor = blueColorForView
    }
}

    //MARK: Extensions
extension ChoosenColorViewController: SettingColorViewControllerDelegate {
    func setNewColors(redColorForView: Float, greenColorForView: Float, blueColorForView: Float) {
        backgroundView.backgroundColor = UIColor(red: CGFloat (redColorForView), green: CGFloat(greenColorForView), blue: CGFloat(blueColorForView), alpha: 1)
    }
    func movingVariables(red: Float, green: Float, blue: Float) {
        redColorForView = red
        greenColorForView = green
        blueColorForView = blue
    }
}
