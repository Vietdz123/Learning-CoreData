//
//  ContentView.swift
//  CoreData-Widget
//
//  Created by MAC on 08/11/2023.
//

import SwiftUI
import CoreData

struct ItemView: View {
    @StateObject var category: Category
    @Environment(\.managedObjectContext) var context
    @State private var showingAlert = false
    @State private var showingAlertEmpty = false
    @State private var nameItem = ""
    @Environment(\.dismiss) var dissmiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                ZStack(alignment: .center) {
                    Color.blue
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Spacer()
                        
                        HStack(alignment: .center, spacing: 8) {
                            Button(action: {
                                dissmiss()
                            }, label: {
                                Image(systemName: "arrowshape.backward")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                                    .padding(.leading, 20)
                            })
                            
                            Spacer()
                            
                            Text("Todoey - Category")
                                .foregroundColor(.white)
                                .bold()
                                .frame(maxWidth: .infinity)
                            
                            Spacer()
                            
                            Button(action: {
                                showingAlert.toggle()
                                print("DEBUG: aaaaa")
                            }, label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.white)
                                    .padding(.trailing, 20)
                            })
                            
                        }
                        
                    }
                    .padding(.bottom, 8)
                }
                .frame(height: 90)
                .alert("Create Item", isPresented: $showingAlert) {
                    TextField("", text: $nameItem)
                    Button(action: {
                        if nameItem.isEmpty {
                            showingAlertEmpty.toggle()
                            return
                        }
    
                        let item = Item(context: context)
                        item.name = nameItem
                        item.toCategory = category
                        category.addToItems(item)
                        saveContext()
                        
                    }, label: {
                        Text("Add")
                    })
                }
                .alert("Name cannot empty", isPresented: $showingAlertEmpty) {
    
                }
                
                VStack {
                    ForEach(category.itemArray) { item in
                        Text(item.unwrappedName)
                    }
                }
                .padding()
                
                Spacer()
            }
            .background(.red)
            .ignoresSafeArea()
           
        }  
        .navigationTitle("")
            .navigationBarBackButtonHidden()
            .navigationBarHidden(true)
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
