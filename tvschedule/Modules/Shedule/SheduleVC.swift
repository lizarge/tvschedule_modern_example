//
//  SheduleVC.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

import UIKit

class SheduleVC: UIViewController {
    let presenter: ShedulePresenterProtocol
    
    var currentProgramm:DailyProgram? {
        didSet {
            //TODO: Reload data
        }
    }
    
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
        
        self.presenter.updateProgramShedule()
    }
    
    fileprivate func setUI() {
        
    }
}

extension SheduleVC:SheduleViewProtocol {
    func handle(_ output: ShedulePresenterOutputs) {
        switch output {
        case .showData(let dailyProgramm):
            self.currentProgramm = dailyProgramm
        case .showError(let error):
            self.error(text: error.localizedDescription)
        }
    }
}

//TODO: temporaty stuff

enum Section {
  case main
}

typealias DataSource = UICollectionViewDiffableDataSource<Section, Channel>

