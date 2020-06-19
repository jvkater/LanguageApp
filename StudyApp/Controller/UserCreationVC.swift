//
//  UserCreationVC.swift
//  StudyApp
//
//  Created by Евгений Катаев on 12.06.2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit
import CoreData

class UserCreationVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameInput: nameInputField!
    
    @IBAction func userInputFinished(_ sender: Any) {
        let processed_username = (usernameInput.text?.trimmingCharacters(in: .whitespaces))!
        save(username: processed_username)
        let resultController = storyboard!.instantiateViewController(withIdentifier: "rootController")
        resultController.modalPresentationStyle = .fullScreen
        resultController.modalTransitionStyle = .crossDissolve
        present(resultController, animated: true, completion: nil)
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 90, width:self.view.frame.size.width, height:self.view.frame.size.height);

        })
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 90, width:self.view.frame.size.width, height:self.view.frame.size.height);

        })
    }
    
    func save(username: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
        }
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "UserInfo", in: managedContext)!
    let WordCard = NSManagedObject(entity: entity, insertInto: managedContext)
        WordCard.setValue(username, forKeyPath: "username")
        do {
            try managedContext.save()
        } catch _ as NSError {
            print("Could not save")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.usernameInput.delegate = self
        // Do any additional setup after loading the view.
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
