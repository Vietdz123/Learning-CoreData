//
//  ImageDataModel.swift
//  WallPaper
//
//  Created by MAC on 19/10/2023.
//

import SwiftUI

class ImageDataViewModel {
    
    let context = DataController().container.viewContext
    var dateCheckListModel: [WeekendDayModel] = [.init(day: .sunday), .init(day: .monday), .init(day: .tuesday), .init(day: .thursday),
                                                 .init(day: .wednesday), .init(day: .friday),
                                                 .init(day: .saturday)]
    var images: [UIImage] = []
    var btnChecklistModel = ButtonCheckListModel()
    var currentCheckImageRoutine: [Int] = Array(repeating: 0, count: 7)
    
    var checkedImages: [UIImage] = []
    var currentIndex: Int {
        return Int(category?.currentIndexDigitalFriend ?? 0)
    }
    var category: Category?
    
    
    
    func loadData(category: Category?) {
        guard let category = category else { print("DEBUG: return huhu"); return }
        self.category = category
        if category.isCheckedRoutine.isEmpty {
            self.dateCheckListModel = [.init(day: .sunday), .init(day: .monday), .init(day: .tuesday),
                                         .init(day: .wednesday), .init(day: .friday), .init(day: .thursday),
                                         .init(day: .saturday)]
        } else {
            self.dateCheckListModel = [.init(day: .sunday, isChecked: category.isCheckedRoutine[0]),
                                       .init(day: .monday, isChecked: category.isCheckedRoutine[1]),
                                       .init(day: .tuesday, isChecked: category.isCheckedRoutine[2]),
                                       .init(day: .thursday, isChecked: category.isCheckedRoutine[3]),
                                       .init(day: .wednesday, isChecked: category.isCheckedRoutine[4]),
                                        .init(day: .friday, isChecked: category.isCheckedRoutine[5]),
                                       .init(day: .saturday, isChecked: category.isCheckedRoutine[6])]
            print("DEBUG: \(category.isCheckedRoutine)")
        }

        if category.isCheckedRoutine.isEmpty {
            self.currentCheckImageRoutine = Array(repeating: 0, count: 7)
        } else {
            self.currentCheckImageRoutine = category.currentCheckImageRoutine.map { Int($0)}
        }
        
    }
    
     func updateCurrentIndex() {
        if images.count == 0 { return }
        
        if currentIndex < images.count - 1 {
            category?.currentIndexDigitalFriend += 1
        } else {
            category?.currentIndexDigitalFriend = 0
        }
         
         CoreDataService.shared.saveContext()
    }
    
    var currentImage: UIImage {
        if self.currentIndex >= images.count  {
            return self.images.count == 0 ? UIImage(named: AssetConstant.imagePlacehodel)! : images[0]
        }
        return self.images.count == 0 ? UIImage(named: AssetConstant.imagePlacehodel)! : images[currentIndex]
    }

    
}


class WidgetViewModel {
    
    static var shared = WidgetViewModel()
    
    var dict: [String: ImageDataViewModel] = [:]
    
}
