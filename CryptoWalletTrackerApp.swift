//
//  CryptoWalletTrackerApp.swift
//  CryptoWalletTracker
//
//  Created by OpenAI on 2025.
//

import SwiftUI
import Combine
import LocalAuthentication

struct Coin: Identifiable, Decodable {
    let id: String
    let symbol: String
    let name: String
    let current_price: Double
    let image: String
}

class CryptoViewModel: ObservableObject {
    @Published var coins = [Coin]()
    @Published var isAuthenticated = false
    private var cancellables = Set<AnyCancellable>()

    init() {
        authenticateUser()
    }

    func authenticateUser() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to access your crypto wallet."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                DispatchQueue.main.async {
                    self.isAuthenticated = success
                    if success {
                        self.fetchData()
                    }
                }
            }
        } else {
            isAuthenticated = true
            fetchData()
        }
    }

    func fetchData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\ .data)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.coins = $0 }
            .store(in: &cancellables)
    }
}

struct CoinRowView: View {
    let coin: Coin

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: coin.image)) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 40, height: 40)
            .clipShape(Circle())

            VStack(alignment: .leading) {
                Text(coin.name)
                    .font(.headline)
                Text(coin.symbol.uppercased())
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            Text(String(format: "$%.2f", coin.current_price))
                .bold()
                .foregroundColor(.green)
        }
        .padding(.vertical, 6)
    }
}

struct ContentView: View {
    @StateObject var viewModel = CryptoViewModel()

    var body: some View {
        NavigationView {
            if viewModel.isAuthenticated {
                List(viewModel.coins) { coin in
                    CoinRowView(coin: coin)
                }
                .navigationTitle("🪙 Crypto Wallet")
            } else {
                Text("Authenticating...")
            }
        }
    }
}

@main
struct CryptoWalletTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
