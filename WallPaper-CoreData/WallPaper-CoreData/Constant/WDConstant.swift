//
//  AppConstant.swift
//  WallPaper
//
//  Created by MAC on 23/10/2023.
//

import SwiftUI


struct WDConstant {
    static let groupConstant = "group.demo.wallpapercoredata"
    static let keyPlaceHolder = "choose"
    static let folderButtonChecklistName = "FolderButtonChecklist"
    
    static var containerURL: URL {
        return FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: WDConstant.groupConstant)!
    }
}

struct AssetConstant {
    static let imagePlacehodel = "placeHodel"
    static let logo = "logo"
    static let unchecklistButton = "m1"
    static let checklistButton = "m2"
}

