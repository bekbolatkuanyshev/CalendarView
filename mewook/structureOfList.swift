//
//  structureOfList.swift
//  mewook
//
//  Created by Бекболат Куанышев on 09.03.17.
//  Copyright © 2017 Bekbolat. All rights reserved.
//

import Foundation



class structerOfList: NSObject {
    
    var mainText : String
    var dayOfWeek : String
    var eachRow : [childOfList]?
    var selected : Bool
    
    init (mainText : String, dayOfWeek : String, eachRow : [childOfList]? = nil, selected : Bool = false) {
        self.mainText = mainText
        self.dayOfWeek = dayOfWeek
        self.eachRow = eachRow
        self.selected = selected
    }
}

class childOfList : NSObject {
    var time_from : String
    var type : String
    var time_to : String
    init(time_from : String, type : String, time_to : String) {
        self.time_from = time_from
        self.type = type
        self.time_to = time_to
    }
}
