//
//  OrdersMemStoreTests.swift
//  CleanStoreTests
//
//  Created by 손병근 on 2020/04/24.
//  Copyright © 2020 손병근. All rights reserved.
//

@testable import CleanStore
import XCTest

class OrdersMemStoreTests: XCTestCase{
  var sut: OrdersMemStore!
  var testOrders: [Order]!
  
  override func setUpWithError() throws {
    setupOrdersMemStore()
  }
  
  override func tearDownWithError() throws {
    resetOrdersMemStore()
  }
  
  func setupOrdersMemStore(){
    sut = OrdersMemStore()
    testOrders = [Seeds.Orders.amy, Seeds.Orders.bob]
    OrdersMemStore.orders = testOrders
  }
  
  func resetOrdersMemStore(){
    OrdersMemStore.orders = []
    sut = nil
  }
  
  //MARK: - Test CRUD with optioan Error
  func testFetchOrdersShouldReturnListOfOrders_OptionalError(){
    //Given
    
    //When
    var fetchedOrders = [Order]()
    var fetchedOrdersError: OrdersStoreError?
    let expect = expectation(description: "Wait for fetchOrders() to return")
    sut.fetchOrders { (orders, error) in
      fetchedOrders = orders
      fetchedOrdersError = error
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    
    //Then
    XCTAssertEqual(fetchedOrders.count, testOrders.count, "fetchOrders() should return a list of orders")
    for order in fetchedOrders{
      XCTAssert(testOrders.contains(order), "Fetched orders should match the orders in the data store")
    }
    XCTAssertNil(fetchedOrdersError)
  }
  
  func testFetchOrderShouldReturnOrder_OptionalError(){
    //Given
    let ordersToFetch = testOrders.first!
    
    //When
    var fetchedOrder: Order?
    var fetchedOrderError: OrdersStoreError?
    let expect = expectation(description: "Wait for fetchOrder() to return")
    sut.fetchOrder(id: ordersToFetch.id!) { (order, error) in
      fetchedOrder = order
      fetchedOrderError = error
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    
    //Then
    XCTAssertEqual(ordersToFetch, fetchedOrder, "fetchOrder() should return an order")
    XCTAssertNil(fetchedOrderError, "fetchOrder() should not return an error")
  }
  
  func testCreateOrderShouldReturnOrder_OptionalError(){
    //Given
    let orderToCreate = Seeds.Orders.chris
    
    //When
    var createdOrder: Order?
    var createOrderError: OrdersStoreError?
    let expect = expectation(description: "wait for createOrder() to return")
    sut.createOrder(orderToCreate: orderToCreate) { (order, error) in
      createdOrder = order
      createOrderError = error
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    
    XCTAssertEqual(orderToCreate, createdOrder, "createOrder() should return a new order")
    XCTAssertNil(createOrderError, "createOrder() should not return an error")
  }
  
  func testUpdateOrderShouldUpdateExistingOrder_OptionalError(){
    //Given
    var orderToUpdate = testOrders.first!
    let tomorrow = Date(timeIntervalSinceNow: 24*60*60)
    orderToUpdate.date = tomorrow
    
    //When
    var updatedOrder: Order?
    var updateOrderError: OrdersStoreError?
    let expect = expectation(description: "wait for updateOrder() to return")
    sut.updateOrder(orderToUpdate: orderToUpdate) { (order, error) in
      updatedOrder = order
      updateOrderError = error
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    
    //Then
    XCTAssertEqual(orderToUpdate, updatedOrder, "updateOrder() should update an existed order")
    XCTAssertNil(updateOrderError, "updateOrder() should not return an error")
  }
  
  func testDeleteOrderShouldDeleteExistingOrder_OptionalError(){
    //Given
    let orderToDelete = testOrders.first!
    
    //When
    var deletedOrder: Order?
    var deleteOrderError: OrdersStoreError?
    let expect = expectation(description: "wait for deleteOrder() to return")
    sut.deleteOrder(id: orderToDelete.id!) { (order, error) in
      deletedOrder = order
      deleteOrderError = error
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    
    //Then
    XCTAssertEqual(orderToDelete, deletedOrder)
    XCTAssertNil(deleteOrderError)
  }
  
  //MARK: - CRUD with Enum
  func testFetchOrdersShouldReturnListOfOrders_GenericEnumResultType()
  {
    // Given
    
    // When
    var fetchedOrders = [Order]()
    var fetchOrdersError: OrdersStoreError?
    let expect = expectation(description: "Wait for fetchOrders() to return")
    sut.fetchOrders { (result: OrdersStoreResult<[Order]>) in
      switch result{
      case let .Success(result: orders):
        fetchedOrders = orders
      case let .Failure(error: error):
        fetchOrdersError = error
        XCTFail("fetchOrders() should not returnan error: \(error)")
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    
    //Then
    XCTAssertEqual(fetchedOrders.count, testOrders.count, "fetchOrders() should return a list of orders")
    for order in fetchedOrders{
      XCTAssert(testOrders.contains(order),"Fetched orders should match the orders in the data store")
    }
    XCTAssertNil(fetchOrdersError)
  }
  
  func testFetchOrderShouldReturnOrder_GenericEnumResultType(){
    //Given
    let orderToFetch = testOrders.first!
    
    //When
    var fetchedOrder: Order?
    var fetchOrderError: OrdersStoreError?
    let expect = expectation(description: "wait fetchOrder() to return an order")
    sut.fetchOrder(id: orderToFetch.id!) { (result: OrdersStoreResult<Order>) in
      switch result{
      case let .Success(order):
        fetchedOrder = order
      case let .Failure(error):
        fetchOrderError = error
        XCTFail("fetchOrder() should not return an error: \(error)")
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    
    //Then
    XCTAssertEqual(orderToFetch, fetchedOrder, "fetchOrder() should return an order")
    XCTAssertNil(fetchOrderError, "fetchOrder() shold not return an error")
  }
  
  func testCreateOrderShouldCreateNewOrder_GenericEnumResultType(){
    //Given
    let orderToCreate = Seeds.Orders.chris
    
    //When
    var createdOrder: Order?
    var createOrderError: OrdersStoreError?
    let expect = expectation(description: "wait createOrder() to create new order")
    sut.createOrder(orderToCreate: orderToCreate) { (result: OrdersStoreResult<Order>) in
      switch result{
      case let .Success(order):
        createdOrder = order
      case let .Failure(error):
        createOrderError = error
        XCTFail("createOrder() should not return an order")
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    
    XCTAssertEqual(orderToCreate, createdOrder, "orderCreate() should create new order")
    XCTAssertNil(createOrderError)
  }
  
  func testUpdateOrderShouldUpdateOrder_GenericEnumResultType(){
    //Given
    var orderToUpdate = testOrders.first!
    let tomorrow = Date.init(timeIntervalSinceNow: 24*60*60)
    orderToUpdate.date = tomorrow
    
    //When
    var updatedOrder: Order?
    var updateOrderError: OrdersStoreError?
    let expect = expectation(description: "wait updateOrder() should update order")
    sut.updateOrder(orderToUpdate: orderToUpdate) { (result: OrdersStoreResult<Order>) in
      switch result{
      case let .Success(order):
        updatedOrder = order
      case let .Failure(error):
        updateOrderError = error
        XCTFail("updateOrder() should not return an error")
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    
    //Then
    XCTAssertEqual(orderToUpdate, updatedOrder, "updateOrder() should update order")
    XCTAssertNil(updateOrderError, "updateOrder() should not retrun an error")
  }
  
  func testDeleteOrderShouldDeleteOrder_GenericEnumResultType(){
    //Given
    let orderToDelete = testOrders.first!
    
    //When
    var deletedOrder: Order?
    var deleteOrderError: OrdersStoreError?
    let expect = expectation(description: "wait deleteOrder() should delete order")
    sut.deleteOrder(id: orderToDelete.id!) { (result: OrdersStoreResult<Order>) in
      switch result{
      case let .Success(order):
        deletedOrder = order
      case let .Failure(error):
        deleteOrderError = error
        XCTFail("deleteOrder() should not return an error")
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    
    //Then
    XCTAssertEqual(orderToDelete, deletedOrder, "deleteOrder() should delete order and return deleted one")
    XCTAssertNil(deleteOrderError)
  }
    
  //MARK: - Test CRUD operations - Inner Closure
  
  func testFetchOrdersShouldReturnListOfOrders_InnerColsure(){
    //Given
    
    //When
    var fetchedOrders = [Order]()
    var fetchOrdersError: OrdersStoreError?
    let expect = expectation(description: "Wait for fetchOrders() to return")
    sut.fetchOrders { (orders: () throws -> [Order]) in
      do{
        fetchedOrders = try orders()
      }catch let error as OrdersStoreError{
        fetchOrdersError = error
      }catch{
        
      }
      expect.fulfill()
      //Then
    }
    waitForExpectations(timeout: 1.0)
    
    //Then
    XCTAssertEqual(fetchedOrders.count, testOrders.count, "fetchOrders() should return a list of orders")
    XCTAssertNil(fetchOrdersError, "fetchOrders() should not return an error")
  }
  
  func testFetchOrderShouldReturnOrder_InnerClosure(){
    //Given
    let orderToFetch = testOrders.first!
    
    //When
    var fetchedOrder: Order?
    var fetchOrderError: OrdersStoreError?
    let expect = expectation(description: "wait for fetchOrder() to return")
    
    sut.fetchOrder(id: orderToFetch.id!) { (order: () throws -> Order?) in
      do{
        fetchedOrder = try order()
      }catch let error as OrdersStoreError{
        fetchOrderError = error
      }catch{
        
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    
    //Then
    XCTAssertEqual(orderToFetch, fetchedOrder, "fetchOrder() shoud return an order")
    XCTAssertNil(fetchOrderError)
  }
  
  func testCreateOrderShouldRetrunNewOrder_InnerClosure(){
    //Given
    var orderToCreate = Seeds.Orders.chris
    let tomorrow = Date.init(timeIntervalSinceNow: 24*60*60)
    orderToCreate.date = tomorrow
    
    //When
    var createdOrder: Order?
    var createOrderError: OrdersStoreError?
    let expect = expectation(description: "wait for createOrder() to return")
    
    sut.createOrder(orderToCreate: orderToCreate) { (order: () throws -> Order?) in
      do{
        createdOrder = try order()
      }catch let error as OrdersStoreError{
        createOrderError = error
      }catch{
        
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    
    //Then
    XCTAssertEqual(orderToCreate, createdOrder, "createOrder() should return a new order")
    XCTAssertNil(createOrderError)
  }
    
}

