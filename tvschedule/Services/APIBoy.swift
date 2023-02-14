//
//  APIBoy.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

import Foundation
import Alamofire

class APIBoy {
    
    //TODO: Cache?
    
    private var headers: HTTPHeaders = ["Content-Type":"application/json"]
    
    func getChannels() async throws -> [Channel] {
        return (try await AF.request(Api.сhannelsUrl,method: .get, headers: self.headers).asyncDecodable(of: [Channel].self))
    }
    
    func getProgramItems() async throws -> [ProgramItem] {
        return (try await AF.request(Api.programItemsUrl,method: .get, headers: self.headers).asyncDecodable(of: [ProgramItem].self))
    }
    
}
