//
//  ShowOrderInteractor.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/05.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

protocol ShowOrderBusinessLogic{
    func getOrder(_ request: ShowOrder.GetOrder.Request)
}
protocol ShowOrderDataStore{
    var order: Order! { get set }
}
class ShowOrderInteractor: ShowOrderBusinessLogic, ShowOrderDataStore{
    var presenter: ShowOrderPresentationLogic?
    var order: Order!
    
    // MARK: Get Order
    func getOrder(_ request: ShowOrder.GetOrder.Request) {
        let response = ShowOrder.GetOrder.Response(order: order)
        presenter?.presentOrder(response)
    }
    
}
