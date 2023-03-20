//
//  PlanPointViewModel.swift
//  ProjectCoreData
//
//  Created by Artem Leschenko on 20.03.2023.
//

import Foundation
import SwiftUI

class PlanPointViewModel: ObservableObject{
    
    var CoreData = CoreDataService.shared
    @Published var points = [PlanPoint]()
    
    init(){
        getPoints()
    }
    
    func getPoints(){
        points = CoreData.getAllPoints()
    }
}
