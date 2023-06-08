//
//  SettingsThemeSelector.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/8/23.
//

import SwiftUI
import RunestoneThemes

struct SettingsThemeSelector: View {
    @StateObject var editorConfig = RunestoneEditorConfig()
    
    @State var text: String = """
    import Shortcuts
    #Color: red
    #Icon: shortcuts
    
    func hello(name) {
        text(text: "Hello ${name}!") >> Text
        quicklook(input: Text)
    }
    
    hello("Taylor")
    """
    
    @Binding var selectedTheme: EditorTheme
    
    var body: some View {
        VStack {
            RunestoneEditor(text: $text, config: editorConfig)
                .frame(height: 150)
                .cornerRadius(7)
                .shadow(radius: 7)
                .padding(20)
            List {
                Section("Standard Themes") {
                    ForEach(EditorTheme.allCases) { theme in
                        HStack {
                            Button(theme.name) {
                                editorConfig.lightTheme = theme
                                editorConfig.darkTheme = theme
                                selectedTheme = theme
                            }
                            Spacer()
                            if selectedTheme == theme {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.accentColor)
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Theme Selector")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            editorConfig.lightTheme = selectedTheme
            editorConfig.darkTheme = selectedTheme
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
