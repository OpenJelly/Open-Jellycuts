//
//  ProPurchaseView.swift
//  Jellycuts
//
//  Created by Taylor lineman on 7/13/22.
//

import SwiftUI
import ConfettiSwiftUI
import BetterSafariView
import StoreKit

struct ProPurchaseView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var appearanceManager: AppearanceManager

    @StateObject private var viewModel = ProPurchaseViewModel()
    @State private var optionsExpanded: Bool = true
    @State private var safariURL: URL?
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    Image("Jellycuts Pro")
                        .resizable()
                        .aspectRatio(4.7199579832, contentMode: .fit)
                        .frame(height: 45)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 45)
                    Divider()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            purchaseSquare {
                                Image("Supercharged")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 32)
                                PerkRow(title: "Connect your favorite Apps!", message: "Use actions provided by tons of shortcuts companion apps!", systemImage: "apps.iphone", systemImageColor: .pink)
                                PerkRow(title: "Light Speed Development", message: "Connect directly into VSCode to use the full power of a desktop for Jellycuts development!", systemImage: "desktopcomputer.and.arrow.down", systemImageColor: .orange)
                                PerkRow(title: "Power Tools. For Power Users", message: "Get access to a robust JSON editing and a beautiful Icon Creator.", systemImage: "wrench.and.screwdriver.fill", systemImageColor: .mint)
                            }
                            .padding(.leading, 15)
                            purchaseSquare {
                                HStack {
                                    Image("Personalized")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 28)
                                    Spacer()
                                }
                                PerkRow(title: "Highlight your heart!", message: "50+ Editor themes allow you to pick the perfect syntax colors for you!", systemImage: "text.alignleft", systemImageColor: .cyan)
                                PerkRow(title: "Taste the fonts", message: "With tons of font flavors, you can find what suits you the best.", systemImage: "textformat", systemImageColor: .indigo)
                                PerkRow(title: "Get on the Icon Train!", message: "With an ew icon every major update, you can keep your home screen looking great!", image: "AppIcon-I")
                            }
                            purchaseSquare {
                                VStack(alignment: .center) {
                                    Image(systemName: "figure.wave")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(.indigo)
                                        .frame(height: 70)
                                    Text("Support Development")
                                        .font(.system(.title3, design: .rounded))
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .padding(.bottom, 1)
                                    Text("Hey! I'm Taylor! Jellycuts is my passion project. I have been working on it for over two years to make it the perfect app for people looking to get the most out of Shortcuts.\n\nCurrently, I am studying in college. By supporting Jellycuts, you are allowing me to consistently work on the app and helping to put me through college!")
                                        .font(.system(.subheadline, design: .rounded))
                                        .fontWeight(.regular)
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.center)
                                }
                                .padding(.vertical, 10)
                            }
                            purchaseSquare {
                                userReviewTab(title: "Very Versatile!", message: "Very helpful even without much programming knowledge. A lot of potential to get the most out of shortcuts. Beautiful App Icon designs and the app is also very visually appealing", dedication: "Flototype", location: "Germany")
                            }
                            .padding(.trailing, 15)
                        }
                    }
                    .padding(.vertical, 15)
                }
            }
            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .foregroundColor(.secondary.opacity(0.6))
                            .frame(width: 20, height: 20)
                    }
                }
                .padding(20)
                Spacer()
                VStack {
                    Divider()
                    if viewModel.products.isEmpty {
                        ProgressView()
                    } else {
                        if optionsExpanded {
                            ForEach(viewModel.products, id: \.productIdentifier) { product in
                                PurchaseButton(title: product.localizedTitle, price: formatPrice(product: product), id: product.productIdentifier, selectedPurchase: $viewModel.selectedPurchase)
                            }
                        } else {
                            if let product = viewModel.products.first(where: { product in
                                return product.productIdentifier == viewModel.selectedPurchase.rawValue
                            }) {
                                PurchaseButton(title: product.localizedTitle, price: formatPrice(product: product), id: product.productIdentifier, selectedPurchase: $viewModel.selectedPurchase)
                            }
                        }
                        if viewModel.isPurchasing  {
                            ProgressView()
                                .frame(height: 45)
                                .padding(.top, 5)
                        } else {
                            Button {
                                viewModel.purchaseSelectedItem()
                            } label: {
                                Text("Continue")
                                    .font(.system(.title3, design: .rounded))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .frame(height: 45)
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .cornerRadius(45)
                            .padding(EdgeInsets(top: 5, leading: 15, bottom: 0, trailing: 15))
                            .contentShape(Rectangle())
                            .confettiCannon(counter: $viewModel.confettiCounter, confettis: [.text("❤️"), .text("💙"), .text("💚"), .text("🧡")], confettiSize: 20, repetitions: 5, repetitionInterval: 0.7)
                            .onChange(of: viewModel.confettiCounter) { newValue in
                                Task {
                                    try? await Task.sleep(nanoseconds: UInt64(5e9))
                                    dismiss()
                                }
                            }
                        }
                    }
                    HStack {
                        Button {
                            withAnimation {
                                optionsExpanded.toggle()
                            }
                        } label: {
                            Text(optionsExpanded ? "Show Concise Options" : "Show All Support Options")
                                .foregroundColor(.secondary)
                                .font(.callout)
                        }
                        Spacer()
                        Button {
                            viewModel.restorePurchases()
                        } label: {
                            Text("Restore Purchases")
                                .foregroundColor(.secondary)
                                .font(.callout)
                        }
                        .padding([.leading, .trailing])
                    }
                    .padding([.leading, .trailing])
                }
                .background(Color(uiColor: .systemBackground))
            }
        }
        .rounded()
        .tint(appearanceManager.accentColor.color)
        .safariView(item: $safariURL) { url in
            SafariView(url: url)
        }
        .alert("An Error Occurred", isPresented: $viewModel.presentErrorView) {
            Link(destination: Links.jellycutsGithubPage) {
                Text("Report Bug")
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage)
        }
    }
    
    func formatPrice(product: SKProduct) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = product.priceLocale
        return numberFormatter.string(from: product.price) ?? ""
    }
    
    struct PurchaseButton: View {
        @State var title: String
        @State var price: String
        @State var id: String
        
        @Binding var selectedPurchase: PurchaseHandler.JellycutsProduct
        
        var body: some View {
            HStack {
                Image(systemName: (selectedPurchase.rawValue == id) ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.accentColor)
                Text(title)
                    .font(.body)
                    .bold()
                Spacer()
                Text(price)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .contentShape(Rectangle())
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            .background((selectedPurchase.rawValue == id) ? Color(uiColor: .systemGray5) : .clear)
            .cornerRadius(7)
            .padding([.leading, .trailing])
            .onTapGesture {
                withAnimation {
                    guard let purchase = PurchaseHandler.JellycutsProduct.init(rawValue: id) else { return }
                    selectedPurchase = purchase
                }
            }
        }
    }
    
    struct PerkRow: View {
        var title: String
        var message: String
        var image: String? = nil
        var systemImage: String? = nil
        var systemImageColor: Color = .accentColor

        var body: some View {
            HStack(alignment: .center) {
                if let image {
                    Image(image)
                        .resizable()
                        .frame(width: 45, height: 45)
                        .cornerRadius(7)
                } else if let systemImage {
                    ZStack(alignment: .center) {
                        Image(systemName: systemImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                            .cornerRadius(7)
                            .foregroundColor(systemImageColor)
                    }
                    .frame(width: 45, height: 45)
                }
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(message)
                        .font(.caption)
                }
                .padding(.leading, 5)
                .padding(.bottom, 5)
            }
            .frame(height: 75)
        }
    }

    @ViewBuilder
    private func purchaseSquare(@ViewBuilder perks: () -> some View) -> some View {
        VStack(alignment: .leading) {
            perks()
        }
        .padding(10)
        .frame(maxWidth: 325, minHeight: 330)
        .background(
            RoundedRectangle(cornerRadius: 4.0)
                .foregroundColor(.init(uiColor: .secondarySystemBackground))
        )
        .cornerRadius(20)
    }

    
    @ViewBuilder
    private func userReviewTab(title: String, message: String, dedication: String, location: String) -> some View {
        VStack(spacing: 7) {
            HStack(spacing: 0) {
                ForEach(0 ..< 5) { number in
                    Image(systemName: "star.fill")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.indigo)
                        .padding(0)
                }
            }
            Text(title)
                .font(.system(.title2, design: .rounded))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Text(message)
                .font(.system(.subheadline, design: .rounded))
                .fontWeight(.regular)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            Text("by \(dedication), \(location)")
                .font(.system(.caption, design: .rounded))
                .fontWeight(.light)
                .foregroundColor(.indigo)
                .multilineTextAlignment(.center)
        }
    }

}

struct ProPurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        ProPurchaseView()
            .withEnvironment()
    }
}
