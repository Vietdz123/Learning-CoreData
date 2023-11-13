//
//  ImageDataModel.swift
//  WallPaper
//
//  Created by MAC on 19/10/2023.
//

import SwiftUI

class ImageDataViewModel {
    
    static var shared = ImageDataViewModel()
    
    var dateCheckList: [WeekendDayModel] = [.init(day: .monday), .init(day: .tuesday), .init(day: .thursday),
                                            .init(day: .wednesday), .init(day: .friday),
                                            .init(day: .saturday), .init(day: .sunday)]
    var currentIndex = 0
    var images: [UIImage] = []
    var btnChecklistModel = ButtonCheckListModel()
    var dayChecklist = Array(repeating: 0, count: 7)
    var checkedImages: [UIImage] = []
    
     func updateCurrentIndex() {
        if images.count == 0 { return }
        
        if currentIndex < images.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
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
