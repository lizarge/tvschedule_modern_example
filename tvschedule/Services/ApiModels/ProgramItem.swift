//
//  File.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

import Foundation

struct ProgramItem:Codable, Hashable, Equatable {
    
    static func == (lhs: ProgramItem, rhs: ProgramItem) -> Bool {
        lhs.recentAirTime.id == rhs.recentAirTime.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.recentAirTime.id)
    }

    
    struct RecentAirTime:Codable {
        let id:Int
        let channelID:Int
    }
    
    let startTime:Date
    let recentAirTime:RecentAirTime
    let shortName:String?
    let name:String
}
