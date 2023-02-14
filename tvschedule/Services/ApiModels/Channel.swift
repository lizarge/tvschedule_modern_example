//
//  Shedules.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

import Foundation

struct Channel:Codable, Hashable, Equatable {
    let id:Int
    let orderNum:Int
    let accessNum:Int
    let callSign:String

    enum CodingKeys: String, CodingKey {
        case callSign = "CallSign"
        case id, orderNum, accessNum
    }
}

