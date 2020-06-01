//
//  ManualAdd.swift
//  StudyApp
//
//  Created by Евгений Катаев on 15/05/2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit
import CoreData

class ManualAddVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var WordInput: UITextField!
    @IBOutlet weak var TranslationInput: UITextField!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var DismissButton: UIButton!
    
    @IBOutlet weak var testLabel: UILabel!
    @IBAction func WordAdded(_ sender: Any) {
    }
    @IBAction func AddWordToLib(_ sender: Any) {
        save(originalWord: String(WordInput.text ?? "null"), translatedWord: String(TranslationInput.text ?? "null"))
        WordInput.text = " "
        TranslationInput.text = " "
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {        self.view.endEditing(true)
       return false
     }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField.text != "" {
        return false
        } else {
            return true
        }
    }
    
    var backdropView: UIView = {
    let bdView = UIView()
          bdView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
          return bdView
      }()
    
    func save(originalWord: String, translatedWord : String) {
               guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
             return
               }
           let managedContext = appDelegate.persistentContainer.viewContext
           let entity = NSEntityDescription.entity(forEntityName: "WordsLibrary", in: managedContext)!
           let WordCard = NSManagedObject(entity: entity, insertInto: managedContext)
               WordCard.setValue(originalWord, forKeyPath: "addedWord")
               WordCard.setValue(translatedWord, forKeyPath: "addedWordTranslation")
               do {
                   try managedContext.save()
               } catch let _ as NSError {
                   print("Could not save")
               }
           }
         

           
           func fetch(param:Int8) -> String {
               var outp = NSManagedObject()
               let appDelegate = UIApplication.shared.delegate as? AppDelegate
               let managedContext = appDelegate?.persistentContainer.viewContext
               let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WordsLibrary")
               do {
                   let wordsBase = try managedContext?.fetch(fetchRequest)
                   outp = (wordsBase?[0])!
               } catch let error as NSError {
                 print("Could not fetch. \(error), \(error.userInfo)")
               }
               if param == 1 {
               return outp.value(forKey: "addedWord") as! String
               } else {
                   return outp.value(forKey: "addedWordTranslation") as! String
               }
           }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 90, width:self.view.frame.size.width, height:self.view.frame.size.height);

        })
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 90, width:self.view.frame.size.width, height:self.view.frame.size.height);

        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backdropView)
        
        AddButton.layer.cornerRadius = 10
        AddButton.layer.maskedCorners = [.layerMaxXMaxYCorner]
        AddButton.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        AddButton.layer.borderColor = #colorLiteral(red: 0.5482043624, green: 0.6821199059, blue: 0.3612639904, alpha: 1)
        AddButton.layer.borderWidth = 1
        
        DismissButton.layer.cornerRadius = 10
        DismissButton.layer.maskedCorners = [.layerMinXMaxYCorner]
        DismissButton.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        DismissButton.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        DismissButton.layer.borderWidth = 1
        view.backgroundColor = .clear
       
       
        
        self.WordInput.delegate = self
        self.TranslationInput.delegate = self
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ManualAddVC.handleTap(_:)))
        backdropView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
