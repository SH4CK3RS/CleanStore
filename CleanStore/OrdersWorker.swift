//
//  OrdersWorker.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import Foundation

class OrdersWorker{
    var orderStore: OrdersStoreProtocol
    init(orderStore: OrdersStoreProtocol){
        self.orderStore = orderStore
    }
    
    func fetchOrders(completionHandler: @escaping ([Order]) -> Void){
        
    }
    func createOrder(orderToCreate: Order, completionHandler: @escaping (Order?)-> Void){
        orderStore.createOrder(orderToCreate: orderToCreate) { (order: () throws -> Order?) -> Void in
            do{
                let order = try order()
                DispatchQueue.main.async {
                    completionHandler(order)
                }
            }catch{
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
            }
        }
    }
    func updateOrder(orderToUpdate: Order, completionHandler: @escaping (Order?)->Void){
        
    }
}

//MARK: - Orders store API
protocol OrdersStoreProtocol{
    //MARK: CRUD operations - Optional Error
    func fetchOrders(completionHandler: @escaping ([Order], OrderStoreError?) -> Void)
    func fetchOrder(completionHandler: @escaping (Order?, OrderStoreError?) -> Void)
    func createOrder(orderToCreate: Order, completionHandler: @escaping (Order?, OrderStoreError?) -> Void)
    func updateOrder(orderToUpdate: Order, completionHandler: @escaping (Order?, OrderStoreError?) -> Void)
    func deleteOrder(id: String, completionHandler: @escaping (Order?, OrderStoreError?) -> Void)
    
    //MARK: CRUD operations - Generic enum result type
    func fetchOrders(completionHandler: @escaping OrdersStoreFetchOrdersCompletionHandler)
    func fetchOrder(completionHandler: @escaping OrdersStoreFetchOrderCompletionHandler)
    func createOrder(orderToCreate: Order, completionHandler: @escaping OrdersStoreCreateOrderCompletionHandler)
    func updateOrder(orderToUpdate: Order, completionHandler: @escaping OrdersStoreUpdateOrderCompletionHandler)
    func deleteOrder(id: String, completionHandler: @escaping OrdersStoreDeleteOrderCompletionHandler)
    
    //MARK: CRUD operations - Inner closure
    func fetchOrders(completionHandler: @escaping (() throws -> [Order]) -> Void)
    func fetchOrder(id: String, completionHandler: @escaping (() throws -> Order?) -> Void)
    func createOrder(orderToCreate: Order, completionHandler: @escaping (() throws -> Order?) -> Void)
    func updateOrder(orderToUpdate: Order, completionHandler: @escaping (() throws -> Order?) -> Void)
    func deleteOrder(id: String, completionHandler: @escaping (() throws -> Order?) -> Void)
}

protocol OrderStoreUtilityProtocol {}

extension OrderStoreUtilityProtocol{
    func generateOrderID(order: inout Order){
        guard order.id == nil else { return }
        order.id = "\(arc4random())"
    }
    func calculateOrderTotal(order: inout Order){
        guard order.total == NSDecimalNumber.notANumber else { return }
        order.total = NSDecimalNumber.one
    }
    
}

//MARK: - Orders store CRUD operation results

typealias OrdersStoreFetchOrdersCompletionHandler = (OrdersStoreResult<[Order]>) -> Void
typealias OrdersStoreFetchOrderCompletionHandler = (OrdersStoreResult<Order>) -> Void
typealias OrdersStoreCreateOrderCompletionHandler = (OrdersStoreResult<Order>) -> Void
typealias OrdersStoreUpdateOrderCompletionHandler = (OrdersStoreResult<Order>) -> Void
typealias OrdersStoreDeleteOrderCompletionHandler = (OrdersStoreResult<Order>) -> Void

enum OrdersStoreResult<U>{
    case Success(result: U)
    case Failure(error: OrderStoreError)
}


enum OrderStoreError: Equatable, Error{
    case CannotFetch(String)
    case CannotCreate(String)
    case CannotUpdate(String)
    case CannotDelete(String)
}
func ==(lhs: OrderStoreError, rhs: OrderStoreError) -> Bool {
    switch(lhs, rhs){
    case (.CannotFetch(let a), .CannotFetch(let b)) where a == b: return true
    case (.CannotCreate(let a), .CannotCreate(let b)) where a == b: return true
    case (.CannotUpdate(let a), .CannotUpdate(let b)) where a == b: return true
    case (.CannotDelete(let a), .CannotDelete(let b)) where a == b: return true
    default: return false
    }
}
