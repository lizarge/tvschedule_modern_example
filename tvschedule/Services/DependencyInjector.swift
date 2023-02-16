//
//  DI.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

import Foundation
import Swinject
import UIKit

final class DependencyInjector {
    
    enum DateFormatterStyles:String {
        case time
        case fullToday
    }
    
    static public let container = Container()
    
    static func BuldDependecy() {
        setupGeneral()
        setupViews()
    }
    
    private static func setupGeneral(){
        
        container.register(DataManager.self) { resolver in
            return DataManager()
        }
        
        container.register(JSONDecoder.self) { resolver in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = Api.dateFormat
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            return decoder
        }
        
        container.register(DateFormatter.self,name: DateFormatterStyles.time.rawValue) { resolver in
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            return dateFormatter
        }
        
        container.register(DateFormatter.self,name: DateFormatterStyles.fullToday.rawValue) { resolver in
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .none
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            return dateFormatter
        }
    }
    
    private static func setupViews(){
        container.register(SheduleVC.self) { resolver in
            return ShedulePageBuilder.make(dataManager: resolver.resolve(DataManager.self)! )
        }
    }

}
