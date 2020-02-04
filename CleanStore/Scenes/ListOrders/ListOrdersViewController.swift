//
//  ListOrderViewController.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

protocol ListOrdersDisplayLogic: class{
    func displayFetchedOrders(viewModel: ListOrders.FetchOrders.ViewModel)
}

class ListOrdersViewController: UITableViewController, ListOrdersDisplayLogic{
    
    var interactor: ListOrdersBusinessLogic?
    var router: (NSObjectProtocol & ListOrdersRoutingLogic & ListOrdersDataPassing)?
    
    //MARK: - Object LifeCycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
      super.init(coder: aDecoder)
      setup()
    }
    
    private func setup(){
        let viewController = self
        let interactor = ListOrdersInteractor()
        let presenter = ListOrdersPresenter()
        let router = ListOrdersRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    //MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier{
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector){
                router.perform(selector, with: segue)
            }
        }
    }
    
    //MARK: - View LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchOrders()
    }
    
    
    //MARK: - Fetch orders
    var displayOrders: [ListOrders.FetchOrders.ViewModel.DisplayedOrder] = []
    
    func fetchOrders(){
        let request = ListOrders.FetchOrders.Request()
        interactor?.fetchOrders(request: request)
    }
    
    func displayFetchedOrders(viewModel: ListOrders.FetchOrders.ViewModel) {
        displayOrders = viewModel.displayedOrders
        tableView.reloadData()
    }
    
    //MARK: - TableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayOrders.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayOrder = displayOrders[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell")
        if cell == nil{
            cell = UITableViewCell(style: .value1, reuseIdentifier: "OrderTableViewCell")
        }
        cell?.textLabel?.text = displayOrder.date
        cell?.detailTextLabel?.text = displayOrder.total
        return cell!
    }
}
