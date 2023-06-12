//
//  IconCreator.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/28/23.
//

import SwiftUI
import Open_Jellycore

struct IconCreator: View {
    @State private var selectedGlyph: ShortcutGlyph = .shortcuts
    @State private var selectedColor: ShortcutColor = .red
    
    @State private var searchText: String = ""
    @State private var presentProMode: Bool = false
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                Section {
                    LazyVStack(alignment: .leading) {
                        ForEach(ShortcutGlyph.allCases.filter({ filterGlyph(glyph: $0, search: searchText) })) { glyph in
                            Button {
                                if PurchaseHandler.isProMode {
                                    selectedGlyph = glyph
                                } else {
                                    presentProMode.toggle()
                                }
                            } label: {
                                HStack(spacing: 15) {
                                    shortcutsGlyph(glyph: glyph, color: selectedColor, width: 25, height: 25)
                                    VStack(alignment: .leading) {
                                        Text(glyph.rawValue)
                                            .foregroundColor(.primary)
                                        Text(glyph.version.name)
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                    }
                    .fakeInsetGrouped()
                } header: {
                    headerView()
                }
            }
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .searchable(text: $searchText)
        .navigationTitle("Icon Creator")
        .withProSheet(isPresented: $presentProMode)
    }
    
    @ViewBuilder
    private func headerView() -> some View {
        VStack(spacing: 10) {
            HStack(alignment: .center) {
                Spacer()
                shortcutsGlyph(glyph: selectedGlyph, color: selectedColor)
                Spacer()
            }
            CodeBlock(text: "#Icon: \(selectedGlyph.rawValue), #Color: \(selectedColor.rawValue)")
                .font(.callout)
            Divider()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(ShortcutColor.allCases) { color in
                        Circle()
                            .fill(
                                LinearGradient(colors: [
                                    Color(hex: color.gradient.top),
                                    Color(hex: color.gradient.bottom)],
                                               startPoint: .top, endPoint: .bottom)
                            )
                            .overlay {
                                if selectedColor.id == color.id {
                                    Circle()
                                        .stroke(Color.accentColor, lineWidth: 2)
                                }
                            }
                            .frame(width: 30, height: 30)
                            .padding(1)
                            .onTapGesture {
                                if PurchaseHandler.isProMode {
                                    selectedColor = color
                                } else {
                                    presentProMode.toggle()
                                }
                            }
                    }
                }
            }
        }
        .fakeInsetGrouped()
        .shadow(color: .primary.opacity(0.2), radius: 5)
    }

    
    @ViewBuilder
    private func shortcutsGlyph(glyph: ShortcutGlyph, color: ShortcutColor, width: CGFloat = 45, height: CGFloat = 45) -> some View {
        Image("\(glyph.id)")
            .resizable()
            .frame(width: width, height: height)
            .padding(10)
            .background {
                LinearGradient(colors: [
                    Color(hex: color.gradient.top),
                    Color(hex: color.gradient.bottom)],
                               startPoint: .top, endPoint: .bottom)
            }
            .cornerRadius(45 / 6)
    }
    
    private func filterGlyph(glyph: ShortcutGlyph, search: String) -> Bool {
        if search.isEmpty {
            return true
        }
        return glyph.rawValue.lowercased().contains(search.lowercased()) || search.lowercased().contains(glyph.rawValue.lowercased())
    }
}

struct IconCreator_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            IconCreator()
        }
    }
}
