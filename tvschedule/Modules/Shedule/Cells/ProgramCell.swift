//
//  ProgramCell.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 14.02.2023.
//

import UIKit

class ProgramCell: UICollectionViewCell {
    
    var program:ProgramItem?
    
    var isActive:Bool {
        return program?.name != nil || program?.shortName != nil
    }
    
    lazy var dateFormatter = {
        return DependencyInjector.container.resolve(DateFormatter.self, name: DependencyInjector.DateFormatterStyles.time.rawValue)!
    }()
    
    @IBOutlet weak var programNameLabel: UILabel!
    
    func setup(program:ProgramItem){
        self.program = program
        self.programNameLabel.text = program.shortName ?? program.name
        self.backgroundColor = isActive ? #colorLiteral(red: 0.06169543415, green: 0.1378391385, blue: 0.1920129061, alpha: 1) : #colorLiteral(red: 0.1543964744, green: 0.3696995378, blue: 0.5223004818, alpha: 1)
    }
    
    override var isSelected: Bool { // MARK: this is simplies way, for demo
        didSet {
            guard let program = self.program else {
                return
            }
            
            let name = program.shortName ?? program.name
            
            if isSelected {
                let time = self.dateFormatter.string(from: program.startTime)
                if let name = name {
                    self.programNameLabel.text = "\(name)\n\(time)"
                }
                self.backgroundColor = isActive ? #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1) : #colorLiteral(red: 0.1779210269, green: 0.4500252008, blue: 0.6450717449, alpha: 1)
            } else {
                self.programNameLabel.text = name
                self.backgroundColor = isActive ? #colorLiteral(red: 0.06169543415, green: 0.1378391385, blue: 0.1920129061, alpha: 1) : #colorLiteral(red: 0.1543964744, green: 0.3696995378, blue: 0.5223004818, alpha: 1)
            }
        }
    }
    
}
