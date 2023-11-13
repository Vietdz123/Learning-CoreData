//
//  WallPaperView.swift
//  WallPaper
//
//  Created by MAC on 23/10/2023.
//

import WidgetKit
import SwiftUI
                
struct SourceImageEntry: TimelineEntry {
    let date: Date = .now
    let image: UIImage
    let size: CGSize
    let type: WDFolderType
    let btnChecklistModel: ButtonCheckListModel
    let imgViewModel: ImageDataViewModel
    let imgSrc: ImageSource
    let routineType: RoutinMonitorType
}

@available(iOS 17.0, *)
struct WallpaperWidgetEntryView : View {
    
    var entry: SourceImageEntry

    var body: some View {
 
        switch entry.type {
            
        case .digitalFriend:
            BackgroudView(entry: entry)
        case .routineMonitor:
            CheckListView(entry: entry)
        case .placeholder:
            PlaceholderView(size: entry.size)
        }

    }
}
