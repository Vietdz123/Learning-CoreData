//
//  Provider.swift
//  WallPaper
//
//  Created by MAC on 23/10/2023.
//

import SwiftUI
import WidgetKit
import UIKit

@available(iOS 17.0, *)
struct Provider: AppIntentTimelineProvider {
    
    
    func placeholder(in context: Context) -> SourceImageEntry {
        print("DEBUG: goto placeholder")
        return SourceImageEntry(date: .now, image: UIImage(named: AssetConstant.imagePlacehodel)!, size: context.displaySize, type: .placeholder, btnChecklistModel: ButtonCheckListModel(), imgViewModel: ImageDataViewModel(), imgSrc: ImageSource(id: "img", actualName: "img"), routineType: .single)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SourceImageEntry {
        print("DEBUG: goto snapshot")
        WidgetCenter.shared.reloadAllTimelines()
        return SourceImageEntry(date: .now, image: UIImage(named: AssetConstant.imagePlacehodel)!, size: context.displaySize, type: .placeholder, btnChecklistModel: ButtonCheckListModel(), imgViewModel: ImageDataViewModel(), imgSrc: ImageSource(id: "img", actualName: "img"), routineType: .single)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SourceImageEntry> {
        
        print("DEBUG: goto timeline ")
         
        let imgSrc = WidgetViewModel.shared.dict[configuration.imageSrc.actualName] ?? ImageDataViewModel()
        
        imgSrc.loadData(category: configuration.imageSrc.getCategory())
        switch context.family {
        case .systemSmall, .systemLarge:
            imgSrc.images = configuration.imageSrc.getImages(family: .square)
        case .systemMedium:
            imgSrc.images = configuration.imageSrc.getImages(family: .rectangle)
        
        case .accessoryCircular, .accessoryInline, .accessoryRectangular:
            imgSrc.images = configuration.imageSrc.getImages(family: .rectangle)
        default:
            imgSrc.images = []
        }
        
        print("DEBUG: \(imgSrc.category?.currentIndexDigitalFriend) currentIndexDigitalFriend")
        
        if imgSrc.category?.hasSound == true {
            
            imgSrc.updateCurrentIndex()
        }
        
        let image = imgSrc.currentImage
        let type = configuration.imageSrc.getFolderType()
        let size = context.displaySize
        let btnCLModel = configuration.imageSrc.getButtonChecklistModel()
        let routineType = configuration.imageSrc.getRoutineType()
        WidgetViewModel.shared.dict[configuration.imageSrc.actualName]?.checkedImages = btnCLModel.checkImage
                
        var entries: [SourceImageEntry] = []
        
        let entry1 = SourceImageEntry(date: .now,
                                      image: image,
                                      size: size,
                                     type: type,
                                     btnChecklistModel: btnCLModel,
                                     imgViewModel: imgSrc,
                                     imgSrc: configuration.imageSrc,
                                     routineType: routineType)
        
        
        
        entries.append(entry1)
        if imgSrc.category?.hasSound == true && SoundPlayer.shared.updateStatus == .plus {
            
            imgSrc.updateCurrentIndex()
                            
            let entryDate = Date().addingTimeInterval(0.15)
                let image2 = imgSrc.currentImage
                let entry2 = SourceImageEntry(date: entryDate,
                                              image: image2,
                                              size: size,
                                              type: type,
                                              btnChecklistModel: btnCLModel,
                                              imgViewModel: imgSrc,
                                              imgSrc: configuration.imageSrc,
                                              routineType: routineType)
                
                entries.append(entry2)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                WidgetCenter.shared.reloadTimelines(ofKind: "WallpaperWidget")
//            }
        }
        
        let reloadDate = Calendar.current.date(byAdding: .second, value: 1, to: .now)!
        if entries.count >= 1 {
            return Timeline(entries: entries, policy: .never)
        } else {
            return Timeline(entries: entries, policy: .never)
        }

        
        
    }
}
