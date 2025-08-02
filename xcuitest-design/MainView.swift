//
//  MainView.swift
//  xcuitest-design
//
//  Created by Jason Dobo on 05/04/2025.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Hello, world!")
            
            NavigationStack {
                VStack {
                    Spacer()
                    
                    Button(action: {
                        // Handled by NavigationLink below
                    }) {
                        NavigationLink(destination: FullScreenView()) {
                            Text("Go Full Screen")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .padding()
                        }
                    }
                    
                    Spacer()
                }
                .navigationTitle("Main View")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct FullScreenView: View {
    var body: some View {
        VStack {
            Text("This is a full screen view")
                .font(.largeTitle)
                .padding()

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.green.opacity(0.1))
        .navigationBarTitle("Full Screen", displayMode: .inline)
    }
}

#Preview {
    MainView()
}
