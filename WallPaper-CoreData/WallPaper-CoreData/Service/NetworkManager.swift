//
//  NetworkManager.swift
//  WallPaper
//
//  Created by MAC on 26/10/2023.
//

import SwiftUI

enum WDNetworkManagerConstant {
    
    static let sheme = "https"
    static let host = "widget.eztechglobal.com"
    static let pathV1 = "/api/v1/widgets"
    static let query = "category+id,name-apps+id,name-tags+id,name"
    
}

class WDNetworkManager {
    var context = DataController().container.viewContext
    
    static let shared = WDNetworkManager()

    func requestApi(completion: @escaping ((Bool) -> Void)) {
        
        guard let url = constructRequest() else { completion(false); return }
        let urlRequest = URLRequest(url: url)
        let dispathGroup = DispatchGroup()
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            DispatchQueue.main.async {
                if error != nil { completion(false); return }
                guard let data = data else { completion(false); return }
                
                do {
                    let response = try JSONDecoder().decode(EztWidgetResponse.self, from: data)
                    
                    response.data.data.forEach { ezWidget in
                        dispathGroup.enter()
                        self.downloadFileCoreData(data: ezWidget) {
                            dispathGroup.leave()
                        }
                    }
                    
                    dispathGroup.notify(queue: .main) {
                        completion(true)
                    }

                } catch {
                    print("DEBUG: \(error.localizedDescription) fdfds")
                    DispatchQueue.main.async { completion(false) }
                }
            }

        }.resume()

    }
    
    private func downloadFileCoreData(data: EztWidget, completion: @escaping(() -> Void)) {
        let dispathGroup = DispatchGroup()
        let folderType = WDFolderType.getType(name: data.category.name)
        
        let category = Category(context: context)
        category.folderType = folderType.rawValue
        category.name = "\(folderType.nameId) \(data.id)"
        category.creationDate = Date().timeIntervalSinceNow
        if folderType == .routineMonitor {
            let typeRoutine = RoutinMonitorType.getType(name: data.tags[0].name).nameId
            category.routineType = typeRoutine
        }
        
        for (index, path) in data.path.enumerated() {
                
            dispathGroup.enter()
            
            let familyType = FamilyFolderType.getType(name: path.key_type)
            let item = Item(context: context)
            item.family = familyType.rawValue
            item.creationDate = Date().timeIntervalSinceNow + Double(100 * index)
            item.name = path.file_name
            item.routine_type = (folderType == .routineMonitor) ? RoutinMonitorType.getType(name: data.tags[0].name).nameId : nil
            
            guard let url = URL(string: path.url.full),
                  let file = FileService.shared.relativePath?.appendingPathComponent("\(path.file_name)")
            else { context.reset(); dispathGroup.leave(); completion(); return }
            
            let urlRequest = URLRequest(url: url)

            URLSession.shared.downloadTask(with: urlRequest) { urlResponse, _, error in
                
                if let _ = error { self.context.reset(); dispathGroup.leave(); completion(); return }
                
                guard let urlResponse = urlResponse else  { self.context.reset(); dispathGroup.leave(); completion(); return  }
                
                FileService.shared.writeToSource(with: urlResponse, to: file)
                
                category.addToItems(item)
                self.saveContext()
                
                dispathGroup.leave()
                
            }.resume()
        }
        
        dispathGroup.notify(queue: .main) {
            completion()
        }
        
    }
    

}


extension WDNetworkManager {
    
    private func constructRequest() -> URL? {
        
        var components = URLComponents()
        components.scheme = WDNetworkManagerConstant.sheme
        components.host = WDNetworkManagerConstant.host
        components.path = WDNetworkManagerConstant.pathV1
        components.queryItems = [
            URLQueryItem(name: "with", value: WDNetworkManagerConstant.query),
        ]
        
        return components.url
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
    
    private func downloadFile(data: EztWidget, completion: @escaping(() -> Void)) {
        
        let dispathGroup = DispatchGroup()
        let folderType = WDFolderType.getType(name: data.category.name)
        var folderName = "\(folderType.nameId) \(data.id)"
        if folderType == .routineMonitor {
            let typeRoutine = RoutinMonitorType.getType(name: data.tags[0].name).nameId
            folderName =  "\(typeRoutine)-\(folderType.nameId) \(data.id)"
        }
        
        for (index, path) in data.path.enumerated() {
                
            dispathGroup.enter()
            
            let familyType = FamilyFolderType.getType(name: path.key_type)
            
            
            guard let url = URL(string: path.url.full),
                  let file = FileService.relativePath(with: "\(folderType.nameId)-\(folderName)")?.appendingPathComponent(familyType.rawValue).appendingPathComponent("\(path.file_name)")
            else { completion(); return}
    
            FileManager.default.createFile(atPath: file.path, contents: nil)
            
            
            let urlRequest = URLRequest(url: url)

            URLSession.shared.downloadTask(with: urlRequest) { urlResponse, _, error in
                if let _ = error { completion(); return }
                
                guard let urlResponse = urlResponse else  { completion(); return }
                
                
                FileService.shared.writeToSource(with: folderName,
                                                 with: urlResponse,
                                                 to: file,
                                                 widgetType: folderType,
                                                 familySize: familyType)
                do {
                    try FileManager.default.setAttributes([.creationDate: Date.now.addingTimeInterval(Double(index) * 10000000)], ofItemAtPath: file.path)
                } catch {
                    print("DEBUG: wwhy failed \(error.localizedDescription) and \(file.absoluteURL)")
                }
                dispathGroup.leave()
                
            }.resume()
        }
        
        dispathGroup.notify(queue: .main) {
            completion()
        }

    }
}
