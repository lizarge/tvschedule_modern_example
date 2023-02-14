//
//  ChannelCell.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 14.02.2023.
//

import UIKit

class ChannelCell: UICollectionViewCell {
    
    @IBOutlet weak var channelNumberLabel: UILabel!
    @IBOutlet weak var channelNameLabel: UILabel!
    
    func setup(channel:Channel) {
        channelNumberLabel.text = "\(channel.accessNum)"
        channelNameLabel.text = "\(channel.callSign)"
    }
}
