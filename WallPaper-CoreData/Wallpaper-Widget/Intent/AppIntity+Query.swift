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
    
    func getCategory() -> Category {
        return CoreDataService.shared.getCategory(name: actualName)
    }
    
    static var defaultValue: ImageSource {
        return ImageSource(id: "choose", actualName: WDFolderType.placeholder.rawValue)
    }
    
    func getButtonChecklistModel() -> ButtonCheckListModel {
        let cate = getCategory()
        
        return CoreDataService.shared.getButtonCheckListModel(category: cate)
    }
    
    func getRoutineType() -> RoutinMonitorType {
        let cate = getCategory()
        return CoreDataService.shared.getRoutineType(with: cate.unwrappedRoutineType)
        
    }
    
    func getFolderType() -> WDFolderType {
        let cate = getCategory()
        
        return CoreDataService.shared.getFolderType(with: cate.unwrappedFolder)
    }
            
    func getImages(family: FamilyFolderType) -> [UIImage] {
        let cate = getCategory()
        
        return CoreDataService.shared.getImages(category: cate, family: family)
    }
    
    static func getSuggested() -> [ImageSource] {
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
            WidgetViewModel.shared.dict[imgs[0].actualName] = ImageDataViewModel()
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

