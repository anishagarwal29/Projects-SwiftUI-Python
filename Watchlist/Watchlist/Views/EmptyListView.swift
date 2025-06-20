//
//  EmptyListView.swift
//  Watchlist
//
//  Created by Anish Agarwal on 2/6/25.
//

import SwiftUI

struct EmptyListView: View {
    // MARK: - Properties
    
    
    // MARK: - Body
    var body: some View {
        ContentUnavailableView {
            Circle()
                .fill(.blue.gradient)
                .stroke(.blue.gradient.opacity(0.15), lineWidth: 30)
                .stroke(.blue.gradient.opacity(0.15), lineWidth: 60)
                .stroke(.blue.gradient.opacity(0.15), lineWidth: 90)
                .frame(width: 180)
                .overlay {
                    Image(systemName: "movieclapper")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .foregroundStyle(Color(UIColor.secondarySystemBackground))
                        .padding(.top, 6)
                }
                .padding(.bottom, 90)
        } description: {
            GroupBox {
                TabView {
                    
                    PageTabView(icon: "1.circle", description: "Add some movies to the playlist if you plan to watch later")
                        .padding(.bottom, 36)
                    
                    PageTabView(icon: "2.circle", description: "Later on you can also choose a random film to watch")
                        .padding(.bottom, 36)
                }
                
                
            } //: GROUPBOX
            .tabViewStyle(PageTabViewStyle())
            .frame(minWidth: 0, maxWidth: 560, minHeight: 130, maxHeight: 200)
        }
        
    }
}


// MARK: - Properties
#Preview {
    EmptyListView()
}
