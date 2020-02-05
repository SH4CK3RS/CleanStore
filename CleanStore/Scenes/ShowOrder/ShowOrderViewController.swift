//
//  ShowOrderViewController.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/05.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

protocol ShowOrderDisplayLogic{
    
}

class ShowOrderViewController: UIViewController, ShowOrderDisplayLogic{
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        
    }
    
    //MARK: - Get Order
    
    @IBOutlet weak var orderIDLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderEmailLabel: UILabel!
    @IBOutlet weak var orderNameLabel: UILabel!
    @IBOutlet weak var orderTotalLabel: UILabel!
    
    
}
