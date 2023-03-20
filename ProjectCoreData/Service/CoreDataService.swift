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
        persistentContainer = NSPersistentContainer(name: "PlanPoints")
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
    
    func delPoint(point: PlanPoint){
        persistentContainer.viewContext.delete(point)
        
        do{
            try persistentContainer.viewContext.save()
        }catch let error {
            persistentContainer.viewContext.rollback()
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func savePoint(title: String, descript: String) {
        let point = PlanPoint(context: persistentContainer.viewContext)
        point.title = title
        point.active = false
        point.descript = descript
        point.time = Date()
        
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getAllPoints() -> [PlanPoint] {
        let fetchRequest: NSFetchRequest<PlanPoint> = PlanPoint.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch let error {
            print("Error: \(error.localizedDescription)")
            return []
        }
    }
}
