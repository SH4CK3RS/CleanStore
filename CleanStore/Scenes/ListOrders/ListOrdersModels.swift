//
//  ListOrderModel.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

enum ListOrders{
    enum FetchOrders{
        struct Request{
            
        }
        struct Response{
            var orders: [Order]
        }
        struct ViewModel{
            struct DisplayedOrder{
                var id: String
                var date: String
                var email: String
                var name: String
                var total: String
            }
            var displayedOrders: [DisplayedOrder]
        }
    }
}

