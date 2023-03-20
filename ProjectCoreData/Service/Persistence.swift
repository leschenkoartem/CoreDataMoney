//
//  Persistence.swift
//  vb
//
//  Created by Artem Leschenko on 20.03.2023.
//

import CoreData

extension PlanPoint {
    
    // Example PlanMovie for Xcode previews
    static var example: PlanPoint {
        
        // Get the first PlanPoint from the in-memory Core Data store
        let context = CoreDataService.shared.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<PlanPoint> = PlanPoint.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        let results = try? context.fetch(fetchRequest)
        
        return (results?.first!)!
    }
}
