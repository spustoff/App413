//
//  DashboardView.swift
//  App413
//
//  Created by Вячеслав on 3/22/24.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject var viewModel = DashboardViewModel()
    @StateObject var propertyModel = PropertiesViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Dashboard")
                    .foregroundColor(.black)
                    .font(.system(size: 23, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                HStack {
                    
                    VStack(alignment: .leading, spacing: 5, content: {
                        
                        Text("Current balance")
                            .foregroundColor(.black.opacity(0.6))
                            .font(.system(size: 14, weight: .regular))
                        
                        Text("$\(viewModel.transactions.map(\.amount).reduce(0, +))")
                            .foregroundColor(.black)
                            .font(.system(size: 26, weight: .bold))
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        
                        viewModel.isChart = true
                        
                    }, label: {
                        
                        HStack {
                            
                            Text("USD")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                        }
                        .padding(8)
                        .background(Capsule().fill(.white))
                    })
                }
                .padding()
                
                VStack {
                    
                    HStack {
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            
                            HStack(content: {
                                
                                Image(systemName: "arrow.up")
                                    .foregroundColor(.green)
                                    .font(.system(size: 12, weight: .regular))
                                    .frame(width: 29, height: 29)
                                    .background(RoundedRectangle(cornerRadius: 5).fill(.green.opacity(0.2)))
                                
                                Text("Earned")
                                    .foregroundColor(.green)
                                    .font(.system(size: 14, weight: .medium))
                            })
                            
                            Text("$\(viewModel.transactions.filter{$0.transaction_type == "Earning"}.map(\.amount).reduce(0, +))")
                                .foregroundColor(.black)
                                .font(.system(size: 19, weight: .semibold))
                        })
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            
                            HStack(content: {
                                
                                Image(systemName: "arrow.down")
                                    .foregroundColor(.red)
                                    .font(.system(size: 12, weight: .regular))
                                    .frame(width: 29, height: 29)
                                    .background(RoundedRectangle(cornerRadius: 5).fill(.red.opacity(0.2)))
                                
                                Text("Spent")
                                    .foregroundColor(.red)
                                    .font(.system(size: 14, weight: .medium))
                            })
                            
                            Text("$\(viewModel.transactions.filter{$0.transaction_type == "Spending"}.map(\.amount).reduce(0, +))")
                                .foregroundColor(.black)
                                .font(.system(size: 19, weight: .semibold))
                        })
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                    }
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            Text("Watchlist")
                                .foregroundColor(.black)
                                .font(.system(size: 23, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical)
                            
                            if propertyModel.saved_properties.isEmpty {
                                
                                VStack(alignment: .center, spacing: 10, content: {
                                    
                                    Text("Empty")
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, weight: .semibold))
                                        .multilineTextAlignment(.center)
                                    
                                    Text("You don’t have any properties in watchlist")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .multilineTextAlignment(.center)
                                })
                                .frame(height: 150)
                                
                            } else {
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    
                                    HStack {
                                        
                                        ForEach(propertyModel.getSavedProperties(), id: \.self) { index in
                                        
                                            VStack(alignment: .leading, spacing: 0) {
                                                
                                                Image(index.img ?? "")
                                                    .resizable()
                                                    .frame(width: 150, height: 90)
                                                    .cornerRadius(radius: 20, corners: [.topLeft, .topRight])
                                                    .overlay (
                                                    
                                                        VStack {
                                                                
                                                            HStack {
                                                                
                                                                Spacer()
                                                                
                                                                Button(action: {
                                                                    
                                                                    if propertyModel.saved_properties.contains(index.name ?? "") {
                                                                        
                                                                        if let index = propertyModel.saved_properties.firstIndex(of: index.name ?? "") {
                                                                            
                                                                            propertyModel.saved_properties.remove(at: index)
                                                                        }
                                                                        
                                                                    } else {
                                                                        
                                                                        propertyModel.saved_properties.append(index.name ?? "")
                                                                    }
                                                                    
                                                                }, label: {
                                                                    
                                                                    Image(systemName: propertyModel.saved_properties.contains(index.name ?? "") ? "heart.fill" : "heart")
                                                                        .foregroundColor(Color("primary"))
                                                                        .font(.system(size: 16, weight: .medium))
                                                                        .padding(7)
                                                                        .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.5)))
                                                                })
                                                            }
                                                            
                                                            Spacer()
                                                        }
                                                            .padding(9)
                                                    )
                                                
                                                VStack(alignment: .leading, spacing: 5, content: {
                                                    
                                                    Text(index.name ?? "")
                                                        .foregroundColor(.black)
                                                        .font(.system(size: 16, weight: .regular))
                                                        .multilineTextAlignment(.leading)
                                                        .lineLimit(2)
                                                    
                                                    Text("$\(index.price)")
                                                        .foregroundColor(.black)
                                                        .font(.system(size: 17, weight: .semibold))
                                                        .multilineTextAlignment(.leading)
                                                })
                                                .padding()
                                            }
                                            .background(RoundedRectangle(cornerRadius: 20).fill(.white))
                                        }
                                    }
                                }
                            }
                            
                            HStack {
                                
                                Text("Transactions")
                                    .foregroundColor(.black)
                                    .font(.system(size: 23, weight: .semibold))
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                    viewModel.isAddTransaction = true
                                    
                                }, label: {
                                    
                                    Image(systemName: "plus")
                                        .foregroundColor(.black)
                                        .font(.system(size: 16, weight: .bold))
                                })
                            }
                            .padding(.vertical)
                            
                            if viewModel.transactions.isEmpty {
                                
                                VStack(alignment: .center, spacing: 10, content: {
                                    
                                    Text("Empty")
                                        .foregroundColor(.black)
                                        .font(.system(size: 18, weight: .semibold))
                                        .multilineTextAlignment(.center)
                                    
                                    Text("You don’t have any transactions")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                        .multilineTextAlignment(.center)
                                })
                                .frame(height: 150)
                                
                            } else {
                                
                                ForEach(viewModel.transactions, id: \.self) { index in
                                    
                                    HStack {
                                        
                                        VStack(alignment: .leading, spacing: 3, content: {
                                            
                                            Text(index.location ?? "")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 13, weight: .regular))
                                            
                                            Text(index.property ?? "")
                                                .foregroundColor(.black)
                                                .font(.system(size: 16, weight: .semibold))
                                        })
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .trailing, spacing: 3, content: {
                                            
                                            Image(systemName: index.transaction_type == "Earning" ? "arrow.up" : "arrow.down")
                                                .foregroundColor(index.transaction_type == "Earning" ? .green : .red)
                                                .font(.system(size: 10, weight: .regular))
                                                .frame(width: 18, height: 18)
                                                .background(RoundedRectangle(cornerRadius: 5).fill(index.transaction_type == "Earning" ? .green.opacity(0.2) : .red.opacity(0.2)))
                                            
                                            if index.transaction_type == "Earning" {
                                                
                                                Text("+$\(index.amount)")
                                                    .foregroundColor(.green)
                                                    .font(.system(size: 16, weight: .semibold))
                                                
                                            } else {
                                                
                                                Text("-$\(index.amount)")
                                                    .foregroundColor(.red)
                                                    .font(.system(size: 16, weight: .semibold))
                                            }
                                        })
                                    }
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                                }
                            }
                        }
                    }
                }
                .padding([.horizontal, .top])
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(Rectangle().fill(.white.opacity(0.3)).cornerRadius(radius: 30, corners: [.topLeft, .topRight]).ignoresSafeArea())
            }
        }
        .onAppear {
            
            viewModel.fetchTransactions()
            propertyModel.fetchProperties()
        }
        .sheet(isPresented: $viewModel.isChart, content: {
            
            DashboardGraph()
        })
        .sheet(isPresented: $viewModel.isAddTransaction, content: {
            
            DashboardAdd(viewModel: viewModel)
        })
    }
}

#Preview {
    DashboardView()
}
