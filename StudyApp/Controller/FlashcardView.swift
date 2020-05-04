//
//  FlashcardView.swift
//  StudyApp
//
//  Created by Евгений Катаев on 11/04/2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class FlashcardView: UIViewController {
    
    var Words = ["Gesundheit","Health"]
    // var image = "test".image()

    @IBAction func CardSwipe(_ sender: UIPanGestureRecognizer) {
        let cardView = sender.view!
        let translationPoint = sender.translation(in: view)
        cardView.center = CGPoint(x: view.center.x+translationPoint.x, y: view.center.y+translationPoint.y)
    }
    @IBOutlet weak var containerView: UIView!
    
    var initialState: UIView = {
        let bdView = UIView(frame: CGRect(x: 0,y: 0,width: UIScreen.main.bounds.size.width*0.65,height: 250))
          bdView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        bdView.layer.cornerRadius = 10
        var label = UILabel(frame: CGRect(x: 30, y:110, width: 180, height: 21))
        label.textAlignment = NSTextAlignment.center
        label.center = bdView.center
        label.text = "Gesundheit"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        bdView.addSubview(label)
          return bdView
      }()
    
    var flippedState: UIView = {
    let fsView = UIView(frame: CGRect(x: 0,y: 0,width: UIScreen.main.bounds.size.width*0.65,height: 250))
          fsView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        var label = UILabel(frame: CGRect(x: 30, y:110, width: 180, height: 21))
            label.center = fsView.center
             label.textAlignment = NSTextAlignment.center
             label.text = "Health"
             label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
             fsView.addSubview(label)
        fsView.layer.cornerRadius = 10
          return fsView
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FlashcardView.handleTap(_:)))
        containerView.addGestureRecognizer(tapGesture)
        containerView.addSubview(initialState)
        containerView.addSubview(flippedState)
        flippedState.isHidden=true
        
    }
 
    var IsInitialCardState = true
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if IsInitialCardState{
        flippedState.isHidden=false
            UIView.transition(from: initialState, to: flippedState, duration: 0.4, options: .transitionFlipFromRight, completion: nil)
            IsInitialCardState = false
        } else {
            UIView.transition(from: flippedState, to: initialState, duration: 0.4, options: .transitionFlipFromRight, completion: nil)
            IsInitialCardState = true
        }
        // Do any additional setup after loading the view.

}
}

