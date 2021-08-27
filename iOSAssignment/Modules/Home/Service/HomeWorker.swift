//
//  HomeWorker.swift
//  iOSAssignment
//
//  Created by mohammadSaadat on 6/5/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import PromiseKit

protocol HomeWorkerLogic {
    func getTenthChar() -> Promise<String?>
    func getEveryTenthChar() -> Promise<String?>
    func getWorlCounter() -> Promise<String?>
}

class HomeWorker {
    // MARK: - Object lifecycle
    init(service: HomeService) {
        HomeLogger.logInit(owner: String(describing: HomeWorker.self))
        self.service = service
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeWorker.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private let service: HomeService
}

// MARK: - Methods

// MARK: - Worker Logic
extension HomeWorker: HomeWorkerLogic {
    func getTenthChar() -> Promise<String?> {
        return service.getTenthChar()
    }
    
    func getEveryTenthChar() -> Promise<String?> {
        return service.getEveryTenthChar()
    }
    
    func getWorlCounter() -> Promise<String?> {
        return service.getWorlCounter()
    }
}
