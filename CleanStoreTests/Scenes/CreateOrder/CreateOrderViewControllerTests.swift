//
//  CreateOrderViewControllerTests.swift
//  CleanStoreTests
//
//  Created by 손병근 on 2020/04/23.
//  Copyright © 2020 손병근. All rights reserved.
//

@testable import CleanStore
import UIKit
import XCTest

struct TestDisplaySaveOrderFailure{
  static var presentViewControllerAnimatedCompletionCalled = false
  static var viewCOntrollerToPresent: UIViewController?
}

extension CreateOrderViewController{
  override open func showDetailViewController(_ vc: UIViewController, sender: Any?) {
    TestDisplaySaveOrderFailure.presentViewControllerAnimatedCompletionCalled = true
    TestDisplaySaveOrderFailure.viewCOntrollerToPresent = vc
  }
}

class CreateOrderViewControllerTests: XCTestCase{
  var sut: CreateOrderViewController!
  var window: UIWindow!
  
  override func setUpWithError() throws {
    window = UIWindow()
    setupCreateOrderViewController()
  }
  
  override func tearDownWithError() throws {
    window = nil
  }
  
  func setupCreateOrderViewController(){
    let bundle = Bundle.main
    let storyboard = UIStoryboard(name: "Main", bundle: bundle)
    sut = storyboard.instantiateViewController(withIdentifier: "CreateOrderViewController") as? CreateOrderViewController
  }
  
  func loadView(){
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  
  class CreateOrderBusnessLogicSpy: CreateOrderBusinessLogic{
    var formatExpirationDateCalled = false
    var createOrderCalled = false
    var showOrderToEdditCalled = false
    var updateOrderCalled = false
    
    //MARK: Argument Expectations
    var formatExpirationDateRequest: CreateOrder.FormatExpirationDate.Request!
    var createOrderRequest: CreateOrder.CreateOrder.Request!
    var editOrderRequest: CreateOrder.EditOrder.Request!
    var updateOrderRequest: CreateOrder.UpdateOrder.Request!
    
    //MARK: Spied Variables
    var shippingMethods = [String]()
    var orderToEdit: Order?
    
    //MARK: Spied Methods
    func formatExpirationDate(_ request: CreateOrder.FormatExpirationDate.Request) {
      formatExpirationDateCalled = true
      self.formatExpirationDateRequest = request
    }
    
    func createOrder(_ request: CreateOrder.CreateOrder.Request) {
      createOrderCalled = true
      self.createOrderRequest = request
    }
    
    func showOrderToEdit(_ request: CreateOrder.EditOrder.Request) {
      showOrderToEdditCalled = true
      self.editOrderRequest = request
    }
    
    func updateOrder(_ request: CreateOrder.UpdateOrder.Request) {
      updateOrderCalled = true
      self.updateOrderRequest = request
    }
  }
  
  class CreateOrderSpy: CreateOrderRouter{
    //MARK: Methkd call expectations
    var routeToListOrderCalled = false
    var routeToShowOrderCalled = false
    
    //MARK: Spied methods
    override func routeToListOrders(segue: UIStoryboardSegue?) {
      routeToListOrderCalled = true
    }
    override func routeToShowOrder(segue: UIStoryboardSegue?) {
      routeToShowOrderCalled = true
    }
  }
  
  // 뷰 로드시에 텍스트필드에 피커뷰가 inputView로 잘 등록되어있는지 테스트
  
  func testCreateOrderViewControllerShouldConfigurePickersWhenViewIsLoaded(){
    //Given
    
    //When
    loadView()
    
    //Then
    XCTAssertEqual(sut.expirationDateTextField.inputView, sut.expirationDatePicker, "Expiration date text field should have the expiration date picker as input view")
    XCTAssertEqual(sut.shippingMethodTextFIeld.inputView, sut.shippingMethodPicker, "Shipping method text field should have the shipping method picker as input view")
  }
  
  func testShouldShowOrderToEditWhenViewIsLoaded(){
    //Given
    let createdOrderBusinessLogicSpy = CreateOrderBusnessLogicSpy()
    sut.interactor = createdOrderBusinessLogicSpy
    
    //When
    loadView()
    
    //Then
    XCTAssert(createdOrderBusinessLogicSpy.showOrderToEdditCalled, "Should show order to edit when the view is loaded")
  }
  
  //뷰 로딩 후 수정에 대한 뷰모델이 전달되어 각 필드가 정상적으로 채워졌는지 확인하는 테스트
  func testShouldDisplayOrderToEdit(){
    //Given
    loadView()
    
    //When
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .none
    let orderToEdit = Seeds.Orders.amy
    let viewModel = CreateOrder.EditOrder.ViewModel(orderFormFields: CreateOrder.OrderFormFields(firstName: orderToEdit.firstName, lastName: orderToEdit.lastName, phone: orderToEdit.phone, email: orderToEdit.email, billingAddressStreet1: orderToEdit.billingAddress.street1, billingAddressStreet2: orderToEdit.billingAddress.street2 ?? "", billingAddressCity: orderToEdit.billingAddress.city, billingAddressState: orderToEdit.billingAddress.state, billingAddressZIP: orderToEdit.billingAddress.zip, paymentMethodCreditCardNumber: orderToEdit.paymentMethod.creditCardNumber, paymentMethodCVV: orderToEdit.paymentMethod.cvv, paymentMethodExpirationDate: orderToEdit.paymentMethod.expirationDate, paymentMethodExpirationDateString: dateFormatter.string(from: orderToEdit.paymentMethod.expirationDate), shipmentAddressStreet1: orderToEdit.shipmentAddress.street1, shipmentAddressStreet2: orderToEdit.shipmentAddress.street2 ?? "", shipmentAddressCity: orderToEdit.shipmentAddress.city, shipmentAddressState: orderToEdit.shipmentAddress.state, shipmentAddressZIP: orderToEdit.shipmentAddress.zip, shipmentMethodSpeed: orderToEdit.shipmentMethod.speed.rawValue, shipmentMethodSpeedString: orderToEdit.shipmentMethod.toString(), id: orderToEdit.id, date: orderToEdit.date, total: orderToEdit.total))
    sut.displayOrderToEdit(viewModel)
    // Then
    XCTAssertEqual(sut.firstNameTextField.text, viewModel.orderFormFields.firstName, "Displaying the order to edit should display the correct first name")
    XCTAssertEqual(sut.lastNameTextField.text, viewModel.orderFormFields.lastName, "Displaying the order to edit should display the correct ")
    XCTAssertEqual(sut.phoneTextField.text, viewModel.orderFormFields.phone, "Displaying the order to edit should display the correct ")
    XCTAssertEqual(sut.emailTextField.text, viewModel.orderFormFields.email, "Displaying the order to edit should display the correct ")
    XCTAssertEqual(sut.billingAddressStreet1TextField.text, viewModel.orderFormFields.billingAddressStreet1, "Displaying the order to edit should display the correct ")
    XCTAssertEqual(sut.billingAddressStreet2TextField.text, viewModel.orderFormFields.billingAddressStreet2, "Displaying the order to edit should display the correct ")
    XCTAssertEqual(sut.billingAddressCityTextField.text, viewModel.orderFormFields.billingAddressCity, "Displaying the order to edit should display the correct ")
    XCTAssertEqual(sut.billingAddressStateTextField.text, viewModel.orderFormFields.billingAddressState, "Displaying the order to edit should display the correct ")
    XCTAssertEqual(sut.billingAddressZIPTextField.text, viewModel.orderFormFields.billingAddressZIP, "Displaying the order to edit should display the correct ")
    XCTAssertEqual(sut.creditCardNumberTextField.text, viewModel.orderFormFields.paymentMethodCreditCardNumber, "Displaying the order to edit should display the correct ")
    XCTAssertEqual(sut.ccvTextField.text, viewModel.orderFormFields.paymentMethodCVV, "Displaying the order to edit should display the correct ")
    XCTAssertEqual(sut.shipmentAddressStreet1TextField.text, viewModel.orderFormFields.shipmentAddressStreet1, "Displaying the order to edit should display the correct ")
    XCTAssertEqual(sut.shipmentAddressStreet2TextField.text, viewModel.orderFormFields.shipmentAddressStreet2, "Displaying the order to edit should display the correct ")
    XCTAssertEqual(sut.shipmentAddressCityTextField.text, viewModel.orderFormFields.shipmentAddressCity, "Displaying the order to edit should display the correct ")
    XCTAssertEqual(sut.shipmentAddressStateTextField.text, viewModel.orderFormFields.shipmentAddressState, "Displaying the order to edit should display the correct ")
    XCTAssertEqual(sut.shipmentAddressZIPTextField.text, viewModel.orderFormFields.shipmentAddressZIP, "Displaying the order to edit should display the correct ")
    XCTAssertEqual(sut.shippingMethodPicker.selectedRow(inComponent: 0), viewModel.orderFormFields.shipmentMethodSpeed, "Displaying the order to edit should display the correct ")
    XCTAssertEqual(sut.shippingMethodTextFIeld.text, viewModel.orderFormFields.shipmentMethodSpeedString, "Displaying the order to edit should display the correct ")
    XCTAssertEqual(sut.expirationDatePicker.date, viewModel.orderFormFields.paymentMethodExpirationDate, "Displaying the order to edit should display the correct ")
    XCTAssertEqual(sut.expirationDateTextField.text, viewModel.orderFormFields.paymentMethodExpirationDateString, "Displaying the order to edit should display the correct ")
  }
  
  func testDisplayExpirationDateShouldDisplayDateStringInTextField(){
    //Given
    loadView()
    
    //When
    let viewModel = CreateOrder.FormatExpirationDate.ViewModel(date: "6/29/07")
    sut.displayExpirationDate(viewModel)
    
    //Then
    let displayedDate = sut.expirationDateTextField.text
    XCTAssertEqual(displayedDate, "6/29/07", "Displaying an expiration date should display the date string in the expiration date text field")
    
  }
}
