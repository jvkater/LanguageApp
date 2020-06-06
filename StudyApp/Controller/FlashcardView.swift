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
        updateWordStats(word: ((WordsDataBase[NRound].value(forKey: "addedWord") as? String)!), updateType: "success")
        
        if WordsDataBase.count > NRound+1 {
            NRound+=1 } else {
            NRound = 0
        }
        redrawcards(frontside: initialState, backside: flippedState, frontword: (WordsDataBase[NRound].value(forKey: "addedWord") as? String)!, backword: (WordsDataBase[NRound].value(forKey: "addedWordTranslation") as? String)!)
    }
    
    @IBAction func IncorrectPressed(_ sender: Any) {
        updateWordStats(word: ((WordsDataBase[NRound].value(forKey: "addedWord") as? String)!), updateType: "failure")
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
    // Main container with cards
    @IBOutlet weak var containerView: UIView!
    
    // Database processing
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
    
    func updateWordStats(word:String, updateType:String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WordsLibrary")
        fetchRequest.predicate = NSPredicate(format: "addedWord = %@", word)
        do {
            let item = try managedContext.fetch(fetchRequest)
            
            let successfullRecalls = item[0].value(forKey: "successfullRecalls") as! Int
            let unsuccessfullRecalls = item[0].value(forKey: "unsuccessfullRecalls") as! Int
            let totalRecalls = item[0].value(forKey: "totalRecalls") as! Int
            
            item[0].setValue(totalRecalls + 1, forKey: "totalRecalls")
            
            // updating number of recalls
            if updateType == "success" {
                item[0].setValue(successfullRecalls + 1, forKey: "successfullRecalls")
            } else {
                item[0].setValue(unsuccessfullRecalls + 1, forKey: "unsuccessfullRecalls")
            }
            
            // updating clusterization
            print(successfullRecalls)
            print(totalRecalls)
            let successRate = (Double(successfullRecalls) + 1.0) / (Double(totalRecalls) + 1.0)
            print(successRate)
            if  successRate <= 0.5 {
                item[0].setValue("Bad", forKey: "recallCluster")
            } else if successRate <= 0.8 {
                item[0].setValue("Decent", forKey: "recallCluster")
            } else {
                item[0].setValue("Good", forKey: "recallCluster")
            }
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("Something went wronf")
        }
        
        
    }
    
    
    var initialState: UIView = {
        let bdView = UIView(frame: CGRect(x: 0,y: 0,width: 0.78125 * UIScreen.main.bounds.size.width, height: 0.573944 * UIScreen.main.bounds.size.height))         //It's a very dirty trick and is basically a cheat. The value was taken from storyboard constraint
          bdView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        bdView.layer.cornerRadius = 10
        bdView.layer.borderWidth = 2
        bdView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
          return bdView
      }()
    
    var flippedState: UIView = {
        let fsView = UIView(frame: CGRect(x: 0,y: 0,width: 0.78125 * UIScreen.main.bounds.size.width, height: 0.573944 * UIScreen.main.bounds.size.height))
          fsView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        fsView.layer.borderWidth = 2
        fsView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        fsView.layer.cornerRadius = 10
          return fsView
      }()
    
    let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
    // Needed to filter out lines of text later on
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAll()

        print(WordsDataBase.count)
        WordsDataBase.shuffle()
        
        if WordsDataBase.count > 20 {
            WordsDataBase = Array(WordsDataBase.prefix(20))
        }
        
       let initialStateWord = UILabel(frame: CGRect(x: 30, y:110, width: 180, height: 21))
        initialStateWord.textAlignment = NSTextAlignment.center
        initialStateWord.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        let flippedStateWord = UILabel(frame: CGRect(x: 30, y:110, width: 180, height: 21))
        flippedStateWord.textAlignment = NSTextAlignment.center
        flippedStateWord.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)


        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FlashcardView.handleTap(_:)))

        containerView.addGestureRecognizer(tapGesture)
        containerView.addSubview(initialState)
        initialState.addSubview(initialStateWord)
        initialStateWord.center = initialState.center
        initialStateWord.text = WordsDataBase[NRound].value(forKey: "addedWord") as? String
        
        if (initialStateWord.text?.components(separatedBy: chararacterSet).filter{ !$0.isEmpty }.count)! > 1 {
            if initialStateWord.isTruncated {
                initialStateWord.frame.size.height = 41
            } else {
                initialStateWord.frame.size.height = 21
            }
            initialStateWord.lineBreakMode = .byWordWrapping
            initialStateWord.numberOfLines = 0
        } else {
            initialStateWord.numberOfLines = 0;
            initialStateWord.frame.size.height = 21
            initialStateWord.minimumScaleFactor = 0.3;
            initialStateWord.adjustsFontSizeToFitWidth = true;
        }
        // Add error handling for empty library!
        
        containerView.addSubview(flippedState)
        flippedState.addSubview(flippedStateWord)
        flippedStateWord.center = flippedState.center
        flippedStateWord.text = WordsDataBase[NRound].value(forKey: "addedWordTranslation") as? String
        if (flippedStateWord.text?.components(separatedBy: chararacterSet).filter{ !$0.isEmpty }.count)! > 1 {
                   if flippedStateWord.isTruncated {
                       flippedStateWord.frame.size.height = 41
                   } else {
                       flippedStateWord.frame.size.height = 21
                   }
                   flippedStateWord.lineBreakMode = .byWordWrapping
                   flippedStateWord.numberOfLines = 0
               } else {
                   flippedStateWord.numberOfLines = 0;
                   flippedStateWord.frame.size.height = 21
                   flippedStateWord.minimumScaleFactor = 0.3;
                   flippedStateWord.adjustsFontSizeToFitWidth = true;
               }
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
        if (WordLabel.text?.components(separatedBy: chararacterSet).filter{ !$0.isEmpty }.count)! > 1 {
            if WordLabel.isTruncated {
                WordLabel.frame.size.height = 41
            } else {
                WordLabel.frame.size.height = 21
            }
            WordLabel.lineBreakMode = .byWordWrapping
            WordLabel.numberOfLines = 0
        } else {
            WordLabel.numberOfLines = 0;
            WordLabel.frame.size.height = 21
            WordLabel.minimumScaleFactor = 0.3;
            WordLabel.adjustsFontSizeToFitWidth = true;
        }
        
        let WordLabelBackSide = UILabel(frame: CGRect(x: 30, y:110, width: 180, height: 21))
        WordLabelBackSide.textAlignment = NSTextAlignment.center
        WordLabelBackSide.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        for view in backside.subviews {
            view.removeFromSuperview()
        }
        backside.addSubview(WordLabelBackSide)
        WordLabelBackSide.center = backside.center
        WordLabelBackSide.text = backword
        if (WordLabelBackSide.text?.components(separatedBy: chararacterSet).filter{ !$0.isEmpty }.count)! > 1 {
            if WordLabelBackSide.isTruncated {
                WordLabelBackSide.frame.size.height = 41
            } else {
                WordLabelBackSide.frame.size.height = 21
            }
            WordLabelBackSide.lineBreakMode = .byWordWrapping
            WordLabelBackSide.numberOfLines = 0
        } else {
            WordLabelBackSide.numberOfLines = 0;
            WordLabelBackSide.frame.size.height = 21
            WordLabelBackSide.minimumScaleFactor = 0.3;
            WordLabelBackSide.adjustsFontSizeToFitWidth = true;
        }
        
        if backside.isHidden == false {
            UIView.transition(from: backside, to: frontside, duration: 0.4, options: .transitionFlipFromRight, completion: nil)
        }
    }
}

extension UILabel {
    var isTruncated: Bool {
        guard let labelText = text as? NSString else {
            return false
        }
        let size = labelText.size(withAttributes: [NSAttributedString.Key.font: font])
        return size.width > self.bounds.width
    }
}
