//
//  CreateOrderConfigurator.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit
//MARK: ViewController, Interactor, Presenter를 연결한다.

extension CreateOrderViewController: CreateOrderPresenterOutput{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue: segue)
    }
}

extension CreateOrderInteractor: CreateOrderViewControllerOutput{
    
}
extension CreateOrderPresenter: CreateOrderInteractorOutput{
    
}

class CreateOrderConfigurator{
    //MARK: Object LifeCycle
    
    static var shared: CreateOrderConfigurator = CreateOrderConfigurator()
    
    // MARK: Configuration
    func configure(viewController: CreateOrderViewController){
        let router = CreateOrderRouter()
        router.viewController = viewController
        
        let presenter = CreateOrderPresenter()
        presenter.output = viewController
        
        let interactor = CreateOrderInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
}
