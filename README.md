# Particle iOS

This repository contains [Auth Service](https://docs.particle.network/auth-service/introduction) and [Wallet Service](https://docs.particle.network/wallet-service/introduction) sample source. It supports Solana and all EVM-compatiable chains now, more chains and more features coming soon! Learn more visit [Particle Network](https://docs.particle.network/).

# Prerequisites
Install the following:

Xcode 13.3.1

Make sure that your project meets the following requirements:

Your project must target these platform versions or later:

iOS 12


## Getting Started

* Clone the repo.
* Replace ParticelNetwork.info with your project info in the [Dashboard](https://particle.network/#/login).
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>PROJECT_UUID</key>
	<string>YOUR_PROJECT_UUID</string>
	<key>PROJECT_CLIENT_KEY</key>
	<string>YOUR_PROJECT_CLIENT_KEY</string>
	<key>PROJECT_APP_UUID</key>
	<string>YOUR_PROJECT_APP_UUID</string>
</dict>
</plist>

```
* Config your app scheme url, select your app target, in the info section, click add URL Type, past your scheme in URL Schemes. 
your scheme url should be "pn" + your project app id.

    for example, if you project app id is "63bfa427-cf5f-4742-9ff1-e8f5a1b9826f", you scheme url is "pn63bfa427-cf5f-4742-9ff1-e8f5a1b9826f".
![image](https://user-images.githubusercontent.com/18244874/168455432-f25796b0-3a6a-4fa7-8ec6-adc5f8a0c46e.png)

Add Privacy - Camera Usage Description in your info.plist file

## Build
```
pod install --repo-update
```

## Features

1. Auth login with email or phone.
2. Logout.
3. Open Wallet.
4. Change Chain Id.
5. Check our official dev docs: https://docs.particle.network/

## Docs
1. https://docs.particle.network/auth-service/sdks/ios
2. https://docs.particle.network/wallet-service/sdks/ios

## Give Feedback
Please report bugs or issues to [particle-ios/issues](https://github.com/Particle-Network/particle-ios/issues)

You can also join our [Discord](https://discord.gg/2y44qr6CR2).





