//
//  Constants.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

import Foundation

struct Api {
    private static let base = "https://demo-c.cdn.vmedia.ca/json/"
    public static let dateFormatt = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    
    static var сhannelsUrl:String {
        return "\(base)/Channels"
    }
    
    static var programItemsUrl: String {
        return "\(base)/ProgramItems"
    }
}

struct UIDemoConstants { //this is approach for dem
    static let sheduleWidth:CGFloat = 8000
    static let shedulePeriod:CGFloat = sheduleWidth/24 * 2 //every half hour
}
