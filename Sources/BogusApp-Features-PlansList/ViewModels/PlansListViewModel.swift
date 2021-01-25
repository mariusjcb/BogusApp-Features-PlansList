//
//  PlansListViewModel.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import Foundation
import BogusApp_Common_Models
import BogusApp_Common_Utils

public protocol PlansListViewModelInput {
    var didSelect: ((Int) -> Void)? { get set }
    func didSelectItem(at index: Int)
}

public protocol PlansListViewModelOutput {
    var itemsObservable: Observable<[PlansListItemViewModel]> { get }
}

public protocol PlansListViewModel: PlansListViewModelInput & PlansListViewModelOutput { }

public final class DefaultPlansListViewModel: PlansListViewModel {

    private let channel: Channel

    private let plans: [Plan]

    public var didSelect: ((Int) -> Void)?

    @Observable private var items: [PlansListItemViewModel] = []

    // MARK: - OUTPUT

    public var itemsObservable: Observable<[PlansListItemViewModel]> { _items }

    public init(for channel: Channel, plans: [Plan], didSelect: ((Int) -> Void)? = nil) {
        self.channel = channel
        self.plans = plans
        self.didSelect = didSelect
        items = plans.map { PlansListItemViewModel(plan: $0, channelName: channel.name) }
    }

    // MARK: - INPUT

    public func didSelectItem(at index: Int) {
        didSelect?(index)
    }

}
