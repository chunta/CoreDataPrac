//
//  ViewController.swift
//  CoreDataPrac
//
//  Created by Cindy on 2018/12/30.
//  Copyright © 2018年 Cindy. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onAdd()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //ManagedObjectContext
        let objcontext = appDelegate.persistentContainer.viewContext
        
        //New Entity
        let entity = NSEntityDescription.entity(forEntityName: "User", in: objcontext)
        
        //New ManagedObject from Entity
        let newUser = NSManagedObject(entity: entity!, insertInto: objcontext)
        newUser.setValue(String(format: "测试%.2d", arc4random()%10000), forKey: "name")
        newUser.setValue("1234", forKey: "password")
        newUser.setValue(arc4random()%110, forKey: "age")
        
        do {
            try objcontext.save()
        } catch {
            print("Failed saving")
        }
        
    }
    
    @IBAction func onFetch()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let objcontext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try objcontext.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String, data.value(forKey: "age") as! Int)
            }
            
        } catch {
            
            print("Failed")
        }
    }

}

