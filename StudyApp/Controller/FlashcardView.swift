//
//  FlashcardView.swift
//  StudyApp
//
//  Created by Евгений Катаев on 11/04/2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit
import CoreData


class FlashcardView: UIViewController {
    
    var Words = ["Gesundheit","Health"]
    // var image = "test".image()

    @IBOutlet weak var headlineLabel: UIButton!
    
    @IBOutlet weak var BackButton: UIButton!
    
    @IBOutlet weak var yesButton: yesButton!
    @IBOutlet weak var noButton: noButton!
    
    
    @IBAction func CardSwipe(_ sender: UIPanGestureRecognizer) {
        let cardView = sender.view!
        let translationPoint = sender.translation(in: view)
        cardView.center = CGPoint(x: view.center.x+translationPoint.x, y: view.center.y+translationPoint.y)
    }
    @IBOutlet weak var containerView: UIView!
    
    var initialState: UIView = {
        let bdView = UIView(frame: CGRect(x: 0,y: 0,width: UIScreen.main.bounds.size.width*0.7,height: UIScreen.main.bounds.size.height/2))
          bdView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        bdView.layer.cornerRadius = 10
        bdView.layer.borderWidth = 2
        bdView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
          return bdView
      }()
    
    var flippedState: UIView = {
        let fsView = UIView(frame: CGRect(x: 0,y: 0,width: UIScreen.main.bounds.size.width*0.7,height: UIScreen.main.bounds.size.height/2))
          fsView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        fsView.layer.borderWidth = 2
        fsView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        fsView.layer.cornerRadius = 10
          return fsView
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        var WordLabel = UILabel(frame: CGRect(x: 30, y:110, width: 180, height: 21))
         WordLabel.textAlignment = NSTextAlignment.center
         WordLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        var Word2Label = UILabel(frame: CGRect(x: 30, y:110, width: 180, height: 21))
        Word2Label.textAlignment = NSTextAlignment.center
        Word2Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FlashcardView.handleTap(_:)))
        headlineLabel.center.x = UIScreen.main.bounds.width/2
        headlineLabel.center.y = UIScreen.main.bounds.size.height*0.07
        BackButton.center.y = UIScreen.main.bounds.size.height*0.07
        containerView.frame.size.width = UIScreen.main.bounds.width*0.7
        containerView.frame.size.height = UIScreen.main.bounds.height/2
        containerView.center = super.view.center
        yesButton.center.y = UIScreen.main.bounds.height*0.9
        noButton.center.y = UIScreen.main.bounds.height*0.9
        containerView.addGestureRecognizer(tapGesture)
        containerView.addSubview(initialState)
        initialState.addSubview(Word2Label)
        Word2Label.center = initialState.center
        Word2Label.text = "Frontside"
        
        containerView.addSubview(flippedState)
        flippedState.addSubview(WordLabel)
        WordLabel.center = flippedState.center
        WordLabel.text = "Backside"
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

