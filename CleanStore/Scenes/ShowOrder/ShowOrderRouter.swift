//
//  ShowOrderRouter.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/05.
//  Copyright © 2020 손병근. All rights reserved.
//

import Foundation

@objc protocol ShowOrderRoutingLogic{
    
}

protocol ShowOrderDataPassing{
    var dataStore: ShowOrderDataStore? { get }
}

class ShowOrderRouter: NSObject, ShowOrderRoutingLogic, ShowOrderDataPassing{
    weak var viewController: ShowOrderViewController?
    var dataStore: ShowOrderDataStore?
}
