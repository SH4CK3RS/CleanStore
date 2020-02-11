//
//  OrdersCoreDataStore.swift
//  CleanStore
//
//  Created by byeonggeunSon on 2020/02/11.
//  Copyright © 2020 손병근. All rights reserved.
//

import CoreData

class OrdersCoreDataStore: OrdersStoreProtocol, OrderStoreUtilityProtocol{
    //MARK: - Managed Object contexts
    
    var mainManagedObjectContext: NSManagedObjectContext
    var privateManagedObjectContext: NSManagedObjectContext
    
    //MARK: - Object Life Cycle
    
    init(){
        //프로젝트 내의 xcdatamodeld와 동일한 이름으로 설정
        guard let modelURL = Bundle.main.url(forResource: "CleanStore", withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        mainManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainManagedObjectContext.persistentStoreCoordinator = psc
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docURL = urls[urls.endIndex-1]
        /* App에서 Core Data store 파일을 저장하기위해 directory를 사용
         "DataModel.sqlite"파일을 document directory에 저장
         */
        let storeUrl = docURL.appendingPathComponent("CleanStore.sqlite")
        do{
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeUrl, options: nil)
        }catch{
            fatalError("Error migrating store: \(error)")
        }
        
        privateManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateManagedObjectContext.parent = mainManagedObjectContext
    }
    
    deinit {
        do{
            try self.mainManagedObjectContext.save()
        }catch{
            fatalError("Error deinitializing main managed object context")
        }
        
    }
    
    // MARK: - CRUD operations - Optional error
    func fetchOrders(completionHandler: @escaping ([Order], OrdersStoreError?) -> Void) {
        privateManagedObjectContext.perform {
            do{
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManageOrder")
                let results = try self.privateManagedObjectContext.fetch(fetchRequest) as! [ManagedOrder]
                let orders = results.map { $0.toOrder() }
                completionHandler(orders, nil)
            }catch{
                completionHandler([], OrdersStoreError.CannotFetch("Cannot fetch orders"))
            }
        }
    }
    func fetchOrder(id: String, completionHandler: @escaping (Order?, OrdersStoreError?) -> Void) {
        privateManagedObjectContext.perform{
            do{
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedOrder")
                fetchRequest.predicate = NSPredicate(format: "id == %@", id)
                let results = try self.privateManagedObjectContext.fetch(fetchRequest) as! [ManagedOrder]
                if let order = results.first?.toOrder(){
                    completionHandler(order, nil)
                }else{
                    completionHandler(nil, OrdersStoreError.CannotFetch("Cannot fetch order with id \(id)"))
                }
            }catch{
                completionHandler(nil, OrdersStoreError.CannotFetch("Cannot fetch order with id \(id)"))
            }
        }
    }
    
    func createOrder(orderToCreate: Order, completionHandler: @escaping (Order?, OrdersStoreError?) -> Void) {
        privateManagedObjectContext.perform {
            do{
                let managedOrder = NSEntityDescription.insertNewObject(forEntityName: "ManagedOrder", into: self.privateManagedObjectContext) as! ManagedOrder
                var order = orderToCreate
                self.generateOrderID(order: &order)
                self.calculateOrderTotal(order: &order)
                managedOrder.fromOrder(order: order)
                try self.privateManagedObjectContext.save()
                completionHandler(order, nil)
            }catch{
                completionHandler(nil, OrdersStoreError.CannotCreate("Cannot create order with id \(String.init(describing: orderToCreate.id))"))
            }
        }
    }
    func updateOrder(orderToUpdate: Order, completionHandler: @escaping ((Order?, OrdersStoreError?) -> Void)){
        privateManagedObjectContext.perform {
            do{
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedOrder")
                fetchRequest.predicate = NSPredicate(format: "id == %@", orderToUpdate.id!)
                let results = try self.privateManagedObjectContext.fetch(fetchRequest) as! [ManagedOrder]
                if let managedOrder = results.first{
                    do{
                        managedOrder.fromOrder(order: orderToUpdate)
                        let order = managedOrder.toOrder()
                        try self.privateManagedObjectContext.save()
                        completionHandler(order, nil)
                    }catch{
                        completionHandler(nil, OrdersStoreError.CannotUpdate("Cannot update order with id: \(String.init(describing: orderToUpdate.id))"))
                    }
                }
            }catch{
                completionHandler(nil, OrdersStoreError.CannotUpdate("Cannot update order with id: \(String.init(describing: orderToUpdate.id))"))
            }
        }
    }
    func deleteOrder(id: String, completionHandler: @escaping (Order?, OrdersStoreError?) -> Void) {
        privateManagedObjectContext.perform {
            do{
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedOrder")
                fetchRequest.predicate = NSPredicate(format: "id == %@", id)
                let results = try self.privateManagedObjectContext.fetch(fetchRequest) as! [ManagedOrder]
                if let managedOrder = results.first{
                    let order = managedOrder.toOrder()
                    self.privateManagedObjectContext.delete(managedOrder)
                    do{
                        try self.privateManagedObjectContext.save()
                        completionHandler(order, nil)
                    }catch{
                        completionHandler(nil, OrdersStoreError.CannotDelete("Cannot delete order with id: \(id)"))
                    }
                }else{
                    throw OrdersStoreError.CannotDelete("Cannot fetch order with id \(id) to delete" )
                }
            }catch{
                completionHandler(nil, OrdersStoreError.CannotDelete("Cannot fetch order with id \(id) to delete"))
            }
        }
    }
}
