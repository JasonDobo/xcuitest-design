//
//  ContentView.swift
//  xcuitest-design
//
//  Created by Jason Dobo on 02/04/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)

                Text("Hello world")
                    .accessibilityIdentifier(Idenitifiers.FirstView.helloText.rawValue)

                Button(action: {
                    print("Button was tapped!")
                }) {
                    Text("Tap Me")
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: 200)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .accessibilityIdentifier(Idenitifiers.FirstView.tapMe.rawValue)
                }

                Spacer()

                HStack {
                    Text("Navigation")
                        .padding()

                    NavigationLink(destination: IncrementView()) {
                        Text("Increment View")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 4)
                            .accessibilityIdentifier(Idenitifiers.Navigation.incrementView.rawValue)
                    }

                    NavigationLink(destination: FetchJsonView()) {
                        Text("Fetch View")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 4)
                            .accessibilityIdentifier(Idenitifiers.Navigation.fetchView.rawValue)
                    }
                }
            }
            .padding()
            .navigationTitle("First View")
        }.accessibilityIdentifier("First View")
    }
}

#Preview {
    ContentView()
}
