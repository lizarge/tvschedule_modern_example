//
//  HeaderCell.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 14.02.2023.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    @IBOutlet weak var headerTimeLabel: UILabel!
    
    lazy var timeFormatterShort = {
        return DI.container.resolve(DateFormatter.self, name: DI.DateFormatterStyles.time.rawValue)!
    }()
    
    lazy var dateFormatter = {
        return DI.container.resolve(DateFormatter.self, name: DI.DateFormatterStyles.fullToday.rawValue)!
    }()
    
    func setup(headerTime:DailyProgram.HeaderTimeShedule) {
        headerTimeLabel.text = headerTime.isFull ? dateFormatter.string(from: headerTime.date) : timeFormatterShort.string(from: headerTime.date)
    }
}
