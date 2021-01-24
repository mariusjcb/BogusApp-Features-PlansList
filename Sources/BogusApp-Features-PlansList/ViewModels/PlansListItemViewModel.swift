//
//  PlansListItemViewModel.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import Foundation
import BogusApp_Common_Models
import BogusApp_Common_Utils

public struct PlansListItemViewModel {
    public let id: UUID
    
    public let price: String
    
    public let benefits: [String]
    
    public let channelName: String
}

extension PlansListItemViewModel: Equatable {
    public init(plan: Plan, channelName: String) {
        self.id = plan.id
        self.price = String(format: NSLocalizedString("%g€", comment: ""), plan.price)
        self.benefits = plan.benefits.map { $0.name }.sorted { $0 < $1 }
        self.channelName = channelName
    }
    
    public static func == (lhs: PlansListItemViewModel, rhs: PlansListItemViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
