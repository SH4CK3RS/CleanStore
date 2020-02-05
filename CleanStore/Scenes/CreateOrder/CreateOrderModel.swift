//
//  CreateOrderModel.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

enum CreateOrder{
    struct OrderFormFields{
        //MARK: Contact Info
        var firstName: String
        var lastName: String
        var phone: String
        var email: String
        
        //MARK: Payment Info
        
        var billingAddressStreet1: String
        var billingAddressStreet2: String
        var billingAddressCity: String
        var billingAddressState: String
        var billingAddressZIP: String
        
        var paymentMethodCreditCardNumber: String
        var paymentMethodCVV: String
        var paymentMethodExpirationDate: Date
        var paymentMethodExpirationDateString: String
        
        //MARK: Shipping Info
        var shipmentAddressStreet1: String
        var shipmentAddressStreet2: String
        var shipmentAddressCity: String
        var shipmentAddressState: String
        var shipmentAddressZIP: String
        
        var shipmentMethodSpeed: Int
        var shipmentMethodSpeedString: String
        
        //MARK: Misc
        var id: String?
        var date: Date
        var total: NSDecimalNumber
    }
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
    enum CreateOrder{
        struct Request{
            var orderFormFields: OrderFormFields
        }
        struct Response{
            var order: Order?
        }
        struct ViewModel{
            var order: Order?
        }
    }
    enum UpdateOrder{
        struct Request{
            var orderFormFields: OrderFormFields
        }
        struct Response{
            var order: Order?
        }
        struct ViewModel{
            var order: Order?
        }
    }
}
