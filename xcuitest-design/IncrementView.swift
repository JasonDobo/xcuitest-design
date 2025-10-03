//
//  ContentUpdateView.swift
//  xcuitest-design
//
//  Created by Jason Dobo on 05/04/2025.
//

import SwiftUI

struct IncrementView: View {
    @State private var number: Int = 0

    var body: some View {
        VStack(spacing: 20) {
            TextField("Result", value: $number, formatter: NumberFormatter())
                .keyboardType(.numberPad)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .accessibilityIdentifier(Idenitifiers.IncrementView.total.rawValue)

            Button(action: {
                number += 1
            }) {
                Text("Increase")
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .accessibilityIdentifier(Idenitifiers.IncrementView.increase.rawValue)
            }
            Button(action: {
                number -= 1
            }) {
                Text("Decrease")
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .accessibilityIdentifier(Idenitifiers.IncrementView.decrease.rawValue)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.1))
    }
}

#Preview {
    IncrementView()
}

