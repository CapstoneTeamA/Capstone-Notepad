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
    var notes : [Note] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        noteTableView.reloadData()
        self.navigationItem.hidesBackButton = true;

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
   
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<Note>(entityName: "Note")
        
        do {
            notes = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        notes.sort(by: {(lhs:Note, rhs:Note) -> Bool in return lhs.timestamp?.compare(rhs.timestamp! as Date) == ComparisonResult.orderedDescending})
        noteTableView.reloadData()
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
            cell.selectionStyle = UITableViewCellSelectionStyle.none
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

        tableView.deselectRow(at: indexPath, animated: true)
        let editView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditNoteView") as! EditNoteViewController
        editView.note = note
        
        self.navigationController?.show(editView, sender: nil)
    }
}

