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
    func formatExpirationDate(_ request: CreateOrder.FormatExpirationDate.Request)
}

protocol CreateOrderInteractorOutput{
    func presentExpirationDate(_ response: CreateOrder.FormatExpirationDate.Response)
}

class CreateOrderInteractor: CreateOrderInteractorInput{
    var output: CreateOrderInteractorOutput!
    var worker: CreateOrderWorker!
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
    
    
}
