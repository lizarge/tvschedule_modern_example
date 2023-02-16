//
//  Constants.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

import Foundation
import UIKit
struct Api {
    private static let base = "https://demo-c.cdn.vmedia.ca/json/"
    public static let dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    
    static var сhannelsUrl:String {
        return "\(base)/Channels"
    }
    
    static var programItemsUrl: String {
        return "\(base)/ProgramItems"
    }
}

struct UIDemoConstants { //this is approach for demo
    
    static let zoom:CGFloat = 10
    
    static let sheduleWidth:CGFloat = 1440 * zoom
    
    static func cellWidht(_ length:Float)-> CGFloat {
        abs(CGFloat(length) * zoom - cellSpacer)
    }
    static let cellHeight:CGFloat = 80
    static let cellSpacer:CGFloat = 5
    
    static let sheduleIntervalMinute:Float = 30
    static let sheduleInterval:TimeInterval = TimeInterval(60 * sheduleIntervalMinute) // half hour
    
    static let backgroundColor = #colorLiteral(red: 0.2218184769, green: 0.4278398752, blue: 0.6166955233, alpha: 1)
    
    static let mockSheduleDate = Date() //Does matter, mock api not allowe set data to request
}
