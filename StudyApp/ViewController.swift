//
//  ViewController.swift
//  StudyApp
//
//  Created by Евгений Катаев on 05/04/2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var userprogress: UILabel!
    
    let currentuser = AppUser(name: "Alena")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        username.text = currentuser.name
        userprogress.text = String(Int.random(in: 0...50))+"/50" // Generate random number for progress
        // Do any additional setup after loading the view.
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
