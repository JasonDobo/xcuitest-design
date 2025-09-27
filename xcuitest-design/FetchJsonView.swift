//
//  SampleFetchView.swift
//  xcuitest-design
//
//  Created by Jason Dobo on 09/27/2025.
//

import SwiftUI

private struct Todo: Decodable, Sendable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

struct FetchJsonView: View {
    @State private var todo: Todo?
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 16) {
            Group {
                if isLoading {
                    ProgressView("Loading…")
                } else if let todo {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("User ID: \(todo.userId)")
                        Text("ID: \(todo.id)")
                        Text("Title: \(todo.title)")
                        Text("Completed: \(todo.completed ? "Yes" : "No")")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                } else if let errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                } else {
                    Text("No data yet.")
                        .foregroundStyle(.secondary)
                }
            }
            .frame(maxWidth: .infinity)

            Button(action: { Task { await load() } }) {
                Label("Reload", systemImage: "arrow.clockwise")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Sample Fetch")
        .task { await load() }
    }

    private func load() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        defer { Task { @MainActor in isLoading = false } }

        do {
            let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
            let (data, response) = try await URLSession.shared.data(from: url)
            if let http = response as? HTTPURLResponse, !(200..<300).contains(http.statusCode) {
                throw URLError(.badServerResponse)
            }
            let todo = try JSONDecoder().decode(Todo.self, from: data)
            await MainActor.run { self.todo = todo }
        } catch {
            await MainActor.run { self.errorMessage = "Failed to load: \(error.localizedDescription)" }
        }
    }
}

#Preview {
    NavigationStack {
        FetchJsonView()
    }
}
