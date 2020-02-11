//
//  CreateOrderInteractor.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

protocol CreateOrderBusinessLogic{
    var shippingMethods: [String] { get }
    var orderToEdit: Order? { get }
    func formatExpirationDate(_ request: CreateOrder.FormatExpirationDate.Request)
    func createOrder(_ request: CreateOrder.CreateOrder.Request)
    func showOrderToEdit(_ request: CreateOrder.EditOrder.Request)
    func updateOrder(_ request: CreateOrder.UpdateOrder.Request)
}

protocol CreateOrderDataStore{
    var orderToEdit: Order? { get set }
}

class CreateOrderInteractor: CreateOrderBusinessLogic, CreateOrderDataStore{
    var presenter: CreateOrderPresentationLogic!
    var ordersWorker = OrdersWorker(orderStore: OrdersCoreDataStore.shared)
    var orderToEdit: Order?
    
    var shippingMethods = [
        "Standard Shipping",
        "Two-Day Shipping",
        "One-Day Shipping"
    ]
    //MARK: - Expiration Date
    func formatExpirationDate(_ request: CreateOrder.FormatExpirationDate.Request){
        let response = CreateOrder.FormatExpirationDate.Response(date: request.date)
        presenter.presentExpirationDate(response)
    }
    
    //MARK: - Create Order
    func createOrder(_ request: CreateOrder.CreateOrder.Request){
        let orderToCreate = buildOrderFromOrderFormFrelds(request.orderFormFields)
        ordersWorker.createOrder(orderToCreate: orderToCreate) { order in
            self.orderToEdit = order
            let response = CreateOrder.CreateOrder.Response(order: order)
            self.presenter.presentCreatedOrder(response)
        }
    }
    
    //MARK: Edit Order
    func showOrderToEdit(_ request: CreateOrder.EditOrder.Request) {
        if let orderToEdit = orderToEdit{
            let response = CreateOrder.EditOrder.Response(order: orderToEdit)
            presenter.presentOrderToEdit(response)
        }
    }
    
    //MARK: Update Order
    func updateOrder(_ request: CreateOrder.UpdateOrder.Request) {
        let orderToUpdate = buildOrderFromOrderFormFrelds(request.orderFormFields)
        ordersWorker.updateOrder(orderToUpdate: orderToUpdate) { order in
            self.orderToEdit = order
            let response = CreateOrder.UpdateOrder.Response(order: order)
            self.presenter.presentUpdatedOrder(response)
        }
    }
    
    //MARK: Helper Function
    
    private func buildOrderFromOrderFormFrelds(_ orderFormFields: CreateOrder.OrderFormFields) -> Order{
        let billingAddress = Address(street1: orderFormFields.billingAddressStreet1, street2: orderFormFields.billingAddressStreet2, city: orderFormFields.billingAddressCity, state: orderFormFields.billingAddressState, zip: orderFormFields.billingAddressZIP)
        
        let paymentMethod = PaymentMethod(creditCardNumber: orderFormFields.paymentMethodCreditCardNumber, expirationDate: orderFormFields.paymentMethodExpirationDate, cvv: orderFormFields.paymentMethodExpirationDateString)
        
        let shipmentAddress = Address(street1: orderFormFields.shipmentAddressStreet1, street2: orderFormFields.shipmentAddressStreet2, city: orderFormFields.shipmentAddressCity, state: orderFormFields.shipmentAddressState, zip: orderFormFields.shipmentAddressZIP)
        
        let shipmentMethod = ShipmentMethod(speed: ShipmentMethod.ShipmentSpeed(rawValue: orderFormFields.shipmentMethodSpeed)!)
        
        return Order(firstName: orderFormFields.firstName, lastName: orderFormFields.lastName, phone: orderFormFields.phone, email: orderFormFields.email, billingAddress: billingAddress, paymentMethod: paymentMethod, shipmentAddress: shipmentAddress, shipmentMethod: shipmentMethod, id: orderFormFields.id, date: orderFormFields.date, total: orderFormFields.total)
    }
}
