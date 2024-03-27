//
//  TabBar.swift
//  App413
//
//  Created by Вячеслав on 3/22/24.
//

import SwiftUI

struct TabBar: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        
        HStack {
            
            ForEach(Tab.allCases, id: \.self) { index in
                
                Button(action: {
                    
                    selectedTab = index
                    
                }, label: {
                    
                    Image(index.rawValue)
                        .renderingMode(.template)
                        .foregroundColor(selectedTab == index ? .black : .gray)
                        .frame(height: 25)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                        .background(Capsule().fill(Color("primary")).opacity(selectedTab == index ? 1 : 0))
                })
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Capsule().fill(.white))
        .padding(.horizontal)
        .background(Color.white.opacity(0.3).ignoresSafeArea())
    }
}

enum Tab: String, CaseIterable {
    
    case Dashboard = "Dashboard"
    
    case Properties = "Properties"
    
    case Settings = "Settings"
}


#Preview {
    
    ContentView()
}
