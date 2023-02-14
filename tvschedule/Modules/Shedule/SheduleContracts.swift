//
//  SheduleContracts.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

//PRESENTER
protocol ShedulePresenterProtocol: AnyObject  {
    func updateProgramShedule()
}

enum ShedulePresenterOutputs {
    case showError(Error)
    case showData(DailyProgram)
}

/*------------------------*/
//INTERACTOR
protocol SheduleInteractorProtocol: AnyObject  {
    var delegate: SheduleInteractorDelegate! {get set}
    func fetchProgram()
}

protocol SheduleInteractorDelegate: AnyObject  {
    func handle(_ output: SheduleInteractorOutputs)
}

enum SheduleInteractorOutputs {
    case sendError(Error)
    case showData([Channel],[ProgramItem])
}

/*------------------------*/
//ROUTER
protocol SheduleRouterProtocol: AnyObject {
    var view: SheduleViewProtocol? { get set }
    func navigate(_ route: SheduleRoutes)
}

enum SheduleRoutes {
    
}

/*------------------------*/
//VIEW

protocol SheduleViewProtocol: AnyObject {
    func handle(_ output: ShedulePresenterOutputs)
}








