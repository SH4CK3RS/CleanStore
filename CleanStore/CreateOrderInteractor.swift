//
//  CreateOrderInteractor.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

protocol CreateOrderInteractorInput{
    func doSomething(_ request: CreateOrderRequest)
}

protocol CreateOrderInteractorOutput{
    func presentSomething(_ response: CreateOrderResponse)
}

class CreateOrderInteractor: CreateOrderInteractorInput{
    var output: CreateOrderInteractorOutput!
    var worker: CreateOrderWorker!
    
    //MARK: Business Logic
    
    func doSomething(_ request: CreateOrderRequest){
        worker = CreateOrderWorker()
        worker.doSomeWork()

        let response = CreateOrderResponse()
        output.presentSomething(response)
    }
    
    
}
