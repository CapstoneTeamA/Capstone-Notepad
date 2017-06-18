//
//  EditNoteViewController.swift
//  Capstone Notepad
//
//  Created by PSU2 on 6/17/17.
//  Copyright © 2017 PSU2. All rights reserved.
//

import UIKit
import CoreData

class EditNoteViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var bodyField: UITextView!
    var note : Note? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.text = note?.title
        bodyField.text = note?.body
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        delete()
    }
    @IBAction func saveNote(_ sender: Any) {
        save()
    }
    
    func save() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        note?.title = titleField.text
        note?.body = bodyField.text
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func delete() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(note!)
    }
}
