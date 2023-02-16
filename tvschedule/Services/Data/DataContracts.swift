//
//  DataContracts.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 16.02.2023.
//

import Foundation

protocol NetworkSource { // we can use  wide methods to get data frpm internet
    func fetchChannels() async throws -> [Channel]
    func fetchSheduleToDate(date:Date) async throws ->  [ProgramItem]
}
