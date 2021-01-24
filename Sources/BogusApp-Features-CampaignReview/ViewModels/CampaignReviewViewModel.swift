//
//  CampaignReviewViewModel.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import Foundation
import BogusApp_Common_Models
import BogusApp_Common_Utils
import BogusApp_Features_PlansList

public struct CampaignReviewViewModelActions {
    public let sendEmail: (_ sendTo: String, _ message: String) -> Void
    
    public init(sendEmail: @escaping (_ sendTo: String, _ message: String) -> Void) {
        self.sendEmail = sendEmail
    }
}

public protocol CampaignReviewViewModelInput {
    func didTapSendEmail()
}

public protocol CampaignReviewViewModelOutput {
    var itemsObservable: Observable<[PlansListItemViewModel]> { get }
    var targetsStringObservable: Observable<String> { get }
}

public protocol CampaignReviewViewModel: CampaignReviewViewModelInput & CampaignReviewViewModelOutput { }

public final class DefaultCampaignReviewViewModel: CampaignReviewViewModel {
    
    private let actions: CampaignReviewViewModelActions
    
    private let targets: [TargetSpecific]
    
    private let selectedPlans: [(Channel, Plan)]
    
    @Observable private var items: [PlansListItemViewModel] = []
    @Observable private var targetsString: String = ""
    
    // MARK: - OUTPUT
    
    public var itemsObservable: Observable<[PlansListItemViewModel]> { _items }
    public var targetsStringObservable: Observable<String> { _targetsString }
    
    public init(targets: [TargetSpecific], selectedPlans: [(Channel, Int)], actions: CampaignReviewViewModelActions) {
        self.actions = actions
        self.targets = targets
        self.selectedPlans = selectedPlans.map { ($0.0, $0.0.plans[$0.1]) }
        items = self.selectedPlans.map { PlansListItemViewModel(plan: $0.1, channelName: $0.0.name) }
        targetsString = targets.map(\.title).joined(separator: ", ")
    }
    
    // MARK: - INPUT
    
    public func didTapSendEmail() {
        var message = "Selected targets: \(targets.map(\.title).joined(separator: ", "))\n"
        let channelMapper: ((Channel, Plan)) -> String = {
            "\t- \($0.0.name) (\($0.1.price)EUR): \($0.1.benefits.map(\.name).sorted { $0 < $1 }.joined(separator: ", "))"
        }
        message = message + "Selected channels: \n\(selectedPlans.map(channelMapper).joined(separator: "\n"))"
        actions.sendEmail("bogus@bogus.com", message)
    }
    
}
