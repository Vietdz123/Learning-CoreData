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
    
    func readImage(with nameFolder: String, item: Item) -> UIImage? {
        guard let url = FileService.relativePath(with: nameFolder)?.appendingPathComponent(item.unwrappedName),
              let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return nil }
        
        return image
    }
    
    
    func readUrls(with nameFolder: String, item: Item) -> URL? {
        guard let url = FileService.relativePath(with: nameFolder)?.appendingPathComponent(item.unwrappedName) else { return nil }
        
        return url
    }
    

    
    func writeToSource(with namefolder: String,
                       with urlImage: URL,
                       to file: URL) {
        
        guard let dataImage = try? Data(contentsOf: urlImage) else {return}
        
        //Image-Folder
        if !FileManager.default.fileExists(atPath: FileService.shared.relativePath?.path ?? "") {
            try? FileManager.default.createDirectory(at: FileService.shared.relativePath!, withIntermediateDirectories: false)
        }
        
        if !FileManager.default.fileExists(atPath: FileService.relativePath(with: namefolder)?.path ?? "") {
            try? FileManager.default.createDirectory(at: FileService.relativePath(with: namefolder)!, withIntermediateDirectories: false)
        }
        
        print("DEBUG: \(file.absoluteString)")
        
        do {
            try dataImage.write(to: file.absoluteURL)
        } catch {
            print("DEBUG: \(error.localizedDescription)")
        }
        
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
