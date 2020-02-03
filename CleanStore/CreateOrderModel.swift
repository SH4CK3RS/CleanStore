//
//  CreateOrderModel.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

enum CreateOrder{
    enum FormatExpirationDate {
        struct Request {
            var date: Date
        }
        struct Response{
            var date: Date
        }
        struct ViewModel{
            var date: String
        }
    }
}
