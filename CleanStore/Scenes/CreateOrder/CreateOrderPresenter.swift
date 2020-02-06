//
//  CreateOrderPresenter.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

protocol CreateOrderPresentationLogic{
    func presentExpirationDate(_ response: CreateOrder.FormatExpirationDate.Response)
    func presentCreatedOrder(_ response: CreateOrder.CreateOrder.Response)
    func presentOrderToEdit(_ response: CreateOrder.EditOrder.Response)
    func presentUpdatedOrder(_ response: CreateOrder.UpdateOrder.Response)
}

class CreateOrderPresenter: CreateOrderPresentationLogic{
    weak var viewController: CreateOrderDisplayLogic?
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
    //MARK: - Expiration Date
    func presentExpirationDate(_ response: CreateOrder.FormatExpirationDate.Response){
        let date = dateFormatter.string(from: response.date)
        let viewModel = CreateOrder.FormatExpirationDate.ViewModel(date: date)
        viewController?.displayExpirationDate(viewModel)
    }
    //MARK: - CreateOrder
    func presentCreatedOrder(_ response: CreateOrder.CreateOrder.Response){
        let viewModel = CreateOrder.CreateOrder.ViewModel(order: response.order)
        viewController?.displayCreatedOrder(viewModel)
    }
    
    //MARK: Edit Order
    func presentOrderToEdit(_ response: CreateOrder.EditOrder.Response) {
        let orderToEdit = response.order
        let viewModel = CreateOrder.EditOrder.ViewModel(
          orderFormFields: CreateOrder.OrderFormFields(
            firstName: orderToEdit.firstName,
            lastName: orderToEdit.lastName,
            phone: orderToEdit.phone,
            email: orderToEdit.email,
            billingAddressStreet1: orderToEdit.billingAddress.street1,
            billingAddressStreet2: orderToEdit.billingAddress.street2,
            billingAddressCity: orderToEdit.billingAddress.city,
            billingAddressState: orderToEdit.billingAddress.state,
            billingAddressZIP: orderToEdit.billingAddress.zip,
            paymentMethodCreditCardNumber: orderToEdit.paymentMethod.creditCardNumber,
            paymentMethodCVV: orderToEdit.paymentMethod.cvv,
            paymentMethodExpirationDate: orderToEdit.paymentMethod.expirationDate,
            paymentMethodExpirationDateString: dateFormatter.string(from: orderToEdit.paymentMethod.expirationDate),
            shipmentAddressStreet1: orderToEdit.shipmentAddress.street1,
            shipmentAddressStreet2: orderToEdit.shipmentAddress.street2,
            shipmentAddressCity: orderToEdit.shipmentAddress.city,
            shipmentAddressState: orderToEdit.shipmentAddress.state,
            shipmentAddressZIP: orderToEdit.shipmentAddress.zip,
            shipmentMethodSpeed: orderToEdit.shipmentMethod.speed.rawValue,
            shipmentMethodSpeedString: orderToEdit.shipmentMethod.toString(),
            id: orderToEdit.id,
            date: orderToEdit.date,
            total: orderToEdit.total
          )
        )
        viewController?.displayOrderToEdit(viewModel)
    }
    //MARK: - Update Order
    func presentUpdatedOrder(_ response: CreateOrder.UpdateOrder.Response) {
        let viewModel = CreateOrder.UpdateOrder.ViewModel(order: response.order)
        viewController?.displayUpdatedOrder(viewModel)
    }
}
