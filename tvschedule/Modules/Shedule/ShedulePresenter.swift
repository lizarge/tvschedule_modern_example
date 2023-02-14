//
//  ShedulePresenter.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

final class ShedulePresenter: ShedulePresenterProtocol {
    
    private let interactor: SheduleInteractorProtocol!
    private let router: SheduleRouterProtocol!
    weak var view: SheduleViewProtocol?
    
    init(_ router: SheduleRouterProtocol, _ interactor: SheduleInteractorProtocol) {
        self.router = router
        self.interactor = interactor
        
        interactor.delegate = self
    }
    
    func updateProgramShedule() {
        self.interactor.fetchProgram()
    }
}

extension ShedulePresenter: SheduleInteractorDelegate {
    
    //TODO: look i need move data logic from Presenter to hmmm
    
    func handle(_ output: SheduleInteractorOutputs) {
        
        switch output {
        case .showData(let channels, let programItems):
            self.view?.handle(.showData( DailyProgram(channels: channels, items: programItems) ))
        case .sendError(let error):
            self.view?.handle(.showError(error))
        }
        
    }
}
