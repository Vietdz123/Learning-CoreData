//
//  CategoryController.swift
//  Todoey-CordeData
//
//  Created by Long Bảo on 13/03/2023.
//

import Foundation
import CoreData
import UIKit

class CategoryController: UITableViewController {

    
    //MARK: - Properties
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let searchController = UISearchController()
    private var indexCellSelected = 0
    
    private lazy var addNewItemAlert: UIAlertController = {
        var alertController = UIAlertController(title: "Add New Category", message: .none, preferredStyle: .alert)
        let actionAdd = UIAlertAction(title: "Add", style: .default) { _ in
            guard let title = alertController.textFields?.last?.text else {return}

            let category = Category(context: self.context)
            category.nameCategory = title
            
            self.categoryArray.append(category)
            self.tableView.reloadData()
            self.saveContext()
            self.addNewItemAlert.textFields?.last?.text = ""
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { haha in
        }
        
        alertController.addTextField { textFiled in
        }
        
        alertController.addAction(actionAdd)
        alertController.addAction(actionCancel)
        return alertController
    }()
    
    
    private lazy var changeTitleItemAlert: UIAlertController = {
        var alertController = UIAlertController(title: "Change Item", message: .none, preferredStyle: .alert)
        let actionChange = UIAlertAction(title: "Change", style: .default) { _ in
            self.categoryArray[self.indexCellSelected].nameCategory = self.changeTitleItemAlert.textFields?.last?.text
            self.saveContext()
            self.changeTitleItemAlert.textFields?.last?.text = ""
            self.tableView.reloadData()
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { haha in
        }
        
        alertController.addTextField { textFiled in
        }
        alertController.addAction(actionCancel)
        alertController.addAction(actionChange)
        return alertController
    }()
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllData()
        configureUI()
        getPathToFileCoreData()
    }
    
    //MARK: - Helpers
    func configureUI() {
        configureNavigation()
        
        tableView.register(TodoeyTableViewCell.self, forCellReuseIdentifier: TodoeyTableViewCell.reuseIdentifier)
    }
        
    func configureNavigation() {
        let appeare = UINavigationBarAppearance()
        appeare.backgroundColor = .systemBlue
        navigationItem.title = "Todoey - Category"
        let rightAddButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddNewItem))
        rightAddButton.tintColor = .white
        navigationItem.rightBarButtonItem = rightAddButton
        appeare.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.navigationController?.navigationBar.standardAppearance = appeare
        self.navigationController?.navigationBar.compactAppearance = appeare
        self.navigationController?.navigationBar.scrollEdgeAppearance = appeare
        
        self.navigationItem.searchController = searchController
        searchController.searchBar.backgroundColor = .white
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
    }
    
    func getPathToFileCoreData() {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("DEBUG: \(urls[urls.count - 1] as URL)")
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
    
    func loadAllData(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            self.categoryArray = try context.fetch(request)
            self.tableView.reloadData()
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func updateResultSearch(text: String) {
        let request = Category.fetchRequest()
        let query = text.trimmingCharacters(in: .whitespaces)
        if query == "" {
            self.loadAllData(with: request)
            return
        }
        let sort = NSSortDescriptor(key: "nameCategory", ascending: true)
        let precticate = NSPredicate(format: "nameCategory CONTAINS[cd] %@", argumentArray: [query])
        request.predicate = precticate
        request.sortDescriptors = [sort]
        self.loadAllData(with: request)
    }
    
    //MARK: - Selectors
    @objc func handleAddNewItem() {
        present(self.addNewItemAlert, animated: true, completion: .none)
    }
    
}
//MARK: - Delegate Datasource/DelegateTableView
extension CategoryController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoeyTableViewCell.reuseIdentifier, for: indexPath) as! TodoeyTableViewCell
        cell.titleLabel.text = self.categoryArray[indexPath.row].nameCategory
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let itemsVC = ItemsController()
        itemsVC.category = categoryArray[indexPath.row]
        self.navigationController?.pushViewController(itemsVC, animated: true)
    }
    
    
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 30
//    }
}

//MARK: - Delegate SearchController
extension CategoryController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        self.updateResultSearch(text: text)
    }
}


//MARK: - Delegate ItemTableViewCellDelegate
extension CategoryController: ItemTableViewCellDelegate {
    func didTapDeleteButton(_ indexPath: IndexPath?) {
        guard let indexPath = indexPath else {
            return
        }

        guard let items =  self.categoryArray[indexPath.row].toMultiItems as? Set<Items> else {return}
        for item in items {
            self.context.delete(item)
        }
        self.context.delete(self.categoryArray[indexPath.row])
        self.categoryArray.remove(at: indexPath.row)
        self.saveContext()
        self.tableView.reloadData()
        
    }
}
