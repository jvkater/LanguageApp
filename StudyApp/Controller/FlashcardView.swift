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
    
    var NRound = 0

    @IBOutlet weak var headlineLabel: UIButton!
    
    @IBOutlet weak var BackButton: UIButton!
    
    @IBOutlet weak var yesButton: yesButton!
    @IBOutlet weak var noButton: noButton!
    
    @IBAction func CorrectPressed(_ sender: Any) {

        if WordsDataBase.count > NRound+1 {
            NRound+=1 } else {
            NRound = 0
        }
        redrawcards(frontside: initialState, backside: flippedState, frontword: (WordsDataBase[NRound].value(forKey: "addedWord") as? String)!, backword: (WordsDataBase[NRound].value(forKey: "addedWordTranslation") as? String)!)
    }
    
    @IBAction func IncorrectPressed(_ sender: Any) {
        if WordsDataBase.count > NRound+1 {
            NRound+=1 } else {
            NRound = 0
        }
        redrawcards(frontside: initialState, backside: flippedState, frontword: (WordsDataBase[NRound].value(forKey: "addedWord") as? String)!, backword: (WordsDataBase[NRound].value(forKey: "addedWordTranslation") as? String)!)

    }
    @IBAction func CardSwipe(_ sender: UIPanGestureRecognizer) {
        let cardView = sender.view!
        let translationPoint = sender.translation(in: view)
        cardView.center = CGPoint(x: view.center.x+translationPoint.x, y: view.center.y+translationPoint.y)
    }
    @IBOutlet weak var containerView: UIView!
    
    var WordsDataBase = [NSManagedObject]()
    
    func fetchAll(){
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      let managedContext = appDelegate.persistentContainer.viewContext
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WordsLibrary")
      do {
        let words = try managedContext.fetch(fetchRequest)
        for i in words {
            WordsDataBase.append(i)
        }
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
    
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
        fetchAll()

        print(WordsDataBase.count)
        let WordLabel = UILabel(frame: CGRect(x: 30, y:110, width: 180, height: 21))
         WordLabel.textAlignment = NSTextAlignment.center
         WordLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let Word2Label = UILabel(frame: CGRect(x: 30, y:110, width: 180, height: 21))
        Word2Label.textAlignment = NSTextAlignment.center
        Word2Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FlashcardView.handleTap(_:)))

        containerView.addGestureRecognizer(tapGesture)
        containerView.addSubview(initialState)
        initialState.addSubview(Word2Label)
        Word2Label.center = initialState.center
        Word2Label.text = WordsDataBase[NRound].value(forKey: "addedWord") as? String
        
        containerView.addSubview(flippedState)
        flippedState.addSubview(WordLabel)
        WordLabel.center = flippedState.center
        WordLabel.text = WordsDataBase[NRound].value(forKey: "addedWordTranslation") as? String
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
    func redrawcards(frontside:UIView, backside:UIView, frontword:String, backword:String)  {
        let WordLabel = UILabel(frame: CGRect(x: 30, y:110, width: 180, height: 21))
         WordLabel.textAlignment = NSTextAlignment.center
         WordLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        for view in frontside.subviews {
            view.removeFromSuperview()
        }
        frontside.addSubview(WordLabel)
        WordLabel.center = frontside.center
        WordLabel.text = frontword
        
        let WordLabelBackSide = UILabel(frame: CGRect(x: 30, y:110, width: 180, height: 21))
        WordLabelBackSide.textAlignment = NSTextAlignment.center
        WordLabelBackSide.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        for view in backside.subviews {
            view.removeFromSuperview()
        }
        backside.addSubview(WordLabelBackSide)
        WordLabelBackSide.center = backside.center
        WordLabelBackSide.text = backword
        
        if backside.isHidden == false {
            UIView.transition(from: backside, to: frontside, duration: 0.4, options: .transitionFlipFromRight, completion: nil)
        }
    }
}

