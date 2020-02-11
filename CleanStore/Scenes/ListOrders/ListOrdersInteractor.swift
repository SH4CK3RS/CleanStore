//
//  ListOrdersInteractor.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import Foundation

protocol ListOrdersBusinessLogic {
    func fetchOrders(request: ListOrders.FetchOrders.Request)
}

protocol ListOrdersDataStore{
    var orders: [Order]? { get }
}

class ListOrdersInteractor: ListOrdersBusinessLogic, ListOrdersDataStore{
    var presenter: ListOrdersPresentationLogic?
    var ordersWorker = OrdersWorker(orderStore: OrdersCoreDataStore.shared)
    var orders: [Order]?
    
    func fetchOrders(request: ListOrders.FetchOrders.Request) {
        ordersWorker.fetchOrders { orders in
            self.orders = orders
            let response = ListOrders.FetchOrders.Response(orders: orders)
            self.presenter?.presentFetchedOrders(response: response)
        }
    }
}
