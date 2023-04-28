//
//  CoreDataService.swift
//  ProjectCoreData
//
//  Created by Artem Leschenko on 20.03.2023.
//

import Foundation
import SwiftUI
import CoreData

class CoreDataService: ObservableObject {
    
    static var shared = CoreDataService()
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Orders")
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else { print("Error of loading: \(error!.localizedDescription)"); return }
        }
    }
    
    func updatePoint() {
        do{
            try persistentContainer.viewContext.save()
        }catch let error {
            persistentContainer.viewContext.rollback()
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func delPoint(point: Order){
        persistentContainer.viewContext.delete(point)
        
        do{
            try persistentContainer.viewContext.save()
        }catch let error {
            persistentContainer.viewContext.rollback()
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func savePoint(title: String, descript: String, type: String, price: String, vitNad: String) {
        let point = Order(context: persistentContainer.viewContext)
        point.title = title
        point.type = type
        point.price = price
        point.descript = descript
        point.vitNad = vitNad
        point.time = Date()
        
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getAllPoints() -> [Order] {
        let fetchRequest: NSFetchRequest<Order> = Order.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch let error {
            print("Error: \(error.localizedDescription)")
            return []
        }
    }
}
