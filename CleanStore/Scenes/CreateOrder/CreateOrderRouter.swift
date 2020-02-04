//
//  CreateOrderRouter.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

@objc protocol CreateOrderRoutingLogic{
    func routeToListOrders(segue: UIStoryboardSegue?)
//    func routeToShowOrder(seuge: UIStoryboardSegue?)
}

protocol CreateOrderDataPassing {
    var dataStore: CreateOrderDataStore? { get }
}

protocol CreateOrderRouterInput{
    func navigateToSomewhere()
}

class CreateOrderRouter: NSObject, CreateOrderRoutingLogic, CreateOrderDataPassing{
    weak var viewController: CreateOrderViewController?
    var dataStore: CreateOrderDataStore?
    
    //MARK: Routing
    
    func routeToListOrders(segue: UIStoryboardSegue?) {
        if let segue = segue{
            let destinationVC = segue.destination as! ListOrdersViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToListOrders(source: dataStore!, destination: &destinationDS)
        }else{
            let index = viewController!.navigationController!.viewControllers.count - 2
            let destinationVC = viewController?.navigationController?.viewControllers[index] as! ListOrdersViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToListOrders(source: dataStore!, destination: &destinationDS)
            navigationToListOrders(source: viewController!, destination: destinationVC)
        }
    }
    
    //MARK: Navigation
    
    func navigationToListOrders(source: CreateOrderViewController, destination: ListOrdersViewController){
        source.navigationController?.popViewController(animated: true)
    }
    
    func passDataToListOrders(source: CreateOrderDataStore, destination: inout ListOrdersDataStore){
        
    }
}
