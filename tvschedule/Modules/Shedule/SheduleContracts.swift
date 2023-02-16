//
//  SheduleContracts.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

import Foundation

//PRESENTER
protocol ShedulePresenterProtocol: AnyObject  {
    func loadProgramShedule(date:Date)
}

enum ShedulePresenterOutputs {
    case showError(Error)
    case showData(DailyProgram)
}

/*------------------------*/
//INTERACTOR
protocol SheduleInteractorProtocol: AnyObject  {
    var delegate: SheduleInteractorDelegate! {get set}
    func loadProgram(date: Date)
}

protocol SheduleInteractorDelegate: AnyObject  {
    func handle(_ output: SheduleInteractorOutputs)
}

enum SheduleInteractorOutputs {
    case sendError(Error?)
    case showData(DailyProgram)
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








