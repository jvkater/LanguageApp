//
//  ViewController.swift
//  StudyApp
//
//  Created by Евгений Катаев on 05/04/2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit
import CoreData

class rootVC: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    
    func fetchUserData(){
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      let managedContext = appDelegate.persistentContainer.viewContext
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserInfo")
      do {
        let userinfo = try managedContext.fetch(fetchRequest)
        if userinfo.count == 0 {
            print("no users")
            let view = (storyboard?.instantiateViewController(withIdentifier: "registrationVC"))! as UIViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //show window
            appDelegate.window?.rootViewController = view
            //let registrationVC = UserCreationVC()
            //registrationVC.modalPresentationStyle = .fullScreen
            //registrationVC.modalTransitionStyle = .crossDissolve
            //present(registrationVC, animated: true, completion: nil)
        } else {
            print(userinfo[0].value(forKey: "username") as? String)
            usernameLabel.text = userinfo[0].value(forKey: "username") as? String
        }
      } catch  {
        print("sthbsjbs")
      }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData()
    }
    
    
    @IBAction func unwindFromSelection(unwindsegue:UIStoryboardSegue) {
    }
    
    
    @IBAction func returnToRoot(unwindsegue:UIStoryboardSegue) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func gotoAddWord(_ sender: UIButton) {
        let targetVC = AddWordController()
        targetVC.modalPresentationStyle = .custom
        present(targetVC, animated: true, completion: nil)
    }
    
}
