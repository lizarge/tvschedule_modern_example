//
//  DataManager.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 16.02.2023.
//

import Foundation

class DataManager {
    
    var restService:NetworkSource!
    
    init(){
        self.restService = RestService() // we use rest api, but we use wide variatins like web socket or etc here
    }
    
    func sheduleFor(date:Date, completion: @escaping (DailyProgram?, Error?)->() ) {
        
        //we specialy stop using asynk here, becouse we can use a wide option of caching solution
        //here,for example buld in cache, or core data, or keyvalue storage or ...
        //TODO: Implememnt cache logic here
        
        Task {
            do {
                let channels = try await restService.fetchChannels()
                let programItems = try await restService.fetchSheduleToDate(date: date)
                completion( DailyProgram(channels: channels, items: programItems), nil)
            }
            catch {
                completion(nil,error)
            }
        }
    }
}
