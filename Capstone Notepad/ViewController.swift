//
//  ViewController.swift
//  Capstone Notepad
//
//  Created by PSU2 on 6/17/17.
//  Copyright © 2017 PSU2. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var noteTableView: UITableView!
    var notes : [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTableView.reloadData()
        self.navigationItem.hidesBackButton = true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Note")
        
        //3
        do {
            notes = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if notes.count == 0
        {
            return 1
        }
        return notes.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        if notes.count == 0
        {
            cell.textLabel?.text = "No note exist"
            return cell
        }
       
        let note = notes[indexPath.row]

        cell.textLabel?.text = note.value(forKey: "title") as? String
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if notes.count == 0
        {
            return
        }
        
        let note = notes[indexPath.row]
//        let alert = UIAlertController(title: tableView.cellForRow(at: indexPath)?.textLabel?.text, message: note.value(forKey: "body") as? String, preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "Cancel",
//                                         style: .default)
//        
//        alert.addAction(cancelAction)
//        present(alert, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        let editView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditNoteView") as! EditNoteViewController
        editView.note = note as? Note
        
//        self.navigationController?.pushViewController(editView, animated: false)
        self.navigationController?.show(editView, sender: nil)
    }
}

