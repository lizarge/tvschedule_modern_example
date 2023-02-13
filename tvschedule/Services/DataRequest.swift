//
//  DataRequest.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

import Foundation
import Alamofire
import UIKit

public extension DataRequest {

    @discardableResult
    func asyncDecodable<T: Decodable>(of type: T.Type = T.self,
                                      noError:Bool = false,
                                      queue: DispatchQueue = .main,
                                      dataPreprocessor: DataPreprocessor = DecodableResponseSerializer<T>.defaultDataPreprocessor,
                                      emptyResponseCodes: Set<Int> = DecodableResponseSerializer<T>.defaultEmptyResponseCodes,
                                      emptyRequestMethods: Set<HTTPMethod> = DecodableResponseSerializer<T>.defaultEmptyRequestMethods
                                     ) async throws -> T {

        return try await withCheckedThrowingContinuation({ continuation in

            //TODO: INSERT DI HERE
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            self.responseDecodable(of: type, queue: queue, dataPreprocessor: dataPreprocessor, decoder: decoder, emptyResponseCodes: emptyResponseCodes, emptyRequestMethods: emptyRequestMethods) { response in
           
                switch response.result {
                case .success(let decodedResponse):
                    continuation.resume(returning: decodedResponse)
                case .failure(let error):
                    if noError {
                        continuation.resume(throwing: error)
                        return
                    }
                    if let data = response.data, let text = String(data: data, encoding: .utf8) {
                        self.processError(message: text)
                        print("API PROBLEM:\n" + text)
                        print(error.localizedDescription)
                    } else {
                        print(error.localizedDescription)
                    }
                    continuation.resume(throwing: error)
                }
            }
        })
    }
    
    func processError(message:String){
        UIApplication.shared.publicError(message: message)
    }
}


