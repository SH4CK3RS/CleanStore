//
//  OrdersCoreDataStoreTests.swift
//  CleanStoreTests
//
//  Created by 손병근 on 2020/04/25.
//  Copyright © 2020 손병근. All rights reserved.
//

@testable import CleanStore
import XCTest

class OrdersCoreDataStoreTests: XCTestCase{
  //MARK: - SUT
  
  var sut: OrdersCoreDataStore!
  var testOrders: [Order]!
  
  //MARK: - Test Lifecycle
  
  override func setUpWithError() throws {
    setupOrdersCoreDataStore()
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func setupOrdersCoreDataStore(){
    sut = OrdersCoreDataStore()
    deleteAllOrdersInOrdersCoreDataStore()
  }
  
  func deleteAllOrdersInOrdersCoreDataStore(){
    var allOrders = [Order]()
    let fetchAllOrdersExpectation = expectation(description: "Wait for fetchOrder() to return ")
    sut.fetchOrders { (orders: () throws -> [Order]) in
      allOrders = try! orders()
      fetchAllOrdersExpectation.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    
    for order in allOrders{
      let deleteOrderExprctation = expectation(description: "Wait for deleteOrder() to return")
      sut.deleteOrder(id: order.id!) { (delete: () throws -> Order?) in
        deleteOrderExprctation.fulfill()
      }
      waitForExpectations(timeout: 1.0)
    }
  }
  
  //Test Crud Operations
  
}
