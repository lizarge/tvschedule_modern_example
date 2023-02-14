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
        return DependencyInjector.container.resolve(DateFormatter.self, name: DependencyInjector.DateFormatterStyles.time.rawValue)!
    }()
    
    lazy var dateFormatter = {
        return DependencyInjector.container.resolve(DateFormatter.self, name: DependencyInjector.DateFormatterStyles.fullToday.rawValue)!
    }()
    
    func setup(headerTime:DailyProgram.HeaderTimeShedule) {
        headerTimeLabel.text = headerTime.isFull ? dateFormatter.string(from: headerTime.date) : timeFormatterShort.string(from: headerTime.date)
    }
}
