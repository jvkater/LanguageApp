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
    @IBOutlet weak var AppLogo: UIImageView!
    
    @IBOutlet weak var LearnedTodayLabel: UILabel!
    
    @IBOutlet weak var QuestionLabel: UILabel!
    
    @IBOutlet weak var MemorizeButton: MainMenuButton!
    
    @IBOutlet weak var MemButtonView: UIView!
    @IBOutlet weak var AddNewButton: MainMenuButton!
    
    @IBOutlet weak var AddNewView: UIView!
    
    let currentuser = AppUser(name: "Alena")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Device params: width  = 414, height = 896
        GreenView.frame.size.height = UIScreen.main.bounds.size.height/3
        GreenView.frame.size.width = UIScreen.main.bounds.size.width
        bgpic.frame.size.width = GreenView.frame.size.width
        bgpic.frame.size.height = GreenView.frame.size.height
        userGreeting.center.x = GreenView.center.x
        
        AppName.center.x = GreenView.center.x
        AppName.center.y = UIScreen.main.bounds.size.height*0.08
        AppLogo.center.y = UIScreen.main.bounds.size.height*0.08
        AppLogo.center.x = UIScreen.main.bounds.size.width*0.11
        
        username.center.x = GreenView.center.x
        username.center.y = GreenView.center.y + 20
        userGreeting.center.y = username.center.y - username.font.pointSize
        username.text = currentuser.name
        userprogress.text = String(Int.random(in: 0...50))+"/50" // Generate random number for progress\
        // (view.safeAreaLayoutGuide.layoutFrame.width) - ширина экрана

        userprogress.center.x = UIScreen.main.bounds.size.width*0.095
        userprogress.center.y = UIScreen.main.bounds.size.height/3 - 20
        LearnedTodayLabel.center.x = UIScreen.main.bounds.size.width*0.160
        LearnedTodayLabel.center.y = userprogress.center.y - 25
        
        QuestionLabel.center.x = GreenView.center.x //I know it's a bad practice. FIX LATER!
        QuestionLabel.center.y = UIScreen.main.bounds.size.height/36*15
        MemButtonView.center.x = GreenView.center.x
        MemButtonView.center.y = UIScreen.main.bounds.size.height/9*5
        AddNewView.center.x = GreenView.center.x
        AddNewView.center.y = UIScreen.main.bounds.size.height/9*7
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
