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
            //MARK: ^demo only!
            
            tempStorage[item.recentAirTime.channelID]?.append(item)
        }
        
        sheduleStartTime = tempSheduleStartTime
        sheduleEndTime = tempSheduleEndTime
        storage = tempStorage
    }
    
    private func generateHeaderItems(low:Date, hight:Date, inteval:TimeInterval = UIDemoConstants.sheduleInterval ) -> [Item] {
        var items = [ Item.header(HeaderTimeShedule(date: low, isFull: true)) ]
        
        var dateBuffer = low
        while dateBuffer < hight {
            items.append(Item.header( HeaderTimeShedule(date: dateBuffer, isFull: false) ))
            dateBuffer = dateBuffer.addingTimeInterval(inteval)
        }
        
        return items
    }
    
    func sections()->[DailyProgram.Section] {
        var sections = [DailyProgram.Section.header]
        sections.append(contentsOf:
            self.sortedChannels.map { channel in
                return DailyProgram.Section.main(channel)
            }
        )
        return sections
    }
    
    func items(section:Section)->[Item]{
        
        var items = [ProgramItem]()
        
        switch section {
        case .header:
            return self.generateHeaderItems(low: sheduleStartTime, hight: sheduleEndTime)
            
        case .main(let channel):
            items = self.storage[channel.id] ?? []
           
            items.appendFirst(items.first?.spacer(to: sheduleStartTime))
            items.appendLast(items.last?.spacer(to: sheduleEndTime))
            
            var items = items.map{Item.program($0)}
            items.appendFirst(Item.channel(channel))
            
            return items
        }
    }
    
    struct HeaderTimeShedule:Equatable, Hashable {
        let id:Int
        let date:Date
        let isFull:Bool
        
        init(date: Date, isFull: Bool) {
            self.id = date.hashValue
            self.date = date
            self.isFull = isFull
        }
    }
    
    enum Section:Hashable {
      case header
      case main(Channel)
    }
    
    enum Item:Hashable {
      case channel(Channel)
      case header(HeaderTimeShedule)
      case program(ProgramItem)
    }
}
