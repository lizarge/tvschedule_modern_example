//
//  Date.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 15.02.2023.
//

import Foundation

extension Date {
    func minutesDifference(end: Date) -> Int
    {
       let diffComponents = Calendar.current.dateComponents([.minute, .second], from: self, to: end)
       let minutes = diffComponents.minute
       let seconds = diffComponents.second
       return abs(minutes ?? 0)
    }
}
