//
//  FileService.swift
//  WallPaper
//
//  Created by MAC on 19/10/2023.
//

import SwiftUI


class FileService {
    
    static let shared = FileService()
    
    static func relativePath(with nameFolder: String) -> URL? {
        FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: WDConstant.groupConstant)?.appendingPathComponent("Image-Folder").appendingPathComponent(nameFolder)
    }
    
     var relativePath: URL? {
         return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: WDConstant.groupConstant)?.appendingPathComponent("Image-Folder")
    }
    
    func readImage(item: Item) -> UIImage? {
        guard let url = FileService.shared.relativePath?.appendingPathComponent(item.unwrappedName),
              let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return nil }
        
        return image
    }
    
    func getFolderModels() -> [FolderModel] {
        
        let nameFolders = FileService.shared.getAllFolder()
        
        var folders: [FolderModel] = []
        
        nameFolders.forEach { name in
            let components = name.split(separator: "-")
            if components.count >= 2 {
                
                let nameType = String(components[0])
                let type = WDFolderType.getType(name: nameType)
                let noIdName = type == .routineMonitor ?  String(components[2]) : String(components[1])
                let folder = FolderModel(name: name, suggestedName: noIdName, type: type)
                folders.append(folder)
            }
        }
        
        return folders
    }
    
    func writeToSource(with urlImage: URL,
                       to file: URL) {
        
        guard let dataImage = try? Data(contentsOf: urlImage) else {return}
        
        //Image-Folder
        if !FileManager.default.fileExists(atPath: FileService.shared.relativePath?.path ?? "") {
            try? FileManager.default.createDirectory(at: FileService.shared.relativePath!, withIntermediateDirectories: false)
        }
        print("DEBUG: \(file.absoluteString)")
        
        do {
            try dataImage.write(to: file.absoluteURL)
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
        
    }
    
    func readAllImages(from nameFolder: String,
                       with family: FamilyFolderType)
    -> [UIImage] {
        
        guard let folder = FileService.relativePath(with: nameFolder)?.appendingPathComponent(family.rawValue) else {return []}
        guard var urls = try? FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: [.creationDateKey]) else {
            return []
        }
        
        urls = urls.sorted(by: {
            if let date1 = try? $0.resourceValues(forKeys: [.creationDateKey]).creationDate,
               let date2 = try? $1.resourceValues(forKeys: [.creationDateKey]).creationDate {
                return date1 < date2
            }
            return false
        })
                
        var images: [UIImage] = []
        
        urls.forEach({ url in
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {return}
            images.append(image)
        })
        
        return images
    }
    
    func getButtonChecklistModel(from nameFolder: String) -> ButtonCheckListModel {
        guard let folderCheck = FileService.relativePath(with: nameFolder)?.appendingPathComponent(FamilyFolderType.check.rawValue),
              let folderUncheck = FileService.relativePath(with: nameFolder)?.appendingPathComponent(FamilyFolderType.uncheck.rawValue)
            else {return ButtonCheckListModel()}
        
                
        guard var urlsCheck = try? FileManager.default.contentsOfDirectory(at: folderCheck, includingPropertiesForKeys: [.creationDateKey]),
              var urlUncheck = try? FileManager.default.contentsOfDirectory(at: folderUncheck, includingPropertiesForKeys: nil)
            else { return ButtonCheckListModel() }
        
        urlsCheck = urlsCheck.filter({ url in
            return url.absoluteString.first != "." })
        urlsCheck = urlsCheck.sorted(by: {
            if let date1 = try? $0.resourceValues(forKeys: [.creationDateKey]).creationDate,
               let date2 = try? $1.resourceValues(forKeys: [.creationDateKey]).creationDate {
                return date1 < date2
            }
            return false
        })
        
        urlUncheck = urlUncheck.filter({ url in
            return url.absoluteString.first != "." })
        
        
        var model = ButtonCheckListModel()
        urlsCheck.forEach { url in
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {return}
            
            model.checkImage.append(image)
            
        }
        
        urlUncheck.forEach { url in
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {return}
            
            model.uncheckImage.append(image)
        }
        
        return model
    }
    
}


extension FileService {
    
    private func getAllFolder() -> [String] {
       guard let folder = relativePath else {return []}
        guard let urls = try? FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil) else {return []}

        return urls.filter({ url in
            return !url.absoluteString.contains(".")
        }).map { url in
           return url.deletingPathExtension().lastPathComponent
       }
   }
    
    func writeToSource(with nameFolder : String,
                       with urlImage: URL,
                       to file: URL,
                       widgetType: WDFolderType = .digitalFriend,
                       familySize: FamilyFolderType) {
        
        guard let dataImage = try? Data(contentsOf: urlImage) else {return}
        
        //Image-Folder
        if !FileManager.default.fileExists(atPath: FileService.shared.relativePath?.path ?? "") {
            try? FileManager.default.createDirectory(at: FileService.shared.relativePath!, withIntermediateDirectories: false)
        }
        
        //Image-Folder/Background-Anime/
        if !FileManager.default.fileExists(atPath: FileService.relativePath(with: "\(widgetType.nameId)-\(nameFolder)")?.path ?? "") {
            try? FileManager.default.createDirectory(at: FileService.relativePath(with: "\(widgetType.nameId)-\(nameFolder)")!, withIntermediateDirectories: false)
        }
        
        //Image-Folder/Background-Anime/Square
        if !FileManager.default.fileExists(atPath: FileService.relativePath(with: "\(widgetType.nameId)-\(nameFolder)")?.appendingPathComponent(familySize.rawValue).path ?? "") {
            try? FileManager.default.createDirectory(at: FileService.relativePath(with: "\(widgetType.nameId)-\(nameFolder)")!.appendingPathComponent(familySize.rawValue), withIntermediateDirectories: false)
        }
        
        print("DEBUG: \(file.absoluteString) and \(file.lastPathComponent)")

        do {
            try dataImage.write(to: file.absoluteURL)
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
        
    }
    
}
