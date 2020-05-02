//
//  AddWordController.swift
//  StudyApp
//
//  Created by Евгений Катаев on 01/05/2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

 class AddWordController: UIViewController {
 
    
    
    var backdropView: UIView = {
        let bdView = UIView(frame: CGRect(x: 0,y: 0,width: 375,height: 350))
              bdView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
              return bdView
          }()
    var MenuView: UIView = {
    let mView = UIView(frame: CGRect(x: 00,y: 350,width: 375,height: 350))
        mView.backgroundColor = .white
        mView.layer.cornerRadius = 10
          return mView
      }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        view.addSubview(backdropView)
        view.addSubview(MenuView)
        self.view.sendSubviewToBack(MenuView)
        backdropView.alpha = 0.2
        
       
        // Do any additional setup after loading the view.

    }
}
