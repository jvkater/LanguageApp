//
//  AddWordController.swift
//  StudyApp
//
//  Created by Евгений Катаев on 01/05/2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit
import Firebase


 class AddWordController: UIViewController {
    @IBAction func GetFromCameraPressed(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Note from developers", message: "Thank you for your interest in this functionality. We are now working tirelessly to implement this, and your interest is important for us.", preferredStyle: UIAlertController.Style.alert)
        Analytics.logEvent("InterestedInCamera", parameters: nil)
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
          print("Handle Ok logic here")
          }))

        present(refreshAlert, animated: true, completion: nil)
    }
    @IBAction func GetFromAudioPressed(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Note from developers", message: "Thank you for your interest in this functionality. We are now working tirelessly to implement this, and your interest is important for us.", preferredStyle: UIAlertController.Style.alert)
        Analytics.logEvent("InterestedInAudio", parameters: nil)
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
          print("Handle Ok logic here")
          }))

        present(refreshAlert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var backgroundView: UIView!
    override func viewDidLoad() {
           super.viewDidLoad()
           
           
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddWordController.handleTap(_:)))
           backgroundView.addGestureRecognizer(tapGesture)
       }
       @objc func handleTap(_ sender: UITapGestureRecognizer) {
           dismiss(animated: true, completion: nil)
       }
    
}
