//
//  StartButton.swift
//  StudyApp
//
//  Created by Евгений Катаев on 10/04/2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class MainMenuButton: UIButton {
    override func awakeFromNib() {
        layer.backgroundColor = #colorLiteral(red: 0.8835639954, green: 0.8808217049, blue: 0.8857159019, alpha: 1)
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.borderWidth = 0.2
        layer.cornerRadius = 10
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}

class RepeatButton: UIButton {
    override func awakeFromNib() {
        layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        layer.borderWidth = 1
        layer.cornerRadius = 10
    }
}

class yesButton: UIButton{
    override func awakeFromNib() {
        layer.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        layer.cornerRadius = 10
    }
}

class noButton:UIButton {
    override func awakeFromNib() {
        layer.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        layer.cornerRadius = 10
    }
}

class defaultWordButton:UIButton {
    override func awakeFromNib() {
        layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.cornerRadius = 10
    }
}

class addToLibraryButton: UIButton {
    override func awakeFromNib() {
        layer.cornerRadius = 2
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.backgroundColor = #colorLiteral(red: 0.6184834242, green: 0.6165664792, blue: 0.6199893951, alpha: 1)
    }
}
