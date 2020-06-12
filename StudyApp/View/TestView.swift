//
//  TestView.swift
//  StudyApp
//
//  Created by Евгений Катаев on 06/04/2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class TestView: UIView {
    override func awakeFromNib() {
        layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.borderWidth = 1
        layer.cornerRadius = 10
    }
}

class languageLabel: UILabel {
    override func awakeFromNib() {
        layer.cornerRadius = 2
        layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        layer.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
}

class AudioPopView: UIView{
    override func awakeFromNib() {
        layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.borderWidth = 1
        layer.cornerRadius = 10
        self.alpha = 0.95
    }
}

class VideoPopView: UIView{
    override func awakeFromNib() {
        layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.borderWidth = 1
        layer.cornerRadius = 10
        self.alpha = 0.95
    }
}

class topView:UIView {
    override func awakeFromNib() {
        layer.cornerRadius = 10
    }
}
class popDown:UIView {
    override func awakeFromNib() {
        layer.cornerRadius = 20
    }
}

class cardView: UIView {
    override func awakeFromNib() {
        layer.cornerRadius = 10
        layer.borderColor = #colorLiteral(red: 0.4888150692, green: 0.6754166484, blue: 0.3641774058, alpha: 1)
        layer.borderWidth = 2
    }
}

class AddWordMainView: UIView {
    override func awakeFromNib() {
        layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = 10
    }
}

class nameInputField: UITextField {
    override func awakeFromNib() {
        layer.cornerRadius = 10
    }
}
