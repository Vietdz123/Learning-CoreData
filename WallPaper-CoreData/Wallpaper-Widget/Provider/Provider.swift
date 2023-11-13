//
//  Provider.swift
//  WallPaper
//
//  Created by MAC on 23/10/2023.
//

import SwiftUI
import WidgetKit

@available(iOS 17.0, *)
struct Provider: AppIntentTimelineProvider {
    
    
    func placeholder(in context: Context) -> SourceImageEntry {
        print("DEBUG: goto placeholder")
        return SourceImageEntry(image: UIImage(named: AssetConstant.imagePlacehodel)!, size: context.displaySize, type: .placeholder, btnChecklistModel: ButtonCheckListModel(), imgViewModel: ImageDataViewModel.shared, imgSrc: ImageSource(id: "img", actualName: "img"), routineType: .single)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SourceImageEntry {
        print("DEBUG: goto snapshot")
        return SourceImageEntry(image: UIImage(named: AssetConstant.imagePlacehodel)!, size: context.displaySize, type: .placeholder, btnChecklistModel: ButtonCheckListModel(), imgViewModel: ImageDataViewModel.shared, imgSrc: ImageSource(id: "img", actualName: "img"), routineType: .single)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SourceImageEntry> {
        
        print("DEBUG: goto timeline ")
         
        let imgSrc = WidgetViewModel.shared.dict[configuration.imageSrc.actualName] ?? ImageDataViewModel()
        
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
        
        let image = imgSrc.currentImage
        let type = configuration.imageSrc.getFolderType()
        let size = context.displaySize
        let btnCLModel = configuration.imageSrc.getButtonChecklistModel()
        let routineType = configuration.imageSrc.getRoutineType()
        WidgetViewModel.shared.dict[configuration.imageSrc.actualName]?.checkedImages = btnCLModel.checkImage
        
        let entry = SourceImageEntry(image: image,
                                     size: size,
                                     type: type,
                                     btnChecklistModel: btnCLModel,
                                     imgViewModel: imgSrc,
                                     imgSrc: configuration.imageSrc,
                                     routineType: routineType)
        
        return Timeline(entries: [entry], policy: .never)
    }
}
