//
//  ShedulePresenter.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

import Foundation

final class ShedulePresenter: ShedulePresenterProtocol {
   
    private let interactor: SheduleInteractorProtocol!
    private let router: SheduleRouterProtocol!
    weak var view: SheduleViewProtocol?
    
    init(_ router: SheduleRouterProtocol, _ interactor: SheduleInteractorProtocol) {
        self.router = router
        self.interactor = interactor
        
        interactor.delegate = self
    }
    
    func loadProgramShedule(date: Date) {
        self.interactor.loadProgram(date: date )
    }
}

extension ShedulePresenter: SheduleInteractorDelegate {

    //Presenter just prepare data for display withour any big deal logic
    func handle(_ output: SheduleInteractorOutputs) {
        switch output {
        case .showData(let program):
            self.view?.handle(.showData( program ))
        case .sendError(let error):
            self.view?.handle(.showError(error ?? NSError() ))
        }
        
    }
}
