//
//  ChangeBackgroundIntent.swift
//  WallPaper
//
//  Created by MAC on 27/10/2023.
//

import SwiftUI
import WidgetKit
import AppIntents

struct SingleRoutineButtonIntent: AppIntent {

    init() {
        
    }
    
    static var title: LocalizedStringResource = "SingleRoutineButtonIntent"
    
    @Parameter(title: "Name ID")
    var id_name: String
    
    @Parameter(title: "Day ID")
    var id_day: Int
    
    init(id_day: Int, id_name: String) {
        self.id_day = id_day
        self.id_name = id_name
    }
    
    func perform() async throws -> some IntentResult & ReturnsValue {
        print("DEBUG: goto perform SingleRoutineButtonIntent")

        if WidgetViewModel.shared.dict[id_name]?.category?.isCheckedRoutine.count ?? 0 > id_day - 1 {
            WidgetViewModel.shared.dict[id_name]?.category?.isCheckedRoutine[id_day].toggle()
            CoreDataService.shared.saveContext()
        }
        
        
        return .result()
    }
    
}
