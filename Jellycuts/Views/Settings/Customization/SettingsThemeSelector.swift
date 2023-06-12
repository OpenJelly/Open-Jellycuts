//
//  SettingsThemeSelector.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/8/23.
//

import SwiftUI
import RunestoneThemes

struct SettingsThemeSelector: View {
    @State private var presentProMode: Bool = false
    
    @Binding var selectedTheme: EditorTheme
    
    var body: some View {
        VStack {
            List {
                Section("Standard Themes") {
                    ForEach(EditorTheme.allCases) { theme in
                        AppearanceEditor(theme: theme, selectedTheme: $selectedTheme)
                    }
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Theme Selector")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    struct AppearanceEditor: View {
        @StateObject var editorConfig = RunestoneEditorConfig()

        @State var text: String = """
        import Shortcuts
        #Color: red #Icon: shortcuts
        
        func hello(name) {
            text(text: "Hello ${name}!") >> Text
            quicklook(input: Text)
        }
        
        hello("Taylor")
        """
        
        @State var theme: EditorTheme
        @Binding var selectedTheme: EditorTheme
        @State private var presentingProView: Bool = false

        init(theme: EditorTheme, selectedTheme: Binding<EditorTheme>) {
            self.theme = theme
            self._selectedTheme = selectedTheme
        }
        
        var body: some View {
            VStack {
                HStack {
                    Button(theme.name) {
                        if PurchaseHandler.isProMode {
                            selectedTheme = theme
                        } else {
                            presentingProView.toggle()
                        }
                    }
                    .font(.headline)
                    Spacer()
                    if selectedTheme == theme {
                        Image(systemName: "checkmark")
                            .foregroundColor(.accentColor)
                    }
                }
                RunestoneEditor(text: $text, config: editorConfig, interactionEnabled: false)
                    .frame(height: 150)
                    .cornerRadius(7)
                    .shadow(radius: 7)
            }
            .onAppear {
                editorConfig.lightTheme = theme
                editorConfig.darkTheme = theme
            }
            .withProSheet(isPresented: $presentingProView)
        }
    }
}

struct SettingsThemeSelector_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsThemeSelector(selectedTheme: .constant(.catppuccinLatte))
        }
    }
}

