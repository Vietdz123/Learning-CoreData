//
//  CheckListView.swift
//  WallPaper
//
//  Created by MAC on 23/10/2023.
//

import SwiftUI

@available(iOS 17.0, *)
struct CheckListView: View {
    
    var entry: SourceImageEntry
    
    var body: some View {
        ZStack {
            
            Image(uiImage: entry.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .frame(maxWidth: entry.size.width, maxHeight: entry.size.height)
                .ignoresSafeArea()
            
            VStack(content: {
                
                HStack(content: {
                    DayView(model: WeekendDayModel(day: .sunday), entry: entry)
                    DayView(model: WeekendDayModel(day: .monday), entry: entry)
                    DayView(model: WeekendDayModel(day: .tuesday), entry: entry)
                    DayView(model: WeekendDayModel(day: .wednesday), entry: entry)
                    
                })
                
                HStack(content: {
                    DayView(model: WeekendDayModel(day: .thursday), entry: entry)
                    DayView(model: WeekendDayModel(day: .friday), entry: entry)
                    DayView(model: WeekendDayModel(day: .saturday), entry: entry)
                })
                
            })
            
        }
    }
}

@available(iOS 17.0, *)
struct DayView: View {
    
    var model: WeekendDayModel
    var entry: SourceImageEntry
    
    var imgSrc: ImageDataViewModel {
        entry.imgViewModel
    }
    var btnCLModel: ButtonCheckListModel {
        entry.btnChecklistModel
    }
    var actualName: String {
        entry.imgSrc.actualName
    }
    
    var routineType: RoutinMonitorType {
        entry.routineType
    }
    
    var id_day: Int {
        model.day.rawValue
    }
    
    var currentIndexCheckImage: Int {
        entry.imgViewModel.dayChecklist[id_day]
    }
    
    var imageButton: UIImage {
        switch routineType {
        case .random:
            return imgSrc.dateCheckList[model.day.rawValue].isChecked ?
            btnCLModel.checkImage[currentIndexCheckImage] : btnCLModel.uncheckImage.shuffled().first ?? UIImage(named: AssetConstant.unchecklistButton)!
        case .single:
            return imgSrc.dateCheckList[id_day].isChecked ?
                  btnCLModel.checkImage.first ?? UIImage(named: AssetConstant.checklistButton)! : btnCLModel.uncheckImage.shuffled().first ?? UIImage(named: AssetConstant.unchecklistButton)!
        case .daily:
            if id_day > btnCLModel.checkImage.count - 1 {
                return btnCLModel.checkImage.first ?? UIImage(named: AssetConstant.unchecklistButton)!
            }
            
            return imgSrc.dateCheckList[id_day].isChecked ? btnCLModel.checkImage[id_day] : btnCLModel.uncheckImage.shuffled().first ?? UIImage(named: AssetConstant.unchecklistButton)!
        }
    }
    
    
    var body: some View {
        switch routineType {
        case .random:
            VStack(content: {
                Button(intent: RandomRoutinButtonIntent(id_day: id_day, id_name: actualName)) {
                    Image(uiImage: imageButton)
                        .resizable()
                        .frame(width: 60, height: 35)
                }
                
                Text(model.day.nameDay)
                    .foregroundColor(ImageDataViewModel.shared.dateCheckList[id_day].isChecked ?
                        .yellow : .white)
            })
        case .single, .daily:
            VStack(content: {
                Button(intent: SingleRoutineButtonIntent(id_day: id_day, id_name: actualName)) {
                    Image(uiImage: imageButton)
                        .resizable()
                        .frame(width: 60, height: 35)
                }
                
                Text(model.day.nameDay)
                    .foregroundColor(ImageDataViewModel.shared.dateCheckList[id_day].isChecked ?
                        .yellow : .white)
            })
        }
            

        
    


    }
}


