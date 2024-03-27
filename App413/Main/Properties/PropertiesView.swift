//
//  PropertiesView.swift
//  App413
//
//  Created by Вячеслав on 3/22/24.
//

import SwiftUI

struct PropertiesView: View {
    
    @StateObject var propertyModel = PropertiesViewModel()
    
    var body: some View {
       
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("Properties")
                        .foregroundColor(.black)
                        .font(.system(size: 23, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        propertyModel.isAdd = true
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .font(.system(size: 13, weight: .semibold))
                            .frame(width: 34, height: 34)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                    })
                }
                .padding()
                
                VStack {
                    
                    HStack {
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            
                            HStack(content: {
                                
                                Image(systemName: "arrow.up")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12, weight: .regular))
                                    .frame(width: 29, height: 29)
                                    .background(RoundedRectangle(cornerRadius: 5).fill(.gray.opacity(0.2)))
                                
                                Text("Properties")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .medium))
                            })
                            
                            Text("\(propertyModel.properties.count)")
                                .foregroundColor(.black)
                                .font(.system(size: 19, weight: .semibold))
                        })
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            
                            HStack(content: {
                                
                                Image(systemName: "arrow.down")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 12, weight: .regular))
                                    .frame(width: 29, height: 29)
                                    .background(RoundedRectangle(cornerRadius: 5).fill(.gray.opacity(0.2)))
                                
                                Text("Earnings ones")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .medium))
                            })
                            
                            Text("\(0)")
                                .foregroundColor(.black)
                                .font(.system(size: 19, weight: .semibold))
                        })
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                    }
                    .padding([.horizontal, .bottom])
                    
                    if propertyModel.properties.isEmpty {
                        
                        VStack(alignment: .center, spacing: 10, content: {
                            
                            Text("Empty")
                                .foregroundColor(.black)
                                .font(.system(size: 18, weight: .semibold))
                                .multilineTextAlignment(.center)
                            
                            Text("You don’t have any properties")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .multilineTextAlignment(.center)
                        })
                        .frame(maxHeight: .infinity, alignment: .center)
                        
                    } else {
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            LazyVStack {
                                
                                ForEach(propertyModel.properties, id: \.self) { index in
                                
                                    NavigationLink(destination: {
                                        
                                        DashboardDetail(index: index)
                                            .navigationBarBackButtonHidden()
                                        
                                    }, label: {
                                        
                                        VStack(alignment: .leading, spacing: 0) {
                                            
                                            Image(index.img ?? "")
                                                .resizable()
                                                .frame(height: 150)
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
                                                .cornerRadius(radius: 20, corners: [.topLeft, .topRight])
                                            
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
                                    })
                                }
                            }
                            .padding()
                        }
                    }
                }
                .padding(.top)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(Rectangle().fill(.white.opacity(0.3)).cornerRadius(radius: 30, corners: [.topLeft, .topRight]).ignoresSafeArea())
            }
        }
        .onAppear {
            
            propertyModel.fetchProperties()
        }
        .sheet(isPresented: $propertyModel.isAdd, content: {
            
            PropertiesAdd(viewModel: propertyModel)
        })
    }
}

#Preview {
    PropertiesView()
}
