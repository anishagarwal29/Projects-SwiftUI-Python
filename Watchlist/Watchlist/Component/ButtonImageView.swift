//
//  ButtonImageView.swift
//  Watchlist
//
//  Created by Anish Agarwal on 6/6/25.
//

import SwiftUI

struct ButtonImageView: View {
    // MARK: - Properties
    
    let symbolName: String
    
    // MARK: - Body
    var body: some View {
        Image(systemName: symbolName)
            .resizable()
            .scaledToFit()
            .foregroundStyle(.blue.gradient)
            .padding(8)
            .background(
                Circle()
                    .fill(.ultraThickMaterial)
            )
            .frame(width: 80)
    }
}

// MARK: - Preview
#Preview {
    ButtonImageView(symbolName: "plus.circle.fill")
}
