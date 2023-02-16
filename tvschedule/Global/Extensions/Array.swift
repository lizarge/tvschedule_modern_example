//
//  Array.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 16.02.2023.
//

import Foundation

extension Array {
    mutating func appendLast(_ element:Array.Element?) {
        if let element = element {
            self.append(element)
        }
    }
    
    mutating func appendFirst(_ element:Array.Element?) {
        if let element = element {
            self.insert(element, at: 0)
        }
    }
}
