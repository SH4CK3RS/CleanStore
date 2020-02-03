//
//  CreateOrderPresenter.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

protocol CreateOrderPresenterInput{
    func presentSomething(_ response: CreateOrderResponse)
}

protocol CreateOrderPresenterOutput: class {
    func displaySomething(_ viewModel: CreateOrderViewModel)
}

class CreateOrderPresenter: CreateOrderPresenterInput{
    weak var output: CreateOrderPresenterOutput!
    
    //MARK: Presentation Logic
    
    func presentSomething(_ response: CreateOrderResponse){
        //NOTE: Interactor로부터 받은 response를 가공하여 result 객체 생성 후 ViewController로 보내 화면을 그리도록 함
        let viewModel = CreateOrderViewModel()
        output.displaySomething(viewModel)
    }
    
}
