//
//  ConsoleView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/1/23.
//

import SwiftUI

struct ConsoleView: View {
    enum ConsoleState {
        case minimizedCircle
        case minimizedLong
        case maximized
    }
    
    @Binding var warningCount: Int
    @Binding var errorCount: Int
    @Binding var consoleText: NSAttributedString
    @State var consoleState: ConsoleState = .minimizedLong
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                withAnimation {
                    if consoleState == .maximized {
                        consoleState = .minimizedLong
                    } else {
                        consoleState = .maximized
                    }
                }
            } label: {
                HStack {
                    Text("Console")
                        .bold()
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: consoleState == .maximized ? "chevron.compact.down" : "chevron.compact.up")
                        .foregroundColor(.secondary)
                    Spacer()
                    Label("\(warningCount)", systemImage: "exclamationmark.triangle.fill")
                        .font(.callout)
                        .imageScale(.small)
                        .foregroundColor(.yellow)
                    Label("\(errorCount)", systemImage: "exclamationmark.octagon.fill")
                        .font(.callout)
                        .imageScale(.small)
                        .foregroundColor(.red)
                }
            }
            if consoleState == .maximized {
                ScrollViewReader { reader in
                    ScrollView {
                        Text(AttributedString(consoleText))
                            .font(.system(size: 13, design: .monospaced))
                            .multilineTextAlignment(.leading)
                            .id(0)
                            .onChange(of: consoleText) { newValue in
                                reader.scrollTo(0, anchor: .bottom)
                            }
                            .onAppear {
                                print(consoleText.string)
                            }
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .shadow(color: .primary.opacity(0.1), radius: 5)
        .padding(.horizontal, 15)
        .padding(.bottom, 5)
    }
}

struct ConsoleView_Previews: PreviewProvider {
    static var previews: some View {
        ConsoleView(warningCount: .constant(3), errorCount: .constant(1), consoleText: .constant(NSAttributedString("Hello World")))
    }
}
