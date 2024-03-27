//
//  DashboardAdd.swift
//  App413
//
//  Created by Вячеслав on 3/22/24.
//

import SwiftUI

struct DashboardAdd: View {
    
    @StateObject var viewModel: DashboardViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(.gray.opacity(0.3))
                    .frame(width: 50, height: 5)
                    .padding(.top)
                
                ZStack {
                    
                    Text("Add Transaction")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .semibold))
                    
                    HStack {
                        
                        Button(action: {
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .font(.system(size: 10, weight: .bold))
                                .frame(width: 20, height: 20)
                                .background(Circle().fill(.gray.opacity(0.7)))
                        })
                        
                        Spacer()
                    }
                }
                .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack {
                        
                        Button(action: {
                            
                            viewModel.isProperties = true
                            
                        }, label: {
                            
                            HStack {
                                
                                Text(viewModel.transaction_property.isEmpty ? "Property" : viewModel.transaction_property)
                                    .foregroundColor(viewModel.transaction_property.isEmpty ? .gray : .black)
                                    .font(.system(size: 15, weight: .regular))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12, weight: .regular))
                            }
                            .padding()
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                        })
                        
                        HStack {
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Location")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.transaction_location.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.transaction_location)
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .regular))
                            })
                            
                            Spacer()
                        }
                        .padding()
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                        
                        Menu {
                            
                            ForEach(viewModel.transaction_typesList, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.transaction_type = index
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        Text(index)
                                        
                                        if viewModel.transaction_type == index {
                                            
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                })
                            }
                            
                        } label: {
                            
                            HStack {
                                
                                Text(viewModel.transaction_type.isEmpty ? "Type of transaction" : viewModel.transaction_type)
                                    .foregroundColor(viewModel.transaction_type.isEmpty
                                                     ? .gray : .black)
                                    .font(.system(size: 15, weight: .regular))
                                
                                Spacer()
                                
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12, weight: .regular))
                            }
                            .padding()
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                        }
                        
                        HStack {
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Amount")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.transaction_amount.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.transaction_amount)
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .regular))
                                    .keyboardType(.decimalPad)
                            })
                            
                            Spacer()
                        }
                        .padding()
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                    }
                    .padding()
                }
                
                Spacer()
                
                Button(action: {
                    
                    viewModel.addTransaction()
                    viewModel.fetchTransactions()
                    
                    router.wrappedValue.dismiss()
                    
                    viewModel.transaction_property = ""
                    viewModel.transaction_location = ""
                    viewModel.transaction_type = ""
                    viewModel.transaction_amount = ""
                    
                }, label: {
                    
                    Text("Save")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary")))
                        .padding()
                })
                .opacity(viewModel.transaction_property.isEmpty || viewModel.transaction_location.isEmpty || viewModel.transaction_type.isEmpty || viewModel.transaction_amount.isEmpty ? 0.5 : 1)
                .disabled(viewModel.transaction_property.isEmpty || viewModel.transaction_location.isEmpty || viewModel.transaction_type.isEmpty || viewModel.transaction_amount.isEmpty ? true : false)
            }
        }
        .sheet(isPresented: $viewModel.isProperties, content: {
            
            DashboardProperties(selectedProperty: $viewModel.transaction_property)
        })
    }
}

#Preview {
    DashboardAdd(viewModel: DashboardViewModel())
}
