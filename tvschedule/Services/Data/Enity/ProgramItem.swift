//
//  File.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

import Foundation

struct ProgramItem:Codable {
    
    struct RecentAirTime:Codable {
        let id:Int
        let channelID:Int
    }
    
    let startTime:Date
    let recentAirTime:RecentAirTime
    let shortName:String?
    let name:String?
    let length:Float
}

//Add some sugar

extension ProgramItem: Hashable, Equatable {
    var endTime:Date {
        return self.startTime + (Double(self.length) * 60)
    }
    
    static func == (lhs: ProgramItem, rhs: ProgramItem) -> Bool {
        lhs.recentAirTime.id == rhs.recentAirTime.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.recentAirTime.id)
    }
}

extension ProgramItem {
    func spacer(to:Date)->ProgramItem? {
        
        guard self.startTime != to && self.endTime != to else {
            return nil
        }
        
        let startTime = (self.startTime > to) ? to : self.endTime
        let length = (self.startTime > to) ? Float(self.startTime.minutesDifference(end: to)) : Float(self.endTime.minutesDifference(end: to))
        
        return ProgramItem(startTime: startTime,
                    recentAirTime: ProgramItem.RecentAirTime(id: -self.recentAirTime.id, channelID: self.recentAirTime.channelID),
                    shortName: nil,
                    name: nil,
                    length: length)
    }
}
