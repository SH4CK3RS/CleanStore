//
//  CreateOrderInteractor.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

protocol CreateOrderInteractorInput{
    var shippingMethods: [String] { get }
    var orderToEdit: Order? { get }
    func formatExpirationDate(_ request: CreateOrder.FormatExpirationDate.Request)
    func createOrder(_ request: CreateOrder.CreateOrder.Request)
}

protocol CreateOrderInteractorOutput{
    func presentExpirationDate(_ response: CreateOrder.FormatExpirationDate.Response)
    func presentCreatedOrder(_ response: CreateOrder.CreateOrder.Response)
}

protocol CreateOrderDataSource{
    var orderToEdit: Order? { get set }
}

class CreateOrderInteractor: CreateOrderInteractorInput{
    var output: CreateOrderInteractorOutput!
    var ordersWorker: OrdersWorker!
    var orderToEdit: Order?
    
    var shippingMethods = [
        "Standard Shipping",
        "Two-Day Shipping",
        "One-Day Shipping"
    ]
    //MARK: Business Logic
    func formatExpirationDate(_ request: CreateOrder.FormatExpirationDate.Request){
        let response = CreateOrder.FormatExpirationDate.Response(date: request.date)
        output.presentExpirationDate(response)
    }
    
    //MARK: Create Order
    func createOrder(_ request: CreateOrder.CreateOrder.Request){
        let orderToCreate = buildOrderFromOrderFormFrelds(request.orderFormFields)
        ordersWorker.createOrder(orderToCreate: orderToCreate) { order in
            self.orderToEdit = order
            let response = CreateOrder.CreateOrder.Response(order: order)
            self.output.presentCreatedOrder(response)
        }
    }
    
    
    //MARK: Helper Function
    
    private func buildOrderFromOrderFormFrelds(_ orderFormFields: CreateOrder.OrderFormFields) -> Order{
        let billingAddress = Address(street1: orderFormFields.billingAddressStreet1, street2: orderFormFields.billingAddressStreet2, city: orderFormFields.billingAddressCity, state: orderFormFields.billingAddressState, zip: orderFormFields.billingAddressZIP)
        
        let paymentMethod = PaymentMethod(creditCardNumber: orderFormFields.paymentMethodCreditCardNumber, expirationDate: orderFormFields.paymentMethodExpirationDate, cvv: orderFormFields.paymentMethodExpirationDateString)
        
        let shipmentAddress = Address(street1: orderFormFields.shipmentAddressStreet1, street2: orderFormFields.shipmentAddressStreet2, city: orderFormFields.shipmentAddressCity, state: orderFormFields.shipmentAddressState, zip: orderFormFields.shipmentAddressZIP)
        
        let shipmentMethod = ShipmentMethod(speed: ShipmentMethod.ShipmentSpeed(rawValue: orderFormFields.shipmentMethodSpeed)!)
        
        return Order(firstName: orderFormFields.firstName, lastName: orderFormFields.lastName, phone: orderFormFields.phone, email: orderFormFields.email, billingAddress: billingAddress, paymentMethod: paymentMethod, shipmentAddress: shipmentAddress, shipmentMehtod: shipmentMethod, id: orderFormFields.id, date: orderFormFields.date, total: orderFormFields.total)
    }
}
