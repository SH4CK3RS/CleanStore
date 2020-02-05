//
//  ShowOrderModels.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/05.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

enum ShowOrder{
    // MARK: Use cases
    enum GotOrder{
        struct Request {
            
        }
        struct Response {
            var order: Order
        }
        struct ViewModel {
            struct DisplayedOrder {
                var id: String
                var date: String
                var email: String
                var name: String
                var total: String
            }
            var displayedOrder: DisplayedOrder
        }
        
    }
}
