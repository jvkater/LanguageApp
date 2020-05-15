//
//  AddWordController.swift
//  StudyApp
//
//  Created by Евгений Катаев on 01/05/2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

 class AddWordController: UIViewController {
 
    @IBOutlet weak var ManualButton: MainMenuButton!
    @IBAction func GoToManual(_ sender: Any) {
    }
    @IBOutlet weak var GetFromImageButton: MainMenuButton!
    
    @IBOutlet weak var GetFromAudioButton: MainMenuButton!
    @IBOutlet weak var GoBackButton: MainMenuButton!
    
    var backdropView: UIView = {
        let bdView = UIView(frame: CGRect(x: 0,y: 0,width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height/2))
              bdView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
              return bdView
          }()
    var MenuView: UIView = {
    let mView = UIView(frame: CGRect(x: 00,y: UIScreen.main.bounds.size.height/2,width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height/2))
        mView.backgroundColor = .white
        mView.layer.cornerRadius = 10
          return mView
      }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        view.addSubview(backdropView)
        view.addSubview(MenuView)
       
        ManualButton.center.x = UIScreen.main.bounds.width/2
        GetFromImageButton.center.x = UIScreen.main.bounds.width/2
        GetFromAudioButton.center.x = UIScreen.main.bounds.width/2
        GoBackButton.center.x = UIScreen.main.bounds.width/2
        
        ManualButton.center.y = UIScreen.main.bounds.height/32*18
        GetFromImageButton.center.y = UIScreen.main.bounds.height/32*21
        GetFromAudioButton.center.y = UIScreen.main.bounds.height/32*24
        GoBackButton.center.y = UIScreen.main.bounds.height/32*27
        
        
        self.view.sendSubviewToBack(MenuView)
        backdropView.alpha = 0.2
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddWordController.handleTap(_:)))
        backdropView.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
        // Do any additional setup after loading the view.
    func gotoSound(_ sender: UIButton){
        let tartgetVC = AddFromAudio()
        tartgetVC.modalPresentationStyle = .custom
        present(tartgetVC, animated: true, completion: nil)
    }

    
}
