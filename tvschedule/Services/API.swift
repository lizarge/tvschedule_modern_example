//
//  Constants.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

import Foundation

struct Api {
    
    private static let base = "https://demo-c.cdn.vmedia.ca/json/"
    
    static var сhannelsUrl:String {
        return "\(base)/Channels"
    }
    
    static var programItemsUrl: String {
        return "\(base)/ProgramItems"
    }
    
}
