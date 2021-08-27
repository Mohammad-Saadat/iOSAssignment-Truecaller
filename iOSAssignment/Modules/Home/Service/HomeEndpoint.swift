//
//  HomeEndpoint.swift
//  iOSAssignment
//
//  Created by mohammadSaadat on 6/5/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

enum HomeEndpoint {
    case tenthChar
    case everyTenthChar
    case worlCounter
}

extension HomeEndpoint: RequestProtocol {
    
    public var relativePath: String {
        return "/2018/03/15/how-to-become-an-ios-developer/"
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var requestType: RequestType {
        return .requestPlain
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var authorizationType: AuthType {
        return .none
    }
}
