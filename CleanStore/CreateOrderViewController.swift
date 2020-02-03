//
//  ViewController.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

protocol CreateOrderViewControllerInput{
//    func displaySomething(viewModel: CreateOrderViewModel)
}
protocol CreateOrderViewControllerOutput{
//    func doSomething(request: CreateOrderRequest)
}

class CreateOrderViewController: UITableViewController, CreateOrderViewControllerInput  {
    var output: CreateOrderViewControllerOutput!
//    var router: CreateOrderRouter
    
    //MARK: Object LifeCycle
    
    override class func awakeFromNib() {
        super.awakeFromNib()
//        CreateOrderConfigurator.shared.configure(self)
    }
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        doSomethingOnLoad()
    }

    //MARK: Event Handling
    func doSomethingOnLoad(){
        // NOTE: Interactor에 특정 작업 요청
        
//        let request = CreateOrderRequest()
//        output.doSomething(request)
    }
    
    //MARK: Display Logic
//    func displaySomething(viewModel: CreateOrderViewModel){
//         NOTE: Presenter로부터 받은 result를 통해 화면 구성
//
//        nameTextField.text = viewModel.name
//    }
}

