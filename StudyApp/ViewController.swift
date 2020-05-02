//
//  ViewController.swift
//  StudyApp
//
//  Created by Евгений Катаев on 05/04/2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func unwindFromSelection(unwindsegue:UIStoryboardSegue) {
        
    }
    
    @IBAction func returnToRoot(unwindsegue:UIStoryboardSegue) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    func gotoAddWord(_ sender: UIButton) {
        let vc = AddWordController()
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }

}
