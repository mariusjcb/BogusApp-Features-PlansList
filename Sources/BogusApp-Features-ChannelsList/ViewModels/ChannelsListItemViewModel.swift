//
//  ChannelsListItemViewModel.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import Foundation
import BogusApp_Common_Models
import BogusApp_Common_Utils

public struct ChannelsListItemViewModel {
    public let id: UUID
    
    public let title: String
    
    @Observable
    public var selected: Bool = false
}

extension ChannelsListItemViewModel: Equatable {
    public init(target: TargetSpecific) {
        self.id = target.id
        self.title = target.title
    }
    
    public static func == (lhs: ChannelsListItemViewModel, rhs: ChannelsListItemViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
