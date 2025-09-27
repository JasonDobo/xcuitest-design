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
                    }

                    NavigationLink(destination: FetchJsonView()) {
                        Text("Fetch View")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 4)
                    }
                }
            }
            .padding()
            .navigationTitle("First View")
        }
    }
}

#Preview {
    ContentView()
}
