//
//  RenshuHub.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import SwiftData
import SwiftUI

struct RenshuHub: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Renshu.createdAt) private var renshus: [Renshu]

    @State private var title = ""
    @State private var subtitle = ""
    @State private var imageName = ""
    @State private var editingRenshu: Renshu?

    var body: some View {
        Form {
            Section(editingRenshu != nil ? "Edit Renshū" : "New Renshū") {
                TextField("Title", text: $title)
                TextField("Subtitle", text: $subtitle)
                TextField("Image Name (optional, default: shukan-0)", text: $imageName)

                if editingRenshu != nil {
                    Button("Cancel Editing") {
                        clearForm()
                    }
                    .foregroundColor(.red)
                }
            }

            Section("Existing Renshū") {
                if renshus.isEmpty {
                    Text("No renshū yet")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(renshus) { renshu in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(renshu.title)
                                .font(.headline)
                            Text(renshu.subtitle)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            if renshu.imageName != "shukan-0" {
                                Text("Image: \(renshu.imageName)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            editRenshu(renshu)
                        }
                    }
                    .onDelete(perform: deleteRenshus)
                }
            }
        }
        .navigationTitle(editingRenshu != nil ? "Edit Renshū" : "New Renshū")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(editingRenshu != nil ? "Update" : "Save") {
                    if let renshu = editingRenshu {
                        updateRenshu(renshu)
                    } else {
                        saveNewRenshu()
                    }
                }
                .disabled(title.isEmpty)
            }

            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") { dismiss() }
            }
        }
    }

    private func editRenshu(_ renshu: Renshu) {
        editingRenshu = renshu
        title = renshu.title
        subtitle = renshu.subtitle
        imageName = renshu.imageName
    }

    private func clearForm() {
        editingRenshu = nil
        title = ""
        subtitle = ""
        imageName = ""
    }

    private func saveNewRenshu() {
        let image = imageName.isEmpty ? "shukan-0" : imageName
        let renshu = Renshu(title: title, subtitle: subtitle, imageName: image)
        context.insert(renshu)
        dismiss()
    }

    private func updateRenshu(_ renshu: Renshu) {
        renshu.title = title
        renshu.subtitle = subtitle
        renshu.imageName = imageName.isEmpty ? "shukan-0" : imageName
        dismiss()
    }

    private func deleteRenshus(at offsets: IndexSet) {
        for index in offsets {
            context.delete(renshus[index])
        }
    }
}

