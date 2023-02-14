//
//  ProgramCell.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 14.02.2023.
//

import UIKit

class ProgramCell: UICollectionViewCell {
    
    var program:ProgramItem?
    lazy var dateFormatter = {
        return DI.container.resolve(DateFormatter.self, name: DI.DateFormatterStyles.time.rawValue)!
    }()
    
    @IBOutlet weak var programNameLabel: UILabel!
    
    func setup(program:ProgramItem){
        self.program = program
        self.programNameLabel.text = program.shortName ?? program.name
    }
    
    override var isSelected: Bool {
        didSet {
            guard let program = self.program else {
                return
            }
            
            let name = program.shortName ?? program.name
            
            if isSelected {
                let time = self.dateFormatter.string(from: program.startTime)
                self.programNameLabel.text = "\(name)\n\(time)"
            } else {
                self.programNameLabel.text = name
            }
        }
    }
    
}
