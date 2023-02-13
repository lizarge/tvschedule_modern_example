//
//  SheduleContracts.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

//PRESENTER
protocol ShedulePresenterProtocol: class  {
    
}

enum ShedulePresenterOutputs {
    case showError(String)
    case showData
}

/*------------------------*/
//INTERACTOR
protocol SheduleInteractorProtocol: class  {
    var delegate: SheduleInteractorDelegate! {get set}
}

protocol SheduleInteractorDelegate: class  {
    func handle(_ output: SheduleInteractorOutputs)
}

enum SheduleInteractorOutputs {
    case sendError(String)
    case sendData
}


/*------------------------*/
//ROUTER
protocol SheduleRouterProtocol: class {
    var view: SheduleViewProtocol? { get set }
    func navigate(_ route: SheduleRoutes)
}

enum SheduleRoutes {
    
}

/*------------------------*/
//VIEW

protocol SheduleViewProtocol: class {
    func handle(_ output: ShedulePresenterOutputs)
}








