//
//  HomeService.swift
//  iOSAssignment
//
//  Created by mohammadSaadat on 6/5/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import PromiseKit

final class HomeService {
    // MARK: - Object lifecycle
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        HomeLogger.logInit(owner: String(describing: HomeService.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeService.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private let networkManager: NetworkManagerProtocol
}

// MARK: - Methods

// MARK: Public
extension HomeService {
    func getTenthChar() -> Promise<String?> {
        return networkManager
            .requestData(HomeEndpoint.tenthChar)
            .map { String(data: $0, encoding: .utf8) }
            .recover(NetworkErrors.parseError)
    }
    
    func getEveryTenthChar() -> Promise<String?> {
        return networkManager
            .requestData(HomeEndpoint.everyTenthChar)
            .map { String(data: $0, encoding: .utf8) }
            .recover(NetworkErrors.parseError)
    }
    
    func getWorlCounter() -> Promise<String?> {
        return networkManager
            .requestData(HomeEndpoint.worlCounter)
            .map { String(data: $0, encoding: .utf8) }
            .recover(NetworkErrors.parseError)
    }
}
