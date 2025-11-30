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
    @Query(sort: \Renshu.createdAt) private var renshus: [Renshu]

    @State private var title = ""
    @State private var subtitle = ""
    @State private var imageName = ""
    @State private var baseXP: Int = 10
    @State private var selectedCategories: Set<Category> = [.cognitive]
    @State private var editingRenshu: Renshu?

    var body: some View {
        ZStack {
            // Background image
            Image("bg design v3")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.container, edges: .top)
            VStack(alignment: .leading, spacing: 15) {
                // Header
                PageHeader(title: "Renshū Hub")
            // Content - respects safe area automaticallyj
            Form {
                Section(editingRenshu != nil ? "Edit Renshū" : "New Renshū") {
                    TextField("Title", text: $title)
                        .foregroundColor(Color.theme900)
                    TextField("Subtitle", text: $subtitle)
                        .foregroundColor(.textPrimary)
                    TextField("Image Name (optional, default: shukan-0)", text: $imageName)
                        .foregroundColor(.textPrimary)
                    Stepper("Base XP: \(baseXP)", value: $baseXP, in: 1 ... 100)

                    if editingRenshu != nil {
                        Button("Cancel Editing") {
                            clearForm()
                        }
                        .foregroundColor(.red)
                    }
                }
                .listRowBackground(Color.cardBackground)

                Section("Categories") {
                    ForEach(Category.allCases, id: \.self) { category in
                        Toggle(category.rawValue, isOn: Binding(
                            get: { selectedCategories.contains(category) },
                            set: { isOn in
                                if isOn {
                                    selectedCategories.insert(category)
                                } else {
                                    selectedCategories.remove(category)
                                }
                                // Ensure at least one category is selected
                                if selectedCategories.isEmpty {
                                    selectedCategories.insert(.cognitive)
                                }
                            }
                        ))
                    }
                }
                .listRowBackground(Color.cardBackground)

                Section("Existing Renshū") {
                    if renshus.isEmpty {
                        Text("No renshū yet")
                            .foregroundColor(.textSecondary)
                    } else {
                        ForEach(renshus) { renshu in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(renshu.title)
                                    .font(.headline)
                                    .foregroundColor(.textPrimary)
                                Text(renshu.subtitle)
                                    .font(.subheadline)
                                    .foregroundColor(.textSecondary)
                                if renshu.imageName != "shukan-0" {
                                    Text("Image: \(renshu.imageName)")
                                        .font(.caption)
                                        .foregroundColor(.textSecondary)
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
                .listRowBackground(Color.cardBackground)
            }
            .scrollContentBackground(.hidden)
            .tint(.textPrimary)
        }.safeAreaPadding(.top)
        .padding(.top, LayoutConstants.coreVstackPadding)
        }
        // Bring this into the form?
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
        }
    }

    private func editRenshu(_ renshu: Renshu) {
        editingRenshu = renshu
        title = renshu.title
        subtitle = renshu.subtitle
        imageName = renshu.imageName
        baseXP = renshu.baseXP
        selectedCategories = Set(renshu.categories)
    }

    private func clearForm() {
        editingRenshu = nil
        title = ""
        subtitle = ""
        imageName = ""
        baseXP = 10
        selectedCategories = [.cognitive]
    }

    private func saveNewRenshu() {
        let image = imageName.isEmpty ? "shukan-0" : imageName
        let categories = Array(selectedCategories)
        let renshu = Renshu(
            title: title,
            subtitle: subtitle,
            imageName: image,
            baseXP: baseXP,
            categories: categories
        )
        context.insert(renshu)

        // Ensure save completes
        do {
            try context.save()
        } catch {
            print("Error saving renshu: \(error)")
        }

        clearForm()
    }

    private func updateRenshu(_ renshu: Renshu) {
        renshu.title = title
        renshu.subtitle = subtitle
        renshu.imageName = imageName.isEmpty ? "shukan-0" : imageName
        renshu.baseXP = baseXP
        renshu.categories = Array(selectedCategories)
        try? context.save()
        clearForm()
    }

    private func deleteRenshus(at offsets: IndexSet) {
        for index in offsets {
            context.delete(renshus[index])
        }
    }
}
