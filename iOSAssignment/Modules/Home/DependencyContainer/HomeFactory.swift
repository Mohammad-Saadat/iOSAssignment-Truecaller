//
//  HomeFactory.swift
//  iOSAssignment
//
//  Created by mohammadSaadat on 6/5/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

typealias HomeFactory = HomeViewControllerFactory & HomeServiceFactory

protocol HomeViewControllerFactory {
    func makeHomeViewController() -> HomeViewController
    func setup(viewController: HomeViewController)
}

protocol HomeServiceFactory {
    func makeHomeService() -> HomeService
}
