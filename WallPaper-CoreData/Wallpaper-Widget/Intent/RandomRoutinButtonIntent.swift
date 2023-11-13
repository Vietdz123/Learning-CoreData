//
//  RandomRoutinButtonIntent.swift
//  WallPaper
//
//  Created by MAC on 31/10/2023.
//

import SwiftUI
import WidgetKit
import AppIntents

struct RandomRoutinButtonIntent: AppIntent {

    init() {
        
    }
    
    static var title: LocalizedStringResource = "RandomRoutinButtonIntent"
    
    @Parameter(title: "Name ID")
    var id_name: String
    
    @Parameter(title: "Day ID")
    var id_day: Int
    
    init(id_day: Int, id_name: String) {
        self.id_day = id_day
        self.id_name = id_name
    }
    
    func perform() async throws -> some IntentResult & ReturnsValue {
        print("DEBUG: goto perform RandomRoutinButtonIntent")
        
        guard let imgViewModel = WidgetViewModel.shared.dict[id_name] else {return .result()}
        let images = imgViewModel.checkedImages
        
        if !imgViewModel.dateCheckList[id_day].isChecked {
            imgViewModel.dateCheckList[id_day].isChecked.toggle()
            return .result()
        }
        
        if imgViewModel.dayChecklist[id_day] < images.count - 1 {
            imgViewModel.dayChecklist[id_day] += 1
        } else {
            imgViewModel.dateCheckList[id_day].isChecked.toggle()
            imgViewModel.dayChecklist[id_day] = 0
        }
        

        return .result()
    }
    
}
