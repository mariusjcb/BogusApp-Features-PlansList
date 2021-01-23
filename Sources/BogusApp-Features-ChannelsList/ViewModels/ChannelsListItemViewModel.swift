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
    
    @Observable
    private(set) public var selectedPlanIndex: Int? = nil
    
    @Observable
    private(set) public var selectedPlan: Plan? = nil
}

extension ChannelsListItemViewModel: Equatable {
    public init(channel: Channel) {
        self.id = channel.id
        self.name = channel.name
    }
    
    public func removeSelectedPlan() {
        self.selectedPlan = nil
        self.selectedPlanIndex = nil
    }
    
    public func setSelectedPlan(_ plan: Plan, at index: Int) {
        self.selectedPlan = plan
        self.selectedPlanIndex = index
    }
    
    public static func == (lhs: ChannelsListItemViewModel, rhs: ChannelsListItemViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
