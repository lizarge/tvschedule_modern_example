//
//  SheduleInteractor.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

final class SheduleInteractor: SheduleInteractorProtocol {
    
    let apiBoy:APIService!
    
    init(service:APIService) {
        self.apiBoy = service
    }
    
    weak var delegate: SheduleInteractorDelegate!
    
    func fetchProgram() {
        Task {
            do {
                let channels = try await apiBoy.getChannels()
                let programItems = try await apiBoy.getProgramItems()
                delegate.handle(.showData(channels, programItems))
            } catch {
                delegate.handle(.sendError(error))
            }
        }
    }
    
}
