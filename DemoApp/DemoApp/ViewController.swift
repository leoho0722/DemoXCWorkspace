//
//  ViewController.swift
//  DemoApp
//
//  Created by Leo Ho on 2022/11/27.
//

import UIKit
import DemoDatabase

class ViewController: UIViewController {

    @IBOutlet weak var txfTitle: UITextField!
    @IBOutlet weak var txfContent: UITextField!
    @IBOutlet weak var btnCreate: UIButton!
    @IBOutlet weak var btnRead: UIButton!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var txvLog: UITextView!
    
    var entities: [Entity] = []
    
    var logMessage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Database.shared.getDatabaseFilePath())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        entities = Database.shared.readData()
        
        for entity in entities {
            logMessage += "id：\(entity.id)\ntitle：\(entity.title)\ncontent：\(entity.content)\n\n"
        }
        
        DispatchQueue.main.async {
            self.txvLog.text = self.logMessage
        }
    }
    
    @IBAction func btnCreateClicked(_ sender: UIButton) {
        guard let title = txfTitle.text,
              let content = txfContent.text else {
            return
        }
                
        let entity = Entity()
        entity.title = title
        entity.content = content
        
        Database.shared.createData(create: entity)
    }
    
    @IBAction func btnReadClicked(_ sender: UIButton) {
        let entitiesObject = Database.shared.readData()
        self.entities = entitiesObject
        
        logMessage = ""
        
        for entity in entities {
            logMessage += "id：\(entity.id)\ntitle：\(entity.title)\ncontent：\(entity.content)\n\n"
        }
        
        DispatchQueue.main.async {
            self.txvLog.text = self.logMessage
        }
    }
    
    @IBAction func btnUpdateClicked(_ sender: UIButton) {
        guard let title = txfTitle.text,
              let content = txfContent.text else {
            return
        }
        
        let entity = Entity()
        entity.id = entities[0].id
        entity.title = title
        entity.content = content

        Database.shared.updateData(update: entity)
    }
    
    @IBAction func btnDeleteClicked(_ sender: UIButton) {
        
        if entities.count > 0 {
            Database.shared.deleteData(delete: entities[0])
        }
    }
}
