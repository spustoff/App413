//
//  PropertiesViewModel.swift
//  App413
//
//  Created by Вячеслав on 3/22/24.
//

import SwiftUI
import CoreData

final class PropertiesViewModel: ObservableObject {
    
    @Published var properties: [PropertyModel] = []
    @AppStorage("saved_properties") var saved_properties: [String] = []
    
    @Published var isAdd: Bool = false
    
    @Published var image: String = ""
    @Published var name: String = ""
    @Published var status: String = ""
    @Published var text: String = ""
    @Published var price: String = ""
    @Published var location: String = ""
    @Published var property_type: String = ""
    
    func addProperty() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "PropertyModel", into: context) as! PropertyModel
        
        loan.img = image
        loan.name = name
        loan.status = status
        loan.text = text
        loan.price = Int16(price) ?? 0
        loan.location = location
        loan.property_type = property_type
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchProperties() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PropertyModel>(entityName: "PropertyModel")

        do {
            
            let result = try context.fetch(fetchRequest)
        
            self.properties = result
            
        } catch _ as NSError {
            
            self.properties = []
        }
    }
    
    func getSavedProperties() -> [PropertyModel] {
        
        return properties.filter{saved_properties.contains($0.name ?? "")}
    }
}
