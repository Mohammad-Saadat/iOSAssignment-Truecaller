//
//  HomeDependencyContainer.swift
//  iOSAssignment
//
//  Created by mohammadSaadat on 6/5/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class HomeDependencyContainer: DependencyContainer {
    // MARK: - Object lifecycle
    override init() {
        HomeLogger.logInit(owner: String(describing: HomeDependencyContainer.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeDependencyContainer.self))
    }
}

// MARK: - Factory
extension HomeDependencyContainer: HomeFactory {
    func setup(viewController: HomeViewController) {
        guard viewController.interactor == nil else { return }
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        let worker = HomeWorker(service: makeHomeService())
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func makeHomeViewController() -> HomeViewController {
        return HomeViewController(factory: self)
    }
    
    func makeHomeService() -> HomeService {
        return HomeService(networkManager: networkManager)
    }
}
