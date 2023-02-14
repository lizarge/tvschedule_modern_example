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

            let decoder = DI.container.resolve(JSONDecoder.self)!
            
            self.responseDecodable(of: type, queue: queue, dataPreprocessor: dataPreprocessor, decoder: decoder, emptyResponseCodes: emptyResponseCodes, emptyRequestMethods: emptyRequestMethods) { response in
           
                switch response.result {
                case .success(let decodedResponse):
                    continuation.resume(returning: decodedResponse )
                case .failure(let error):
                    if let data = response.data, let text = String(data: data, encoding: .utf8) {
                        //MARK: Just log
                        print("API PROBLEM:\n" + text)
                        print(error.localizedDescription)
                    }
                    continuation.resume(throwing: error)
                }
            }
        })
    }
}


