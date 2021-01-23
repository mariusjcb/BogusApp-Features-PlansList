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
    public let showChannelsForSelectedTarget: (_ selectedTargets: [TargetSpecific]) -> Void
    
    public init(showChannelsForSelectedTarget: @escaping ([TargetSpecific]) -> Void) {
        self.showChannelsForSelectedTarget = showChannelsForSelectedTarget
    }
}

public protocol ChannelsListViewModelInput {
    func didSelectItem(at index: Int)
    func didTapNext()
}

public protocol ChannelsListViewModelOutput {
    var itemsObservable: Observable<[ChannelsListItemViewModel]> { get }
    var loadingObservable: Observable<Bool> { get }
    var errorObservable: Observable<String> { get }
    var title: String { get }
}

public protocol ChannelsListViewModel: ChannelsListViewModelInput & ChannelsListViewModelOutput { }

public final class DefaultChannelsListViewModel: ChannelsListViewModel {
    
    private let fetchChannelsListUseCase: FetchChannelsListUseCase
    private let actions: ChannelsListViewModelActions
    
    private var channels: [TargetSpecific] = [] {
        didSet { items = channels.map(ChannelsListItemViewModel.init) }
    }
    
    public let title = NSLocalizedString("Select specifics...", comment: "")
    
    @Observable private var items: [ChannelsListItemViewModel] = []
    @Observable private var loading: Bool = false
    @Observable private var error: String = ""
    
    // MARK: - OUTPUT
    
    public var itemsObservable: Observable<[ChannelsListItemViewModel]> { _items }
    public var loadingObservable: Observable<Bool> { _loading }
    public var errorObservable: Observable<String> { _error }
    
    public init(fetchChannelsListUseCase: FetchChannelsListUseCase, actions: ChannelsListViewModelActions) {
        self.fetchChannelsListUseCase = fetchChannelsListUseCase
        self.actions = actions
        
        fetchTargets()
    }
    
    private func fetchTargets(ids: [UUID] = []) {
        loading = true
        fetchChannelsListUseCase.fetchTargets(ids: ids) { result in
            switch result {
            case .success(let channels):
                self.channels = channels
            case .failure(let error):
                self.error = NSLocalizedString("Failed loading", comment: "") + " [\(error.localizedDescription)]"
            }
            self.loading = false
        }
    }
    
    // MARK: - INPUT
    
    public func didSelectItem(at index: Int) {
        items[index].selected = true
    }
    
    public func didTapNext() {
        let channels = self.items.enumerated().filter { $0.element.selected }.map { self.channels[$0.offset] }
        actions.showChannelsForSelectedTarget(channels)
    }
    
}
