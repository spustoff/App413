//
//  DashboardDetail.swift
//  App413
//
//  Created by Вячеслав on 3/22/24.
//

import SwiftUI

struct DashboardDetail: View {
    
    let index: PropertyModel
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image(index.img ?? "")
                    .resizable()
                    .frame(height: 300)
                    .overlay (
                    
                        VStack {
                            
                            HStack {
                                
                                Button(action: {
                                    
                                    router.wrappedValue.dismiss()
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        Image(systemName: "chevron.left")
                                            .foregroundColor(Color.white)
                                            .font(.system(size: 16, weight: .regular))
                                        
                                        Text("Back")
                                            .foregroundColor(Color.white)
                                            .font(.system(size: 16, weight: .regular))
                                    }
                                })
                                
                                Spacer()
                            }
                            
                            Spacer()
                        }
                            .padding()
                            .padding(.top, 55)
                    )
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack(alignment: .leading) {
                        
                        VStack(alignment: .leading, spacing: 5, content: {
                            
                            Text(index.name ?? "")
                                .foregroundColor(.black)
                                .font(.system(size: 23, weight: .semibold))
                            
                            Text(index.text ?? "")
                                .foregroundColor(.gray)
                                .font(.system(size: 17, weight: .regular))
                        })
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 5, content: {
                                
                                Text("Price")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                                
                                Text("$\(index.price ?? 0)")
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .semibold))
                            })
                            .padding()
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                            
                            VStack(alignment: .leading, spacing: 5, content: {
                                
                                Text("Size")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                                
                                Text("10K sq. ft.")
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .semibold))
                            })
                            .padding()
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                            
                            VStack(alignment: .leading, spacing: 5, content: {
                                
                                Text("Location")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                                
                                Text(index.location ?? "")
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .semibold))
                            })
                            .padding()
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                        }
                        
                        VStack(alignment: .leading, spacing: 5, content: {
                            
                            Text("Property Type")
                                .foregroundColor(.gray)
                                .font(.system(size: 13, weight: .regular))
                            
                            Text(index.property_type ?? "")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .semibold))
                        })
                        .padding()
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                    }
                    .padding()
                }
            }
            .ignoresSafeArea(.all, edges: .top)
        }
    }
}

//#Preview {
//    DashboardDetail()
//}
