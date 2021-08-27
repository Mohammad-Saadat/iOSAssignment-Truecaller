//
//  HomeModels.swift
//  iOSAssignment
//
//  Created by mohammadSaadat on 6/5/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Home {
    enum ErrorModel {
        struct Response {
            var error: Error
        }
        struct ViewModel {
            var error: Error
        }
    }
    
    enum Loading {
        struct Response {
            let tag: Int
            let hideLoadingOnButton: Bool
        }
        struct ViewModel {
            let tag: Int
            let hideLoadingOnButton: Bool
        }
    }
    
    enum Data {
        struct Response {
            let tag: Int
            let text: String?
        }
        struct ViewModel {
            let tag: Int
            let text: String
        }
    }
}
