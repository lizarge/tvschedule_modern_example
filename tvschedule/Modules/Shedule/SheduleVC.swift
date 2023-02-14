//
//  SheduleVC.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

import UIKit

class SheduleVC: UIViewController, SheduleViewProtocol {
    
    //MARK: VIPER
    let presenter: ShedulePresenterProtocol
    
    //MARK: Xib UI
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Data
    private var currentProgramm:DailyProgram?
    typealias DataSource = UICollectionViewDiffableDataSource<DailyProgram.Section, ProgramItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<DailyProgram.Section, ProgramItem>
    
    private lazy var dataSource = makeDataSource()
    
    init(presenter: ShedulePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: SheduleVC.stringClassID, bundle: nil)
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
        constructUI()
    }
    
    func handle(_ output: ShedulePresenterOutputs) {
        switch output {
        case .showData(let dailyProgramm):
            self.currentProgramm = dailyProgramm
            DispatchQueue.main.async {
                self.applySnapshot(animatingDifferences: true)
            }
        case .showError(let error):
            self.error(text: error.localizedDescription)
        }
    }
    
    //TODO: delegate this to spectial class
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(
        collectionView: collectionView,
        cellProvider: { (collectionView, indexPath, programItem) ->
          UICollectionViewCell? in

          let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProgramCell.stringClassID,
            for: indexPath) as? ProgramCell
          
            cell?.setup(program: programItem)
            
          return cell
        })
        return dataSource
    }
 
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        if let currentProgramm = currentProgramm {
            let sections = currentProgramm.sections()
            snapshot.appendSections( sections )
            sections.forEach { section in
                snapshot.appendItems( currentProgramm.items(section: section), toSection: section )
            }
        }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
}

extension SheduleVC: CodeGeneratedUIProtocol {
    func constructUI() {
        collectionView.register(
            UINib(nibName: ChannelCell.stringClassID, bundle: .main), forCellWithReuseIdentifier: ChannelCell.stringClassID)
        collectionView.register(
            UINib(nibName: HeaderCell.stringClassID, bundle: .main), forCellWithReuseIdentifier: HeaderCell.stringClassID)
        collectionView.register(
            UINib(nibName: ProgramCell.stringClassID, bundle: .main), forCellWithReuseIdentifier: ProgramCell.stringClassID)
    }
}

