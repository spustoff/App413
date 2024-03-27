//
//  PropertiesAdd.swift
//  App413
//
//  Created by Вячеслав on 3/22/24.
//

import SwiftUI

struct PropertiesAdd: View {
    
    @StateObject var viewModel: PropertiesViewModel
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
                    
                    Text("Add Property")
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
                        
                        Menu {
                            
                            ForEach(["house"], id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.image = index
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        Image(index)
                                    }
                                })
                            }
                            
                        } label: {
                            
                            if viewModel.image.isEmpty {
                                
                                Image(systemName: "camera.fill")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 150)
                                    .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                            } else {
                                
                                Image(viewModel.image)
                                    .resizable()
                                    .frame(height: 150)
                            }
                        }
                        
                        HStack {
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Name")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.name.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.name)
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .regular))
                            })
                            
                            Spacer()
                        }
                        .padding()
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                        
                        Menu {
                            
                            ForEach(["Available", "Not Available"], id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.status = index
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        Text(index)
                                        
                                        if viewModel.status == index {
                                            
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                })
                            }
                            
                        } label: {
                            
                            HStack {
                                
                                Text(viewModel.status.isEmpty ? "Status" : viewModel.status)
                                    .foregroundColor(viewModel.status.isEmpty
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
                                
                                Text("Description")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.text.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.text)
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .regular))
                            })
                            
                            Spacer()
                        }
                        .padding()
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                        .padding(.bottom)
                        
                        HStack {
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Price")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.price.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.price)
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .regular))
                                    .keyboardType(.decimalPad)
                            })
                            
                            Spacer()
                        }
                        .padding()
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                        
                        HStack {
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Location")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.location.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.location)
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .regular))
                            })
                            
                            Spacer()
                        }
                        .padding()
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                        
                        HStack {
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Property Type")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.property_type.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.property_type)
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .regular))
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
                    
                    viewModel.addProperty()
                    viewModel.fetchProperties()
                    
                    router.wrappedValue.dismiss()
                    
                    viewModel.image = ""
                    viewModel.name = ""
                    viewModel.status = ""
                    viewModel.text = ""
                    viewModel.price = ""
                    viewModel.location = ""
                    viewModel.property_type = ""
                    
                }, label: {
                    
                    Text("Add")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary")))
                        .padding()
                })
                .opacity(viewModel.image.isEmpty || viewModel.name.isEmpty || viewModel.status.isEmpty || viewModel.text.isEmpty || viewModel.price.isEmpty || viewModel.location.isEmpty || viewModel.property_type.isEmpty ? 0.5 : 1)
                .disabled(viewModel.image.isEmpty || viewModel.name.isEmpty || viewModel.status.isEmpty || viewModel.text.isEmpty || viewModel.price.isEmpty || viewModel.location.isEmpty || viewModel.property_type.isEmpty ? true : false)
            }
        }
    }
}

#Preview {
    PropertiesAdd(viewModel: PropertiesViewModel())
}
