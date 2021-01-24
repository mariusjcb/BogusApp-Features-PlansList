//
//  ChannelsListViewModel.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import Foundation
import BogusApp_Common_Models
import BogusApp_Common_Utils

public struct ChannelsListViewModelActions {
    public let showPlansSelector: (_ channel: Channel, _ plans: [Plan], @escaping (_ didSelect: Int) -> Void) -> Void
    public let showCampaignReview: (_ selectedTargets: [TargetSpecific], _ selectedPlans: [(Channel, Int)]) -> Void
    
    public init(showPlansSelector: @escaping (_ channel: Channel, _ plans: [Plan], @escaping (_ didSelect: Int) -> Void) -> Void,
                showCampaignReview: @escaping (_ selectedTargets: [TargetSpecific], _ selectedPlans: [(Channel, Int)]) -> Void) {
        self.showPlansSelector = showPlansSelector
        self.showCampaignReview = showCampaignReview
    }
}

public protocol ChannelsListViewModelInput {
    func didSelectItem(at index: Int)
    func didTapReset()
    func didTapNext()
}

public protocol ChannelsListViewModelOutput {
    var itemsObservable: Observable<[ChannelsListItemViewModel]> { get }
    var errorObservable: Observable<String> { get }
    var title: String { get }
}

public protocol ChannelsListViewModel: ChannelsListViewModelInput & ChannelsListViewModelOutput { }

public final class DefaultChannelsListViewModel: ChannelsListViewModel {
    
    private let actions: ChannelsListViewModelActions
    
    private var targets: [TargetSpecific]
    
    private let channels: [Channel]
    
    public let title = NSLocalizedString("Select channel...", comment: "")
    
    @Observable private var items: [ChannelsListItemViewModel] = []
    @Observable private var error: String = ""
    
    // MARK: - OUTPUT
    
    public var itemsObservable: Observable<[ChannelsListItemViewModel]> { _items }
    public var errorObservable: Observable<String> { _error }
    
    public init(targets: [TargetSpecific], actions: ChannelsListViewModelActions) {
        self.actions = actions
        self.targets = targets
        let tmpChannels = targets.map { $0.channels }
        let channelsSet = Set<Channel>(tmpChannels.first ?? [])
        channels = Array(tmpChannels.reduce(channelsSet) { $0.intersection($1) })
        items = channels.map(ChannelsListItemViewModel.init)
    }
    
    private func planSelectionHandler(for index: Int) -> (_ didSelect: Int) -> Void {
        return { [weak self] planIndex in
            guard let `self` = self else { return }
            guard index >= 0 && self.channels.count > index else { return }
            guard planIndex >= 0 && self.channels[index].plans.count > planIndex else { return }
            self.items[index].setSelectedPlan(self.channels[index].plans[planIndex], at: planIndex)
            let items = self.items
            self.items = items
        }
    }
    
    // MARK: - INPUT
    
    public func didTapReset() {
        items = items.map { item in
            item.removeSelectedPlan()
            return item
        }
    }
    
    public func didSelectItem(at index: Int) {
        guard items[index].selectedPlan == nil else {
            error = NSLocalizedString("Single selection allowed", comment: "")
            return
        }
        actions.showPlansSelector(channels[index], channels[index].plans, planSelectionHandler(for: index))
    }
    
    public func didTapNext() {
        let selectedPlans = items.enumerated()
            .map { (self.channels[$0.offset], $0.element.selectedPlanIndex) }
            .filter { $0.1 != nil }.map { ($0.0, $0.1!) }
        actions.showCampaignReview(targets, selectedPlans)
    }
    
}
