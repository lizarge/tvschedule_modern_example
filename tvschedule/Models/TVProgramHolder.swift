//
//  TVProgramHolder.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

import Foundation

//TODO: Modernize that

class DailyProgram {
    
    public let storage:[Int:[ProgramItem]]
    public let sortedChannels:[Channel]
 
    init(channels:[Channel], items:[ProgramItem]) {
        
        self.sortedChannels = channels.sorted(by: { oneChannel, secondChannel in
            oneChannel.orderNum < secondChannel.orderNum
        })
        
        var tempStorage = [Int:[ProgramItem]]()
        
        channels.forEach { channel in
            tempStorage[channel.id] = [ProgramItem]()
        }
    
        //MARK: look like no need sort at time, but need to check it
        items.forEach { item in
            tempStorage[item.recentAirTime.channelID]?.append(item)
        }
        
        storage = tempStorage
    }

}
