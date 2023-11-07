//
//  ViewController.swift
//  Todoey-CordeData
//
//  Created by Long Bảo on 13/03/2023.
//

import UIKit
import CoreData

class ItemsController: UITableViewController, UISearchResultsUpdating {
    
    //MARK: - Properties
    var itemArray = [Items]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let searchController = UISearchController()
    var category: Category? {
        didSet {
            self.loadData()
            self.tableView.reloadData()
        }
    }
    private var indexCellSelected = 0
    
    private lazy var addNewItemAlert: UIAlertController = {
        var alertController = UIAlertController(title: "Add New Item", message: .none, preferredStyle: .alert)
        let actionAdd = UIAlertAction(title: "Add", style: .default) { _ in
            guard let title = alertController.textFields?.last?.text else {return}
            let item = Items(context: self.context)
            item.nameItem = title
            item.toCategory = self.category
            
            self.itemArray.append(item)
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
            self.itemArray[self.indexCellSelected].nameItem = self.changeTitleItemAlert.textFields?.last?.text
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
        configureUI()
        getPathToFileCoreData()
    }
    
    //MARK: - Helpers
    func configureUI() {
        configureNavigation()
        
        tableView.register(TodoeyTableViewCell.self, forCellReuseIdentifier: TodoeyTableViewCell.reuseIdentifier)
    }
    
    func configureNavigation() {
        navigationItem.title = "Todoey - Item"
        let rightAddButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddNewItem))
        rightAddButton.tintColor = .white
        let rightLoadAllButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(handleLoadAllButtonTapped))
        rightLoadAllButton.tintColor = .white
        let leftBackButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleBackButtonTapped))
        leftBackButton.tintColor = .white
        navigationItem.leftBarButtonItem = leftBackButton
        navigationItem.rightBarButtonItems = [rightAddButton, rightLoadAllButton]
        
        let appeare = UINavigationBarAppearance()
        appeare.backgroundColor = .systemBlue
        appeare.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.standardAppearance = appeare
        self.navigationController?.navigationBar.compactAppearance = appeare
        self.navigationController?.navigationBar.scrollEdgeAppearance = appeare
        
        self.navigationItem.searchController = searchController
        searchController.searchBar.backgroundColor = .white
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
    
    func loadAllData(with request: NSFetchRequest<Items> = Items.fetchRequest()) {
        do {
            self.itemArray = try context.fetch(request)
            self.tableView.reloadData()
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func loadData(request: NSFetchRequest<Items> = Items.fetchRequest(), precticate: NSPredicate? = nil) {
        guard let nameCategory = category?.nameCategory else {
            return
        }

        let query = NSPredicate(format: "toCategory.nameCategory CONTAINS %@", argumentArray: [nameCategory])
        
        if let precticate = precticate {
            let queryCompound = NSCompoundPredicate(andPredicateWithSubpredicates: [precticate, query])
            request.predicate = queryCompound
        } else {
            request.predicate = query
        }
        let sort = NSSortDescriptor(key: "nameItem", ascending: true)
        request.sortDescriptors = [sort]
        do {
            self.itemArray = try context.fetch(request)
            self.tableView.reloadData()
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func updateResultSearch(text: String) {
        let query = text.trimmingCharacters(in: .whitespaces)
        
        if query == "" {
            self.loadData()
            return
        }
        let precticate = NSPredicate(format: "nameItem CONTAINS[cd] %@", argumentArray: [query])
        self.loadData(precticate: precticate)
    }
    
    //MARK: - Selectors
    @objc func handleAddNewItem() {
        present(self.addNewItemAlert, animated: true, completion: .none)
    }
    
    @objc func handleBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleLoadAllButtonTapped() {
        self.loadAllData()
    }
}
//MARK: - Delegate Datasource/DelegateTableView
extension ItemsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoeyTableViewCell.reuseIdentifier, for: indexPath) as! TodoeyTableViewCell
        cell.titleLabel.text = self.itemArray[indexPath.row].nameItem
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        present(self.changeTitleItemAlert, animated: true, completion: .none)
        self.indexCellSelected = indexPath.row

    }
}

//MARK: - Delegate SearchController
extension ItemsController: UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        self.updateResultSearch(text: text)
    }
}
