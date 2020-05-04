//
//  ViewController.swift
//  StudyApp
//
//  Created by Евгений Катаев on 05/04/2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userGreeting: UILabel!
    @IBOutlet weak var userprogress: UILabel!
    @IBOutlet weak var GreenView: UIView!
    @IBOutlet weak var bgpic: UIImageView!
    @IBOutlet weak var AppName: UILabel!
    
    let currentuser = AppUser(name: "Alena")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GreenView.frame.size.height = UIScreen.main.bounds.size.height/3
        GreenView.frame.size.width = UIScreen.main.bounds.size.width
        bgpic.frame.size.width = GreenView.frame.size.width
        bgpic.frame.size.height = GreenView.frame.size.height
        userGreeting.center.x = GreenView.center.x
        
        AppName.center.x = GreenView.center.x
        AppName.center.y = username.center.y - 70
        
        username.center.x = GreenView.center.x
        username.center.y = GreenView.center.y + 20
        userGreeting.center.y = username.center.y - username.font.pointSize
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
