//
//  ContentView.swift
//  ProjectCoreData
//
//  Created by Artem Leschenko on 20.03.2023.
//

import SwiftUI
import CoreData

struct MainView: View {
    
    @EnvironmentObject var pointsVM: OrderViewModel
    let vm: MainViewModel
    @State var title = ""
    @State var descript = ""
    @State var price = ""
    @State var type = "Інше"
    @State var isBigger = false
    @State var needRefresh = false
    @State var vitNad = "Витрата"
    @State var showError = false
    
    @State var showVitNad = "Усі"
    @State var ShowType = "Усі"
    
    @State var startDate = Calendar.current.date(from: DateComponents(year: 2010, month: 1, day: 1))!
    @State var finishDate = Date()
    
    var DateRange: Range<Date> {
        get { Range(uncheckedBounds: (lower: startDate, upper: Calendar.current.date(byAdding: .hour, value: 1, to: finishDate)!)) }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                
                ScrollView{
                    
                    Spacer().frame(height: 120)
                    
                    let lisrOrders = vm.getOrders(orders: pointsVM.orders, type: ShowType, typeVit: showVitNad, date: DateRange)
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("Починаючи з: ")
                            Spacer()
                            DatePicker("",
                                       selection: $startDate,
                                       in: ...Date(),
                                       displayedComponents: .date
                            ).frame(maxWidth: 120)
                        }
                        
                        HStack{
                            Text("Закінчуючи: ")
                            Spacer()
                            DatePicker("",
                                       selection: $finishDate,
                                       in: ...Date(),
                                       displayedComponents: .date
                            ).frame(maxWidth: 120)
                        }
                        
                        HStack{
                            Text("Категорія:")
                            Spacer()
                            VStack {
                                Picker("Тип пошуку", selection: $ShowType) {
                                    ForEach(vm.categoryForShow, id: \.self) {
                                        Text($0)
                                    }
                                }.padding(.horizontal)
                                    .frame(width: 200)
                                    .background(Color(.systemGray5))
                                    .cornerRadius(12)
                                Picker("", selection: $showVitNad) {
                                    Text("Витрата").tag("Витрата")
                                    Text("Надходження").tag("Надходження")
                                    Text("Усі").tag("Усі")
                                }.padding(.horizontal)
                                    .frame(width: 200)
                                    .background(Color(.systemGray5))
                                    .cornerRadius(12)
                            }
                        }
                    }.padding(.horizontal, 30)
                    
                    VStack {
                        Text("Сума \(showVitNad == "Надходження" ? "надходжень": "витрат") за даний час і в категорії: ") +
                        Text(String(format: "%.2f", lisrOrders.0)).fontWeight(.bold)
                    }.padding()
                        .padding(.horizontal, 30)
                    
                    ForEach(lisrOrders.1, id: \.self){ order in
                        OrderView(categ: vm.category, needRefresh: $needRefresh, pointsVM: pointsVM, vm: vm, order: order)
                        }
                }.frame(maxWidth: needRefresh ? .infinity: .infinity)

                
                VStack {
                    VStack {
                        Spacer().frame(height: isBigger ? 0: 75)
                        
                        if isBigger{
                            Spacer().frame(height: 70)
                            NeumorphicStyleTextField(text: "Title...", inputText: $title)
                                .padding()
                            
                            NeumorphicStyleTextField(text: "Price...", inputText: $price)
                                .keyboardType(.numberPad)
                                .padding()
                            
                            HStack {
                                Picker("", selection: $type) {
                                    ForEach(vm.category, id: \.self) {
                                        Text($0)
                                    }
                                }.frame(maxWidth: 300)
                                    .background()
                                    .cornerRadius(12)
                                
                                Picker("", selection: $vitNad) {
                                    Text("Витрата").tag("Витрата")
                                    Text("Надходження").tag("Надходження")
                                }.frame(maxWidth: 300)
                                    .background()
                                    .cornerRadius(12)
                            }.padding()
                            
                            CustomTextEditor(text: $descript, placeholder: "Write your text...")
                                .padding()
                            
                            Button {
                                
                                if Double(price) != nil && title != "" {
                                    vm.savePoint(title: title,
                                                 descript: descript,
                                                 type: type == "" ? "Інше": type,
                                                 price: price, vitNad: vitNad)

                                    pointsVM.getPoints()
                                    price = ""
                                    title = ""
                                    descript = ""
                                } else {
                                    showError.toggle()
                                }
                                
                                
                            } label: {
                                CustomButton(title: "Save")
                            }
                            Spacer().frame(height: 30)
                        }
                        
                        Button {
                            withAnimation {
                                isBigger.toggle()
                            }
                        } label: {
                            Image(systemName: "chevron.down")
                                .rotationEffect(.degrees(isBigger ? 180 : 0))
                                .animation(.easeInOut(duration: 0.3), value: isBigger)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                        }
                        
                        Spacer().frame(height: 10)
                        
                    }.background(Color.indigo)
                        .cornerRadius(12)
                    
                    Spacer()
                    
                }.frame(maxWidth: .infinity)
                
            }.edgesIgnoringSafeArea(.top)
                .frame(maxWidth: .infinity)
        }.alert("Помилка введення даних!", isPresented: $showError) {
            Text("OK")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(vm: MainViewModel()).environmentObject(OrderViewModel())
    }
}
