//
//  ViewController.swift
//  Number Guesser
//
//  Created by Daniel Stagnaro on 6/21/16.
//  Copyright © 2016 Daniel Stagnaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var rangeHintLabel: UILabel!
    @IBOutlet weak var numberPicker: UIPickerView!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var random_number = Int(arc4random_uniform(100) + 1)
    var bottom_end: Int? = 0
    var top_end: Int? = 100
    
    var user_guess: Int?
    var roundsPlayed = 1
    
    var numberPickerData: [String] = [String]()
    
    let DIM_ALPHA: CGFloat = 0.5
    let OPAQUE: CGFloat = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberPicker.dataSource = self
        numberPicker.delegate = self
        
        for i in 1 ..< 101 {
            numberPickerData.append("\(i)")
        }
        resetButton.hidden = true
        reset()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberPickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numberPickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {}
    
    @IBAction func guessButtonPressed(sender: AnyObject) {
        user_guess = numberPicker.selectedRowInComponent(0) + 1
        compare()
    }
    
    @IBAction func resetGame(sender: AnyObject) {
        reset()
    }
    
    func reset(){
        middleLabel.text = ""
        rangeHintLabel.text = ""
        
        user_guess = nil
        random_number = Int(arc4random_uniform(100) + 1)
        
        roundsPlayed = 1
        bottom_end = 0
        top_end = 100
        
        numberPicker.userInteractionEnabled = true
        numberPicker.alpha = OPAQUE
        guessButton.userInteractionEnabled = true
        guessButton.alpha = OPAQUE
        
        resetButton.hidden = true
    }
    
    func compare(){
        if user_guess < random_number {
            
            middleLabel.text = "Oh darn, you guessed too low!"// \(random_number)"
            
            if user_guess > bottom_end {
                bottom_end = user_guess
            }
            
            roundsPlayed += 1

            updateRangeHintLabel()
            
        } else if user_guess > random_number {
            
            middleLabel.text = "Oh fooie, you guessed too high!"
            
            if user_guess < top_end {
                top_end = user_guess
            }
            
            roundsPlayed += 1

            updateRangeHintLabel()
            
        } else if user_guess == random_number {
            
            middleLabel.text = "You got it right!"
            rangeHintLabel.text = "It only took you \(roundsPlayed) times to guess correctly"
            
            numberPicker.userInteractionEnabled = false
            guessButton.userInteractionEnabled = false
            numberPicker.alpha = DIM_ALPHA
            guessButton.alpha = DIM_ALPHA
            
            resetButton.hidden = false
            
        }
    }
    
    func updateRangeHintLabel() {
        rangeHintLabel.text = "Range Hint: \(bottom_end!) - \(top_end!)"
    }
}

