//
//  DashboardViewModel.swift
//  App413
//
//  Created by Вячеслав on 3/22/24.
//

import SwiftUI
import CoreData

final class DashboardViewModel: ObservableObject {
    
    @Published var transactions: [TransactionModel] = []
    
    @Published var isAddTransaction: Bool = false
    @Published var isChart: Bool = false
    @Published var isProperties: Bool = false
    
    @Published var transaction_property: String = ""
    @Published var transaction_location: String = ""
    
    @Published var transaction_typesList: [String] = ["Earning", "Spending"]
    @Published var transaction_type: String = ""
    
    @Published var transaction_amount: String = ""
    
    func addTransaction() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "TransactionModel", into: context) as! TransactionModel
        
        loan.property = transaction_property
        loan.location = transaction_location
        loan.transaction_type = transaction_type
        loan.amount = Int16(transaction_amount) ?? 0
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchTransactions() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TransactionModel>(entityName: "TransactionModel")

        do {
            
            let result = try context.fetch(fetchRequest)
        
            self.transactions = result
            
        } catch _ as NSError {
            
            self.transactions = []
        }
    }
}
