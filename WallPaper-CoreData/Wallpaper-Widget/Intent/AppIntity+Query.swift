//
//  AppIntent+Query.swift
//  WallPaper
//
//  Created by MAC on 31/10/2023.
//

import WidgetKit
import AppIntents
import SwiftUI

struct ImageSource: AppEntity {
    
    var id: String
    var actualName: String
    
    static var defaultQuery: ImageQuery = ImageQuery()
    
    func getCategory() -> Category? {
        return CoreDataService.shared.getCategory(name: actualName)
    }
    
    static var defaultValue: ImageSource {
        return ImageSource(id: "choose", actualName: WDFolderType.placeholder.rawValue)
    }
    
    func getSoundUrls(family: FamilyFolderType) -> [URL] {
        guard let cate = getCategory() else { return [] }
        
        return CoreDataService.shared.getSounds(category: cate, family: family)
    }
    
    func getButtonChecklistModel() -> ButtonCheckListModel {
        guard let cate = getCategory() else { return ButtonCheckListModel() }
        
        return CoreDataService.shared.getButtonCheckListModel(category: cate)
    }
    
    func getRoutineType() -> RoutinMonitorType {
        guard let cate = getCategory() else { return .single }
        
        return CoreDataService.shared.getRoutineType(with: cate.unwrappedRoutineType)
        
    }
    
    func getFolderType() -> WDFolderType {
        guard let cate = getCategory() else { return .placeholder }
        
        return CoreDataService.shared.getFolderType(with: cate.unwrappedFolder)
    }
            
    func getImages(family: FamilyFolderType) -> [UIImage] {
        guard let cate = getCategory() else { return [UIImage(named: AssetConstant.imagePlacehodel)!] }
        let images = CoreDataService.shared.getImages(category: cate, family: family)
        
        return images
    }
    
    static func getSuggested() -> [ImageSource] {
        
//        WidgetCenter.shared.getCurrentConfigurations { info in
//            switch info {
//            case .success(let success):
//                
//                success.forEach { info in
//                    print("DEBUG: \(info.family) family")
//                }
//            case .failure:
//                print("DEBUG: error family")
//            }
//        }
        
        
        
        return CoreDataService.shared.getSuggestedName().map { name in
            return ImageSource(id: name, actualName: name)
        }
    }
    
    static func getAllSource() -> [ImageSource] {
        var src = CoreDataService.shared.getSuggestedName().map { name in
            return ImageSource(id: name, actualName: name)
        }
        

        src.append(ImageSource.defaultValue)
        return src
    }
    
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Image Viet"
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(id)")
    }
}

struct ImageQuery: EntityStringQuery {
    
    func entities(matching string: String) async throws -> [ImageSource] {
        return ImageSource.getAllSource().filter { imgsrc in
            return imgsrc.id == string
        }
    }
    
    
    func entities(for identifiers: [ImageSource.ID]) async throws -> [ImageSource] {
   
        let imgs = ImageSource.getAllSource().filter { imgsrc in
            return identifiers.contains { id in
                return id == imgsrc.id
            }
        }
        
        if imgs.count > 0 && WidgetViewModel.shared.dict[imgs[0].actualName] == nil {
            if let cate = CoreDataService.shared.getCategory(name: imgs[0].actualName)  {
                let name = cate.unwrappedName
                WidgetViewModel.shared.dict[name] = ImageDataViewModel()
            }
        }
        
        if imgs.count > 0 {
            return [imgs[0]]
        } else {
            return []
        }
        
    }
    
    func suggestedEntities() async throws -> [ImageSource] {
        return ImageSource.getSuggested()
    }
    
    func defaultResult() async -> ImageSource? {
        return ImageSource.defaultValue
    }
}

