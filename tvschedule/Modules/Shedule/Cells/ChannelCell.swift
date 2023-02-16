//
//  ChannelCell.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 14.02.2023.
//

import UIKit

class ChannelCell: UICollectionViewCell, TVFocusCellProtocol {
    
    @IBOutlet weak var channelNumberLabel: UILabel!
    @IBOutlet weak var channelNameLabel: UILabel!
    
    func setup(channel:Channel) {
        channelNumberLabel.text = "\(channel.accessNum)"
        channelNameLabel.text = "\(channel.callSign)"
    }
    
    override var isSelected: Bool { // MARK: this is simplies way, for demo
        didSet {
            self.backgroundColor = isSelected ? #colorLiteral(red: 0.2317674756, green: 0.4076089859, blue: 0.1226332411, alpha: 1): #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}
