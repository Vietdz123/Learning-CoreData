//
//  ContentView.swift
//  CoreData-Widget
//
//  Created by MAC on 08/11/2023.
//

import SwiftUI
import CoreData

struct ItemView: View {
    let category: Category
    @State private var items: [Item] = []
    @Environment(\.managedObjectContext) var context
    @State private var showingAlert = false
    @State private var showingAlertEmpty = false
    @State private var nameItem = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                ZStack(alignment: .center) {
                    Color.blue
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Spacer()
                        
                        HStack(alignment: .center, spacing: 8) {
                            Text("")
                                .frame(width: 20, height: 20)
                                .padding(.leading, 15)
                            
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
                //            .alert("Create Item", isPresented: $showingAlert) {
                //                TextField("", text: $nameItem)
                //                Button(action: {
                //                    if nameItem.isEmpty {
                //                        showingAlertEmpty.toggle()
                //                        return
                //                    }
                //
                //                    let item = Item(context: context)
                //                    item.name = nameItem
                //                    item.toCategory = category
                //                    saveContext()
                //
                //                }, label: {
                //                    Text("Add")
                //                })
                //            }
                //            .alert("Name cannot empty", isPresented: $showingAlertEmpty) {
                //
                //            }
                
                VStack {
                    ForEach(items, id: \.id) { item in
                        Text(item.name!)
                    }
                }
                .padding()
                
                Spacer()
            }
            .onAppear {
                //            loadData()
            }
            .background(.red)
            .ignoresSafeArea()
//            .navigationBarHidden(true)
           
        }  
        .navigationTitle("")
            .navigationBarBackButtonHidden()
            .navigationBarHidden(true)
    }
    
    
    func loadData(request: NSFetchRequest<Item> = Item.fetchRequest(), precticate: NSPredicate? = nil) {
        guard let nameCategory = category.name else {
            return
        }

        let query = NSPredicate(format: "%K CONTAINS %@", #keyPath(Item.toCategory.name), nameCategory)
        
        if let precticate = precticate {
            let queryCompound = NSCompoundPredicate(andPredicateWithSubpredicates: [precticate, query])
            request.predicate = queryCompound
        } else {
            request.predicate = query
        }
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        do {
            self.items = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
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
