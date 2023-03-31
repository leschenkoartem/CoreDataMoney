//
//  PlanPointViewModel.swift
//  ProjectCoreData
//
//  Created by Artem Leschenko on 20.03.2023.
//

import Foundation
import SwiftUI

class OrderViewModel: ObservableObject{
    
    var CoreData = CoreDataService.shared
    @Published var orders = [Order]()
    
    init(){
        getPoints()
    }
    
    func getPoints(){
        orders = CoreData.getAllPoints()
    }
}
