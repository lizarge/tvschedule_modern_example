//
//  SheduleVC.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

import UIKit

class SheduleVC: UIViewController, SheduleViewProtocol {
    let presenter: ShedulePresenterProtocol
    
    init(presenter: ShedulePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "SheduleVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    fileprivate func setUI() {
        
    }
}

extension SheduleVC {
    func handle(_ output: ShedulePresenterOutputs) {
        
    }
}

