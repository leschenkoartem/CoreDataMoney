//
//  PlanListViewModel.swift
//  ProjectCoreData
//
//  Created by Artem Leschenko on 20.03.2023.
//

import Foundation
import SwiftUI

class MainViewModel{
    
    var CoreData = CoreDataService.shared
    
    
    func savePoint(title: String, descript: String){
        CoreData.savePoint(title: title, descript: descript)
    }
    
    func delPoint(point: PlanPoint){
        CoreData.delPoint(point: point)
    }
}
