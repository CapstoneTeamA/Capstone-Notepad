//
//  AddNoteViewController.swift
//  Capstone Notepad
//
//  Created by PSU2 on 6/17/17.
//  Copyright © 2017 PSU2. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {

    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteBody: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didSaveNote(_ sender: Any) {
        guard noteTitle.text != nil else {
            return
        }
        save(title: noteTitle.text!, body: noteBody.text)
    }
    
    func save(title: String, body: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let note = Note(context: managedContext)
        note.title = noteTitle.text
        note.body = noteBody.text
        note.timestamp = Date() as NSDate
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

//        let noteViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotesView") as! ViewController
//        self.navigationController?.pushViewController(noteViewController, animated: true)
    }
}
