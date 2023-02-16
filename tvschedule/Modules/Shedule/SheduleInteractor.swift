//
//  SheduleInteractor.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//
import Foundation

final class SheduleInteractor: SheduleInteractorProtocol {
    
    let dataManager:DataManager!
    
    init(service:DataManager) {
        self.dataManager = service
    }
    
    weak var delegate: SheduleInteractorDelegate!
    
    func loadProgram(date:Date) {
        dataManager.sheduleFor(date: date) { program, error in // in real life, in this section we need to add some data transformation, 
            if let program = program {
                self.delegate.handle(.showData(program))
            } else {
                self.delegate.handle(.sendError(error))
            }
        }
    }
}
