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
    public let name: String
}

extension ChannelsListItemViewModel: Equatable {
    public init(channel: Channel) {
        self.id = channel.id
        self.name = channel.name
    }
    
    public static func == (lhs: ChannelsListItemViewModel, rhs: ChannelsListItemViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
