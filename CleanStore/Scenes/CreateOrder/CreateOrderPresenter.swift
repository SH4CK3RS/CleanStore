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
    //MARK: - Update Order
    func presentUpdatedOrder(_ response: CreateOrder.UpdateOrder.Response) {
        let viewModel = CreateOrder.UpdateOrder.ViewModel(order: order)
        
    }
}
