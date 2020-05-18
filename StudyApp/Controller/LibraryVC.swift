
//
//  LibraryVC.swift
//  StudyApp
//
//  Created by Евгений Катаев on 16/05/2020.
//  Copyright © 2020 Eugene. All rights reserved.
//

import UIKit
import CoreData


class LibraryVC: UIViewController {
    @IBOutlet weak var CompleteLibrary: UITableView!
    
    
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
    func deleteWord () {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WordsLibrary")
              do {
          let words = try managedContext.fetch(fetchRequest)
          for i in words {
            if i.value(forKey: "addedWord") as? String == " " {
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
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath)
                 -> UITableViewCell {
    let originalWord = WordsDataBase[indexPath.row]
    let cell =
      tableView.dequeueReusableCell(withIdentifier: "Cell",
                                    for: indexPath)
                    
    cell.textLabel?.text = originalWord.value(forKey: "addedWord") as? String
                    let label2 = UILabel(frame: CGRect(x: 210, y: 10, width: 110, height: 50))
                    label2.center.y = cell.center.y
                    label2.text = originalWord.value(forKey: "addedWordTranslation") as? String
                    cell.contentView.addSubview(label2)
    return cell
  }
}
