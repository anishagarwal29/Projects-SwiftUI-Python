//
//  PageTabView.swift
//  Watchlist
//
//  Created by Anish Agarwal on 2/6/25.
//

import SwiftUI

struct PageTabView: View {
    // MARK: - Properties
    var icon: String
    var description: String
    
    
    // MARK: - Body
    var body: some View {
        VStack {
            Image(systemName: icon)
                .imageScale(.large)
                .font(.largeTitle.weight(.light))
                .symbolEffect(.breathe)
            
            Text(description)
                .font(.title.weight(.light))
                .fontWidth(.compressed)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}


// MARK: - Preview
#Preview {
    PageTabView(icon: "1.circle", description: "Add some movies to the watchlist if you plan to watch later")
        .padding()
    
}
