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
    
    //MARK: UI
    var collectionView: UICollectionView!
    var scrollView: UIScrollView!
    
    //MARK: Data
    private var currentProgramm:DailyProgram?
    
    typealias DataSource = UICollectionViewDiffableDataSource<DailyProgram.Section, DailyProgram.Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<DailyProgram.Section, DailyProgram.Item>
    
    private lazy var dataSource = makeDataSource()
    
    //MARK: VC lifecycle
    init(presenter: ShedulePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        self.presenter.loadProgramShedule(date: UIDemoConstants.mockSheduleDate)
    }
    
    //This is for demo UI only
    private func setUI() {
        self.scrollView = UIScrollView()
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        let extendedFrame = CGRect(x: 0, y: 0, width: UIDemoConstants.sheduleWidth * UIDemoConstants.zoom , height: view.frame.height)
       
        self.collectionView = UICollectionView(frame: extendedFrame, collectionViewLayout: UICollectionViewFlowLayout())
        self.collectionView.delegate = self
        
        self.scrollView.addSubview(self.collectionView)
        self.scrollView.contentSize = extendedFrame.size
        
        self.scrollView.backgroundColor = UIDemoConstants.backgroundColor
        self.collectionView.backgroundColor = UIDemoConstants.backgroundColor
        
        [ChannelCell.self, HeaderCell.self, ProgramCell.self].forEach { type in
            self.collectionView.register(  UINib(nibName: type.stringClassID, bundle: .main), forCellWithReuseIdentifier: type.stringClassID )
        }
    }
    
    //MARK: collection diffable data source
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(
        collectionView: collectionView,
        cellProvider: { (collectionView, indexPath, item) ->
          UICollectionViewCell? in
            
            switch item {
            case .program(let programItem):
                let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProgramCell.stringClassID,
                for: indexPath) as? ProgramCell
                
                cell?.setup(program: programItem)
                return cell
            case .header(let value):
                let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HeaderCell.stringClassID,
                for: indexPath) as? HeaderCell
                
                cell?.setup(headerTime: value)
                return cell
            case .channel(let channel):
                let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ChannelCell.stringClassID,
                for: indexPath) as? ChannelCell
                
                cell?.setup(channel: channel)
                return cell
            }
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
    
    //MARK: Viper stuff
    func handle(_ output: ShedulePresenterOutputs) {
        switch output {
        case .showData(let dailyProgramm):
            self.currentProgramm = dailyProgramm
            self.applySnapshot(animatingDifferences: true)
        case .showError(let error):
            self.error(text: error.localizedDescription)
        }
    }
}

//MARK: Collection view delegate

extension SheduleVC: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let item = dataSource.itemIdentifier(for: indexPath)  {
            switch item {
            case .program(let programItem):
                return CGSize(width: UIDemoConstants.cellWidht(programItem.length) , height: UIDemoConstants.cellHeight)
            case .header(_):
                return CGSize(width: UIDemoConstants.cellWidht(UIDemoConstants.sheduleIntervalMinute) , height: UIDemoConstants.cellHeight)
            case .channel(_):
                return CGSize(width: UIDemoConstants.cellWidht(UIDemoConstants.sheduleIntervalMinute) , height: UIDemoConstants.cellHeight)
            }
        }
        return CGSize()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return UIDemoConstants.cellSpacer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: UIDemoConstants.cellSpacer, left: 0, bottom: 0, right: 0)
    }
    
    //MARK: TVOS scrolling
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        if let item = dataSource.itemIdentifier(for: indexPath)  {
            switch item {
            case .program(_), .channel(_):
                return true
            default:
                return false
            }
        }
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        (context.previouslyFocusedView as? TVFocusCellProtocol)?.isSelected = false
        (context.nextFocusedView as? TVFocusCellProtocol)?.isSelected = true
    }
}


