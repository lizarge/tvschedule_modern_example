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
    let name:String
}
