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
    static public let container = Container()
    
    static func BuldDependecy() {
        setupGeneral()
        
        setupViews()
    }
    
    private static func setupGeneral(){
        container.register(APIBoy.self) { resolver in
            return APIBoy()
        }
                
        container.register(JSONDecoder.self) { resolver in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = Api.dateFormatt
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            return decoder
        }
        
        container.register(DateFormatter.self,name: DateFormatterStyles.time.rawValue) { resolver in
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            return dateFormatter
        }
        
        container.register(DateFormatter.self,name: DateFormatterStyles.fullToday.rawValue) { resolver in
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            return dateFormatter
        }
    }
    
    private static func setupViews(){
        container.register(SheduleVC.self) { resolver in
            return ShedulePageBuilder.make(apiService: resolver.resolve(APIBoy.self)! )
        }
    }
    
    enum DateFormatterStyles:String {
        case time
        case fullToday
    }
}
