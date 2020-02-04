//
//  ViewController.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

protocol CreateOrderViewControllerInput{
    func displayExpirationDate(_ viewModel: CreateOrder.FormatExpirationDate.ViewModel)
    func displayCreatedOrder(_ viewModel: CreateOrder.CreateOrder.ViewModel)
}
protocol CreateOrderViewControllerOutput{
    
    var shippingMethods: [String] { get }
    var orderToEdit: Order? { get }
    func formatExpirationDate(_ request: CreateOrder.FormatExpirationDate.Request)
    func createOrder(_ request: CreateOrder.CreateOrder.Request)
}

class CreateOrderViewController: UITableViewController, CreateOrderViewControllerInput, UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate  {
    //MARK:  Text FIelsd
    @IBOutlet var textFields: [UITextField]!
    
    //MARK: Shipping method
    @IBOutlet weak var shippingMethodTextFIeld: UITextField!
    @IBOutlet var shippingMethodPicker: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return output.shippingMethods.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return output.shippingMethods[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        shippingMethodTextFIeld.text = output.shippingMethods[row]
    }
    
    
    //MARK: Expiration date
    @IBOutlet weak var expirationDateTextField: UITextField!
    @IBOutlet var expirationDatePicker: UIDatePicker!
    
    @IBAction func expirationDatePickerValueChanged(sender: UIDatePicker){
        let date = expirationDatePicker.date
        let request = CreateOrder.FormatExpirationDate.Request(date: date)
        output.formatExpirationDate(request)
    }
    
    //MARK: Contact Info
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    //MARK: Payment Info
    @IBOutlet weak var billingAddressStreet1TextField: UITextField!
    @IBOutlet weak var billingAddressStreet2TextField: UITextField!
    @IBOutlet weak var billingAddressCityTextField: UITextField!
    @IBOutlet weak var billingAddressStateTextField: UITextField!
    @IBOutlet weak var billingAddressZIPTextFIeld: UITextField!
    
    @IBOutlet weak var creditCardNumberTextField: UITextField!
    @IBOutlet weak var ccvTextField: UITextField!
    
    //MARK: Shippinh Info
    @IBOutlet weak var shipmentAddressStreet1TextField: UITextField!
    @IBOutlet weak var shipmentAddressStreet2TextField: UITextField!
    @IBOutlet weak var shipmentAddressCityTextField: UITextField!
    @IBOutlet weak var shipmentAddressState1TextField: UITextField!
    @IBOutlet weak var shipmentAddressZIPTextField: UITextField!
    
    @IBAction func saveButtonTapped(_ sender: Any){
        //MARK: Cintact Info
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let phone = phoneTextField.text!
        let email = emailTextField.text!
        
        //MARK: Payment Info
        let billingAddressStreet1 = billingAddressStreet1TextField.text!
        let billingAddressStreet2 = billingAddressStreet2TextField.text!
        let billingAddressCity = billingAddressCityTextField.text!
        let billingAddressState = billingAddressStateTextField.text!
        let billingAddressZIP = billingAddressZIPTextFIeld.text!
        
        let paymentMethodCreditCardNumber = creditCardNumberTextField.text!
        let paymentMethodCCV = ccvTextField.text!
        let paymentMethodExpirationDate = expirationDatePicker.date
        let paymentMethodExpirationDateString = ""
        
        //MARK: Shiping Info
        let shipmentAddressStreet1 = shipmentAddressState1TextField.text!
        let shipmentAddressStreet2 = shipmentAddressStreet2TextField.text!
        let shipmentAddressCity = shipmentAddressCityTextField.text!
        let shipmentAddressState = shipmentAddressState1TextField.text!
        let shipmentAddressZIP = shipmentAddressZIPTextField.text!
        
        let shipmentMetnodSpeed = shippingMethodPicker.selectedRow(inComponent: 0)
        let shipmentMethodSpeedString = ""
        
        //MARK: Misc
        var id: String? = nil
        var date = Date()
        var total = NSDecimalNumber.notANumber
        
        let request = CreateOrder.CreateOrder.Request(orderFormFields: CreateOrder.OrderFormFields(firstName: firstName, lastName: lastName, phone: phone, email: email, billingAddressStreet1: billingAddressStreet1, billingAddressStreet2: billingAddressStreet2, billingAddressCity: billingAddressCity, billingAddressState: billingAddressState, billingAddressZIP: billingAddressZIP, paymentMethodCreditCardNumber: paymentMethodCreditCardNumber, paymentMethodCVV: paymentMethodCCV, paymentMethodExpirationDate: paymentMethodExpirationDate, paymentMethodExpirationDateString: paymentMethodExpirationDateString, shipmentAddressStreet1: shipmentAddressStreet1, shipmentAddressStreet2: shipmentAddressStreet2, shipmentAddressCity: shipmentAddressCity, shipmentAddressState: shipmentAddressState, shipmentAddressZIP: shipmentAddressZIP, shipmentMethodSpeed: shipmentMetnodSpeed, shipmentMethodSpeedString: shipmentMethodSpeedString, id: id, date: date, total: total))
        
        output.createOrder(request)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let index = textFields.firstIndex(of: textField){
            if index < textFields.count - 1 {
                let nextTextFIeld = textFields[index + 1]
                nextTextFIeld.becomeFirstResponder()
            }
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            for textField in textFields{
                if textField.isDescendant(of: cell){
                    textField.becomeFirstResponder()
                }
            }
        }
    }
    
    
    var output: CreateOrderViewControllerOutput!
    var router: CreateOrderRouter!
    
    //MARK: Object LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CreateOrderConfigurator.shared.configure(self)
    }
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configurePickers()
    }
    func configurePickers(){
        shippingMethodTextFIeld.inputView = shippingMethodPicker
        expirationDateTextField.inputView = expirationDatePicker
    }
    //MARK: Event Handling
    
    //MARK: Display Logic
    func displayExpirationDate(_ viewModel: CreateOrder.FormatExpirationDate.ViewModel){
        let date = viewModel.date
        expirationDateTextField.text = date
    }
    
    func displayCreatedOrder(_ viewModel: CreateOrder.CreateOrder.ViewModel){
        if viewModel.order != nil{
//            router?.routeToListOrders(segue: nil)
        }else{
            showOrderFailureAlert(title: "Failed to create order", message: "Please correct your order and submit again.")
        }
    }
    
    //MARK: Error Handling
    private func showOrderFailureAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        showDetailViewController(alertController, sender: nil)
    }
}

