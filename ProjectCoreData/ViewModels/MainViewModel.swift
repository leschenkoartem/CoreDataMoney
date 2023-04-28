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
    var category = [ "Інше", "Продукти", "Комуналка", "Ремонт", "Розваги", "Подорожі"]
    
    var categoryForShow: [String]{
            var list = category
            list.append("Усі")
            return list
    }
    func savePoint(title: String, descript: String, type: String, price: String, vitNad: String){
        CoreData.savePoint(title: title, descript: descript, type: type, price: price, vitNad: vitNad)
    }
    
    func delPoint(point: Order){
        CoreData.delPoint(point: point)
    }
    
    func getOrders(orders: [Order], type: String, typeVit: String, date: Range<Date>) -> (Double, [Order]) {
        var ordersFin =  orders
        
        switch type{
        case "Усі":
            ordersFin =  orders
        case "Інше":
             ordersFin = orders.filter {$0.type == "Інше"}
        case "Продукти":
             ordersFin = orders.filter {$0.type == "Продукти"}
        case "Комуналка":
             ordersFin =  orders.filter {$0.type == "Комуналка"}
        case "Ремонт":
             ordersFin =  orders.filter {$0.type == "Ремонт"}
        case "Розваги":
             ordersFin =  orders.filter {$0.type == "Розваги"}
        case "Подорожі":
             ordersFin =  orders.filter {$0.type == "Подорожі"}
        default:
            ordersFin =  orders
        }
        
        if typeVit == "Усі" {
            return (ordersFin.reduce(0.0){$0 + Double($1.price!)!}, ordersFin.filter {date.contains($0.time!)})
        } else {
            ordersFin = ordersFin.filter {date.contains($0.time!) && $0.vitNad == typeVit}
            return (ordersFin.reduce(0.0){$0 + Double($1.price!)!}, ordersFin)
        }
    }
}
