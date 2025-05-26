# 🪙 Crypto Wallet Tracker

A modern and secure iOS app to track your crypto portfolio using live data from CoinGecko API. Includes biometric authentication with FaceID/TouchID for privacy.

## 🚀 Features

- ✅ Live price tracking from [CoinGecko API](https://www.coingecko.com/en/api)
- ✅ FaceID/TouchID authentication
- ✅ Minimal, fast SwiftUI UI
- ✅ Async image loading with Combine
- ✅ Secure and offline-friendly fallback

## 🧰 Tech Stack

- `SwiftUI`
- `Combine`
- `REST API`
- `LocalAuthentication` (FaceID/TouchID)

## 🧑‍💻 How to Run

1. **Clone the Repository**

```bash
git clone https://github.com/yourusername/crypto-wallet-tracker.git
cd crypto-wallet-tracker
```

2. **Open in Xcode**

```bash
open CryptoWalletTracker.xcodeproj
```

3. **Set Up Project**

- ✅ Xcode 15+
- ✅ iOS 16 or later
- ✅ Real device recommended (for biometric features)
- ✅ Add FaceID/TouchID usage description in `Info.plist`:

```xml
<key>NSFaceIDUsageDescription</key>
<string>We use FaceID/TouchID to secure your wallet data</string>
```

4. **Run the App**

- Build and run on a real device.
- Authenticate using FaceID/TouchID.
- See your top coins with real-time prices.

## 🔒 Biometric Notes

Ensure biometric features are enabled in the device settings.
