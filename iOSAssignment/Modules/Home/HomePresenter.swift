//
//  HomePresenter.swift
//  iOSAssignment
//
//  Created by mohammadSaadat on 6/5/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func showLoading()
    func hideLoading(response: Home.Loading.Response)
    func presentData(response: Home.Data.Response)
    func presentError(response: Home.ErrorModel.Response)
}

class HomePresenter {
    // MARK: - Object lifecycle
    init() {
        HomeLogger.logInit(owner: String(describing: HomePresenter.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomePresenter.self))
    }
    
    // MARK: - Properties
    
    // MARK: Public
    weak var viewController: HomeDisplayLogic?
}

// MARK: - Methods

// MARK: Private
private extension HomePresenter {
    func guaranteeMainThread(_ work: @escaping (() -> Void)) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async(execute: work)
        }
    }
    
    func getNthChar(input: String, n: Int) -> String {
        let index = input.index(input.startIndex, offsetBy: n)
        if n < input.count  {
            return "\(n)th character : \(input[index])"
        }
        return ""
    }
    
    func getEveryTenthChar(input: String, tag: Int) {
        DispatchQueue.global(qos: .userInitiated).async {
            var result = ""
            let n = 10
            for i in 1...(input.count/n) {
                print("i is = \(i)")
                print("isMainThread = \(Thread.current.isMainThread)")
                result += self.getNthChar(input: input, n: i*n)
            }
            let viewModel = Home.Data.ViewModel(tag: tag, text: result)
            self.guaranteeMainThread {
                self.viewController?.displayData(viewModel: viewModel)
            }
        }
    }
    
    func getWordCounter(input: String, tag: Int) {
        DispatchQueue.global(qos: .userInitiated).async {
            let array = input.components(separatedBy: " ")
            var dictInfo = [String: Int]()
            for string in array {
                print("string is = \(string)")
                print("isMainThread = \(Thread.current.isMainThread)")
                let current = string.lowercased()
                if let value = dictInfo[current] {
                    dictInfo[current] = value + 1
                } else {
                    dictInfo[current] = 1
                }
            }
            let viewModel = Home.Data.ViewModel(tag: tag, text: dictInfo.description)
            self.guaranteeMainThread {
                self.viewController?.displayData(viewModel: viewModel)
            }
        }
    }
}

// MARK: Public
extension HomePresenter {}

// MARK: - Presentation Logic
extension HomePresenter: HomePresentationLogic {
    func showLoading() {
        guaranteeMainThread {
            self.viewController?.showLoading()
        }
    }
    
    func hideLoading(response: Home.Loading.Response) {
        guaranteeMainThread {
            self.viewController?.hideLoading(viewModel: .init(tag: response.tag, hideLoadingOnButton: response.hideLoadingOnButton))
        }
    }
    
    func presentData(response: Home.Data.Response) {
        guard let text = response.text else { return }
        //        var test = text.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        switch response.tag {
        case 0:
            let viewModel: Home.Data.ViewModel
            let string = getNthChar(input: text, n: 10)
            viewModel = .init(tag: response.tag, text: string)
            guaranteeMainThread {
                self.viewController?.displayData(viewModel: viewModel)
            }
        case 1:
            getEveryTenthChar(input: text, tag: response.tag)
        case 2:
            getWordCounter(input: text, tag: response.tag)
        default:
            return
        }
    }
    
    func presentError(response: Home.ErrorModel.Response) {
        guaranteeMainThread {
            self.viewController?.displayError(viewModel: .init(error: response.error))
        }
    }
}
