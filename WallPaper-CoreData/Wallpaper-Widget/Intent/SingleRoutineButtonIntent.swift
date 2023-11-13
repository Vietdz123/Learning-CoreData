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
        print("DEBUG: goto perform ToggleButtonIntent")
        
        WidgetViewModel.shared.dict[id_name]?.dateCheckList[id_day].isChecked.toggle()
        return .result()
    }
    
}
