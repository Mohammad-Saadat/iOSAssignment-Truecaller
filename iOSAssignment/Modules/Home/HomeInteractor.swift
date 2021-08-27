//
//  HomeInteractor.swift
//  iOSAssignment
//
//  Created by mohammadSaadat on 6/5/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func fetchData()
}

protocol HomeDataStore {}

class HomeInteractor: HomeDataStore {
    // MARK: - Object lifecycle
    init() {
        HomeLogger.logInit(owner: String(describing: HomeInteractor.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeInteractor.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    var presenter: HomePresentationLogic?
    var worker: HomeWorkerLogic?
    
    private var textViewLoadingNumber: Int = 0
}

// MARK: - Methods

// MARK: Private
private extension HomeInteractor {
    func presentError(_ error: Error) {
        self.presenter?.presentError(response: .init(error: error))
    }
    
    func hideLoadings(textViewTag: Int) {
        textViewLoadingNumber -= 1
        let hideLoadingOnButton = textViewLoadingNumber == 0
        self.presenter?.hideLoading(response: .init(tag: textViewTag, hideLoadingOnButton: hideLoadingOnButton))
    }
    
    func dataFetched(data: String?, textViewTag: Int) {
        self.presenter?.presentData(response: .init(tag: textViewTag, text: data))
    }
    
    func TenthCharRequest() {
        worker?.getTenthChar()
            .done { self.dataFetched(data: $0, textViewTag: 0) }
            .catch(presentError)
            .finally {  self.hideLoadings(textViewTag: 0) }
    }
    
    func EveryTenthCharRequest() {
        worker?.getTenthChar()
            .done { self.dataFetched(data: $0, textViewTag: 1) }
            .catch(presentError)
            .finally {  self.hideLoadings(textViewTag: 1) }
    }
    
    func WordCounterRequest() {
        worker?.getTenthChar()
            .done { self.dataFetched(data: $0, textViewTag: 2) }
            .catch(presentError)
            .finally {  self.hideLoadings(textViewTag: 2) }
    }
}

// MARK: Public
extension HomeInteractor {}

// MARK: - Business Logics
extension HomeInteractor: HomeBusinessLogic {
    func fetchData() {
        presenter?.showLoading()
        textViewLoadingNumber = 3
        TenthCharRequest()
        EveryTenthCharRequest()
        WordCounterRequest()
    }
}
