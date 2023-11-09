//
//  CategoryView.swift
//  CoreData-Widget
//
//  Created by MAC on 08/11/2023.
//

import SwiftUI

struct CategoryView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name, order: .reverse)]) var categories: FetchedResults<Category>
    @Environment(\.managedObjectContext) var context
    @State private var showingAlert = false
    @State private var showingAlertEmpty = false
    @State private var nameCategory = ""
    
    var body: some View {
        NavigationStack {
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
                .alert("Create Category", isPresented: $showingAlert) {
                    TextField("", text: $nameCategory)
                    Button(action: {
                        if nameCategory.isEmpty {
                            showingAlertEmpty.toggle()
                            return
                        }
                        
                        let category = Category(context: context)
                        category.name = nameCategory
                        saveContext()
                        
                        
                    }, label: {
                        Text("Add")
                    })
                }
                .alert("Name cannot empty", isPresented: $showingAlertEmpty) {
                    
                }
                
                VStack {
                    ForEach(categories, id: \.id) { category in
                        NavigationLink {
                            ItemView(category: category)
                        } label: {
                            Text(category.name!)
                        }

                        
                    }
                }
                .padding()
                
                Spacer()
            }
            .ignoresSafeArea()
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

#Preview {
    CategoryView()
}
