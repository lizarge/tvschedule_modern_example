//
//  ShedulePageBuilder.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

import UIKit

struct ShedulePageBuilder {
    static func make(apiService:APIBoy) -> SheduleVC {
        let router = SheduleRouter()
        let interactor = SheduleInteractor(service: apiService)
        let presenter = ShedulePresenter(router,interactor)
        let destinationVC = SheduleVC(presenter: presenter)
        
        presenter.view = destinationVC
        router.view = destinationVC
        return destinationVC
    }
}
