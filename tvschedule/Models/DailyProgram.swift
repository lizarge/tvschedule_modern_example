//
//  TVProgramHolder.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

import Foundation

//TODO: Modernize that

class DailyProgram {
    
    private let storage:[Int:[ProgramItem]]
    private let sortedChannels:[Channel]
    
    private let sheduleStartTime:Date
    private let sheduleEndTime:Date
 
    init(channels:[Channel], items:[ProgramItem]) {
        
        self.sortedChannels = channels.sorted(by: { oneChannel, secondChannel in
            oneChannel.orderNum < secondChannel.orderNum
        })
        
        var tempStorage = [Int:[ProgramItem]]()
        
        channels.forEach { channel in
            tempStorage[channel.id] = [ProgramItem]()
        }
    
        var tempSheduleStartTime = Date()
        var tempSheduleEndTime = Date(timeIntervalSince1970: 0)
        
        items.forEach { item in
            
            //MARK: This is bad solution, in real application we can got this timeframe in request, but for demo its ok
            if tempSheduleStartTime > item.startTime {
                tempSheduleStartTime = item.startTime
            }
            if tempSheduleEndTime < item.endTime {
                tempSheduleEndTime = item.endTime
            }
            //MARK: demo only!
            
            tempStorage[item.recentAirTime.channelID]?.append(item)
        }
        
        sheduleStartTime = tempSheduleStartTime
        sheduleEndTime = tempSheduleEndTime
        
        storage = tempStorage
    }
    
    func sections()->[DailyProgram.Section] {
        return self.sortedChannels.map { channel in
            return DailyProgram.Section.main(channel)
        }
    }
    
    func items(section:Section)->[ProgramItem]{
        
        var items = [ProgramItem]()
        
        switch section {
        case .main(let channel):
            items = self.storage[channel.id] ?? []
        }
        
        guard items.count > 0 else {
            return []
        }
                
        items.insert(items.first!.spacer(to: sheduleStartTime), at: 0)
        items.append(items.last!.spacer(to: sheduleEndTime))
        
        return items
    }
    
    struct HeaderTimeShedule {
        let date:Date
        let isFull:Bool
    }
    
    enum Section:Hashable {
      case main(Channel)
    }

}

