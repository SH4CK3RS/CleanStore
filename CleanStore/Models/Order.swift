//
//  Order.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import Foundation

struct Order: Equatable{
    //MARK: Contact Info
    var firstName: String
    var lastName: String
    var phone: String
    var email: String
    
    //MARK: Payment Info
    var billingAddress: Address
    var paymentMethod: PaymentMethod
    
    //MARK: Shipping Info
    var shipmentAddress: Address
    var shipmentMethod: ShipmentMethod
    
    //MARK: Misc
    var id: String?
    var date: Date
    var total: NSDecimalNumber
    
    
}
func ==(lhs: Order, rhs: Order) -> Bool{
    return lhs.firstName == rhs.firstName
        && lhs.lastName == rhs.lastName
        && lhs.phone == rhs.phone
        && lhs.email == rhs.email
        && lhs.billingAddress == rhs.billingAddress
        && lhs.paymentMethod == rhs.paymentMethod
        && lhs.shipmentMethod == rhs.shipmentMethod
        && lhs.id == rhs.id
        && lhs.date == rhs.date
        && lhs.total == rhs.total
}

// MARK: - Supporting Models
struct Address{
    var street1: String
    var street2: String
    var city: String
    var state: String
    var zip: String
}
func == (lhs: Address, rhs: Address) -> Bool {
    return lhs.street1 == rhs.street1
        && lhs.street2 == rhs.street2
        && lhs.city == rhs.city
        && lhs.state == rhs.state
        && lhs.zip == rhs.zip
}

struct ShipmentMethod{
    enum ShipmentSpeed: Int{
        case Standard = 0 // "Standard Shipping"
        case OneDay = 1 // "One-Day Shipping"
        case TwoDay = 2 // "Two-Day Shipping"
    }
    var speed: ShipmentSpeed
    
    func toString() -> String{
        switch speed{
        case .Standard:
            return "Standard Shipping"
        case .OneDay:
            return "One-Day Shipping"
        case .TwoDay:
            return "Two-Day Shipping"
        }
    }
}
func ==(lhs: ShipmentMethod, rhs: ShipmentMethod) -> Bool{
    return lhs.speed == rhs.speed
}


struct PaymentMethod{
    var creditCardNumber: String
    var expirationDate: Date
    var cvv: String
}

func ==(lhs: PaymentMethod, rhs: PaymentMethod) -> Bool{
    return lhs.creditCardNumber == rhs.creditCardNumber
        && lhs.expirationDate == rhs.expirationDate
        && lhs.cvv == rhs.cvv
}
