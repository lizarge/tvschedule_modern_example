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
        self.restService = RestService() // we user rest api, but can use wide variatins like web socker or etc here
    }
    
    func sheduleFor(date:Date, completion: @escaping (DailyProgram?, Error?)->() ) {
        
        //we specialy stop using asynk here, becouse we can use a wide option of caching for example buld in cache, or core data, or keyvalue storage
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
