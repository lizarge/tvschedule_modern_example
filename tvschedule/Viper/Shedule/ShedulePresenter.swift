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
}

extension ShedulePresenter: SheduleInteractorDelegate {
    func handle(_ output: SheduleInteractorOutputs) {
        
    }
}
