//
//  ShowOrderRouter.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/05.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

@objc protocol ShowOrderRoutingLogic{
    func routeToEditOrder(segue: UIStoryboardSegue?)
}

protocol ShowOrderDataPassing{
    var dataStore: ShowOrderDataStore? { get }
}

class ShowOrderRouter: NSObject, ShowOrderRoutingLogic, ShowOrderDataPassing{
    weak var viewController: ShowOrderViewController?
    var dataStore: ShowOrderDataStore?
    
    //MARK: - Routing
    func routeToEditOrder(segue: UIStoryboardSegue?) {
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
    
    //MARK: Navigation Logic
    func navigateToCreateOrder(source: ShowOrderViewController, destination: CreateOrderViewController){
        source.show(destination, sender: nil)
    }
    
    //MARK: Passing Data
    func passDataToCreateOrder(source: ShowOrderDataStore, destination: inout CreateOrderDataStore){
        destination.orderToEdit = source.order
    }
}
