//
//  OrderView.swift
//  ProjectCoreData
//
//  Created by Artem Leschenko on 31.03.2023.
//

import SwiftUI

struct OrderView: View {
    
    var categ: [String]
    @Binding var needRefresh: Bool
    var pointsVM: OrderViewModel
    let vm: MainViewModel
    @State var showDialog = false
    @State var fulls = false
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd HH:mm"
            return formatter
        }()
    var order: Order
    
    var body: some View {
        
            VStack(spacing: 5){
                Spacer().frame(height: 10)
                HStack{
                    Text(order.title ?? "")
                        .padding(.horizontal, 20)
                        .font(.title)
                    Spacer()
                }
                
                HStack{
                    Spacer().frame(width: 20)
                    Text("Kатегорія:").fontWeight(.bold)
                    Text(order.type ?? "")
                    Spacer()
                }
                
                HStack{
                    Spacer().frame(width: 20)
                    Text("Витрата:").fontWeight(.bold)
                    Text(order.price ?? "")
                    Spacer()
                }
                
                HStack{
                    Spacer().frame(width: 20)
                    Text("Дата додавання:").fontWeight(.bold)
                    Text(dateFormatter.string(from: order.time ?? Date()))
                    Spacer()
                }
                
                HStack{
                    Button {
                        fulls.toggle()
                    } label: {
                        Text("redact").padding(.vertical, 6)
                            .frame(width: 120)
                            .background(.blue.opacity(0.5))
                            .cornerRadius(5)
                            
                    }.foregroundColor(Color(.label))
                    
                    Spacer().frame(width: 50)
                    
                    Button {
                        showDialog.toggle()
                    } label: {
                        Text("delete").padding(.vertical, 6)
                            .frame(width: 120)
                            .background(.red.opacity(0.5))
                            .cornerRadius(5)
                        
                    }.foregroundColor(Color(.label))
                    
                }.padding()


                Spacer()
                
            }
            .confirmationDialog("Ви впевнені, що бажаєте це видалити", isPresented: $showDialog, actions: {
                
                Button {
                    vm.delPoint(point: order)
                    pointsVM.getPoints()
                } label: {
                    Text("Tak")
                }

                
                Button(role: .cancel) {
                    showDialog.toggle()
                } label: {
                    Text("No")
                }
            })
            .fullScreenCover(isPresented: $fulls, content: {
                InfoPointView(order: order, needRefresh: $needRefresh, categ: categ)
            })
            .frame(height: 200, alignment: .leading)
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray5))
            .cornerRadius(12)
            .padding(.horizontal, 30)
    }
    
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(categ: [ "Інше", "Продукти", "Комуналка", "Ремонт", "Розваги", "Подорожі"], needRefresh: .constant(false), pointsVM: OrderViewModel(), vm: MainViewModel(), order: Order.example)
    }
}
