
//
//  LibraryVC.swift
//  StudyApp
//
//  Created by Евгений Катаев on 16/05/2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class LibraryVC: UIViewController {
    @IBOutlet weak var CompleteLibrary: UITableView!
    
    @IBOutlet weak var headlineLabel: UILabel!
    
    var WordsDataBase = [NSManagedObject]()
    
    func fetchAll(){
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      let managedContext = appDelegate.persistentContainer.viewContext
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WordsLibrary")
      do {
        let words = try managedContext.fetch(fetchRequest)
        for i in words {
            WordsDataBase.append(i)
        }
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
    }
    
    func deleteWord (wordToDelete:String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        Analytics.logEvent("DeletedWord", parameters: nil)
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WordsLibrary")
              do {
          let words = try managedContext.fetch(fetchRequest)
          for i in words {
            if i.value(forKey: "addedWord") as? String == wordToDelete {
                managedContext.delete(i)
                try managedContext.save()
            }
          }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAll()
        Analytics.logEvent("VisitedLibrary", parameters: nil)
        headlineLabel.text = "You have added " + String(WordsDataBase.count) + " words"
        
        CompleteLibrary.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
        CompleteLibrary.dataSource = self
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
extension LibraryVC: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return WordsDataBase.count
  }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle:   UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            deleteWord(wordToDelete: (WordsDataBase[indexPath.row].value(forKey: "addedWord") as? String)!)
            WordsDataBase.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .middle)
            tableView.endUpdates()
        }
    }
    
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
    let originalWord = WordsDataBase[indexPath.row]

    let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        
    cell.textLabel?.text = originalWord.value(forKey: "addedWord") as? String
    cell.detailTextLabel?.text = originalWord.value(forKey: "addedWordTranslation") as? String
        
    cell.accessoryType = UITableViewCell.AccessoryType.none
    // customizable part
    let wordStat = originalWord.value(forKey: "recallCluster") as? String
    var light_pic = UIImage(named: "Red_1.png") //Default image
        if wordStat == "Decent" {
            light_pic = UIImage(named: "Yellow_1.png")
        } else if wordStat == "Good" {
            light_pic = UIImage(named: "Green_1.png")
        }
    
    print("Word is ", originalWord.value(forKey: "addedWord") as? String)
    print("Success = ", originalWord.value(forKey: "successfullRecalls") as? Int)
    print("Failure = ", originalWord.value(forKey: "unsuccessfullRecalls") as? Int)
    print("Total = ", originalWord.value(forKey: "totalRecalls") as? Int)
    print("Word status = ", wordStat)
    cell.accessoryView = UIImageView(image: light_pic)
    cell.accessoryView?.frame = CGRect(x:0, y:0, width: 40, height: 12)

    return cell
  }
}
