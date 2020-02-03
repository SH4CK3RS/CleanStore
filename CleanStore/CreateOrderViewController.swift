//
//  ViewController.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/04.
//  Copyright © 2020 손병근. All rights reserved.
//

import UIKit

protocol CreateOrderViewControllerInput{
    
    func displaySomething(_ viewModel: CreateOrderViewModel)
    
}
protocol CreateOrderViewControllerOutput{
    var shippingMethods: [String] { get }
    func doSomething(_ request: CreateOrderRequest)
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
        doSomethingOnLoad()
        configurePickers()
    }
    func configurePickers(){
        shippingMethodTextFIeld.inputView = shippingMethodPicker
    }
    //MARK: Event Handling
    func doSomethingOnLoad(){
        // NOTE: Interactor에 특정 작업 요청
        
        let request = CreateOrderRequest()
        output.doSomething(request)
    }
    
    //MARK: Display Logic
    func displaySomething(_ viewModel: CreateOrderViewModel){
        // NOTE: Presenter로부터 받은 result를 통해 화면 구성

//        nameTextField.text = viewModel.name
    }
}

