//
//  ToolBarView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/1/23.
//

import SwiftUI

struct ToolBarView: View {
    @Environment(\.colorScheme) var colorScheme

    @Binding var recommendations: [String]
    var symbols: [String] = ["\"", "$", "{", "}", "(", ")", "=", "//", "!", ">>", ":", ">", "<"]
    
    @Binding var canUndo: Bool
    @Binding var canRedo: Bool

    var insertText: (String) -> ()
    
    var undo: () -> ()
    var redo: () -> ()
    
    var openDocumentation: () -> ()
    var build: () -> ()
    
    var body: some View {
        VStack {
            topRow()
            bottomRow()
        }
        .padding(10)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .shadow(color: .primary.opacity(0.1), radius: 5)
        .padding(.horizontal, 15)
        .padding(.bottom, 5)
    }
    
    @ViewBuilder
    private func topRow() -> some View {
        HStack {
            Button {
                undo()
            } label: {
                Label(.undo)
                    .labelStyle(.iconOnly)
            }
            .disabled(!canUndo)
            Button {
                redo()
            } label: {
                Label(.redo)
                    .labelStyle(.iconOnly)
            }
            .disabled(!canRedo)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(symbols, id: \.self) { text in
                        Button {
                            insertText(text)
                        } label: {
                            insertOptionCell(text: text)
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func bottomRow() -> some View {
        HStack {
            Button {
                openDocumentation()
            } label: {
                Label(.documentation)
                    .labelStyle(.iconOnly)
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(recommendations, id: \.self) { text in
                        Button {
                            insertText(text)
                        } label: {
                            insertOptionCell(text: text)
                        }
                    }
                }
            }
            Button {
                build()
            } label: {
                Label(.build)
                    .labelStyle(.iconOnly)
            }
        }
    }

    
    @ViewBuilder
    private func insertOptionCell(text: String) -> some View {
        HStack {
            Text(text)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(Color(uiColor: colorScheme == .dark ? .systemGray5 : .systemGray2))
        .cornerRadius(10)
    }

}

//struct ToolBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        ToolBarView(insertText: { _ in
//            
//        }, recommendations: .constant(["\"", "$", "{", "}", "(", ")", "=", "//", "!", ">>", ":", ">", "<"]))
//    }
//    
//}
