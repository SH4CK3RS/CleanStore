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
    func doSomething(_ request: CreateOrderRequest)
}

class CreateOrderViewController: UITableViewController, CreateOrderViewControllerInput, UITextFieldDelegate  {
    //MARK:  Text FIelsd
    @IBOutlet var textFields: [UITextField]!
    
    //MARK: Shipping method
    @IBOutlet weak var shippingMethodTextFIeld: UITextField!
    @IBOutlet var shippingMethodPicker: UIPickerView!
    
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

