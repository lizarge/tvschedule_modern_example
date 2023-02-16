//
//  APIBoy.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

import Foundation
import Alamofire

class RestService: NetworkSource {
  
    private var headers: HTTPHeaders = ["Content-Type":"application/json"]
    
    func fetchChannels() async throws -> [Channel] {
        return (try await AF.request(Api.сhannelsUrl,method: .get, headers: self.headers).asyncDecodable(of: [Channel].self))
    }
    
    func fetchSheduleToDate(date: Date) async throws -> [ProgramItem] {
        return (try await AF.request(Api.programItemsUrl,method: .get, headers: self.headers).asyncDecodable(of: [ProgramItem].self))
    }
}
