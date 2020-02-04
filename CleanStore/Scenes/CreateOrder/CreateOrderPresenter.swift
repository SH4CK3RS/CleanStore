//
//  CreateOrderPresenter.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

protocol CreateOrderPresenterInput{
    func presentExpirationDate(_ response: CreateOrder.FormatExpirationDate.Response)
    func presentCreatedOrder(_ response: CreateOrder.CreateOrder.Response)
}

protocol CreateOrderPresenterOutput: class {
    func displayExpirationDate(_ viewModel: CreateOrder.FormatExpirationDate.ViewModel)
    func displayCreatedOrder(_ viewModel: CreateOrder.CreateOrder.ViewModel)
}

class CreateOrderPresenter: CreateOrderPresenterInput{
    weak var output: CreateOrderPresenterOutput!
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
        output.displayExpirationDate(viewModel)
    }
    //MARK: - CreateOrder
    func presentCreatedOrder(_ response: CreateOrder.CreateOrder.Response){
        let viewModel = CreateOrder.CreateOrder.ViewModel(order: response.order)
        output.displayCreatedOrder(viewModel)
    }
}
