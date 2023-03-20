//
//  ContentView.swift
//  ProjectCoreData
//
//  Created by Artem Leschenko on 20.03.2023.
//

import SwiftUI
import CoreData

struct MainView: View {
    
    @EnvironmentObject var pointsVM: PlanPointViewModel
    let vm: MainViewModel
    @State var title = ""
    @State var descript = ""
    @State var isBigger = false
    @State var needRefresh = false
    
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack{
                    Spacer().frame(height: 150)
                    List {
                        ForEach(pointsVM.points, id: \.self){ point in
                            NavigationLink() {
                                InfoPointView(point: point, needRefresh: $needRefresh).navigationBarBackButtonHidden(true)
                            } label: {
                                Text(point.title!)
                            }.listRowBackground(Color(.systemGray6))
                        }.onDelete { IndexSet in
                            IndexSet.forEach { index in
                                let point = pointsVM.points[index]
                                vm.delPoint(point: point)
                                pointsVM.getPoints()
                            }
                        }
                    }.accentColor(needRefresh ? .white: .black)
                        .listStyle(.plain)
                        .padding(.horizontal)
                }
                
                VStack{
                    VStack {
                        Spacer().frame(height: isBigger ? 0: 75)
                        
                        if isBigger{
                            Spacer().frame(height: 70)
                            NeumorphicStyleTextField(text: "Title...", inputText: $title)
                                .padding()
                            
                            CustomTextEditor(text: $descript, placeholder: "Write your text...")
                                .padding()
                                
                            Button {
                                vm.savePoint(title: title, descript: descript)
                                pointsVM.getPoints()
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
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(vm: MainViewModel()).environmentObject(PlanPointViewModel())
    }
}
