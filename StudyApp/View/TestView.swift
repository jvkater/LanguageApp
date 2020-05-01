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
        layer.cornerRadius = 10
        layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
}
