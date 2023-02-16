//
//  SheduleEntity.swift
//  tvschedule
//
//  Created by ankudinov aleksandr on 13.02.2023.
//

//TODO: Maybe bad idea for Diffable datasorce

import Foundation

//
struct SheduleEntity: Hashable{
    let channel:[Channel]
    let program:[ProgramItem]
}
