//
//  ShowOrderViewController.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/05.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

protocol ShowOrderDisplayLogic: class{
    func displayOrder(_ viewModel: ShowOrder.GetOrder.ViewModel)
}

class ShowOrderViewController: UIViewController, ShowOrderDisplayLogic{
    var interactor: ShowOrderBusinessLogic?
    var router: (NSObjectProtocol & ShowOrderRoutingLogic & ShowOrderDataPassing)?
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        let viewController = self
        let interactor = ShowOrderInteractor()
        let presenter = ShowOrderPresenter()
        let router = ShowOrderRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getOrder()
    }
    
    //MARK: - Get Order
    
    @IBOutlet weak var orderIDLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderEmailLabel: UILabel!
    @IBOutlet weak var orderNameLabel: UILabel!
    @IBOutlet weak var orderTotalLabel: UILabel!
    
    func getOrder(){
        let request = ShowOrder.GetOrder.Request()
        interactor?.getOrder(request)
    }
    
    func displayOrder(_ viewModel: ShowOrder.GetOrder.ViewModel) {
        let displayedOrder = viewModel.displayedOrder
        orderIDLabel.text = displayedOrder.id
        orderDateLabel.text = displayedOrder.date
        orderEmailLabel.text = displayedOrder.email
        orderNameLabel.text = displayedOrder.name
        orderTotalLabel.text = displayedOrder.total
    }
    
}
