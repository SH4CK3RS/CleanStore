//
//  CreateOrderRouter.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

protocol CreateOrderRouterInput{
    func navigateToSomewhere()
}

class CreateOrderRouter: CreateOrderRouterInput{
    weak var viewController: CreateOrderViewController!
    
    //MARK: Navigation
    func navigateToSomewhere(){
        //NOTE: Router가 다른 씬을 어떤 방식으로 호출할지를 정의하는 메소드
    }
    
    //MARK: Communication
    func passDataToNextScene(segue: UIStoryboardSegue){
        // NOTE: router가 Communication가능한 씬을 정의
        if segue.identifier == "ShowSomewhereScene"{
            passDataToSomewhere(segue)
        }
    }
    
    func passDataToSomewhere(_ segue: UIStoryboardSegue){
        //NOTE: segue.identifier가 "ShowSomewhereScene"인 Scene에 대해 전달할 데이터를 이곳에서 처리
        
    }
    
}
