//
//  ListOrdersRouter.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

@objc protocol ListOrdersRoutingLogic {
    func routeToCreateOrder(segue: UIStoryboardSegue?)
    func routeToShowOrder(segue: UIStoryboardSegue?)
}

protocol ListOrdersDataPassing{
    var dataStore: ListOrdersDataStore? { get }
}

class ListOrdersRouter: NSObject, ListOrdersRoutingLogic, ListOrdersDataPassing{
    weak var viewController: ListOrdersViewController?
    var dataStore: ListOrdersDataStore?
    
    //MARK: Routing
    
    func routeToCreateOrder(segue: UIStoryboardSegue?) {
        if let segue = segue{
            let destinationVC = segue.destination as! CreateOrderViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToCreateOrder(source: dataStore!, destination: &destinationDS)
        }else{
            let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "CreateOrderViewController") as! CreateOrderViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToCreateOrder(source: dataStore!, destination: &destinationDS)
            navigateToCreateOrder(source: viewController!, destination: destinationVC)
        }
    }
    func routeToShowOrder(segue: UIStoryboardSegue?) {
        
    }
    
    func navigateToCreateOrder(source: ListOrdersViewController, destination: CreateOrderViewController){
        source.show(destination, sender: nil)
    }
    
    func passDataToCreateOrder(source: ListOrdersDataStore, destination: inout CreateOrderDataStore){
        
    }
}
