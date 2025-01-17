//
//  AppDelegate.swift
//  Demo
//
//  Created by link on 2022/5/12.
//

import ConnectCommon
import ConnectEVMAdapter
import ConnectPhantomAdapter
import ConnectSolanaAdapter
import ConnectWalletConnectAdapter
import ParticleAuthService
import ParticleConnect
import ParticleNetworkBase
import ParticleWalletConnect
import ParticleWalletGUI
import UIKit
import ParticleBiconomy

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        URLProtocol.registerClass(CustomURLProtocol.self)
        
        // init ParticleNetwork

        let dAppData = DAppMetaData(
            name: "Particle Connect",
            icon: URL(string: "https://connect.particle.network/icons/512.png")!,
            url: URL(string: "https://connect.particle.network")!)

        var adapters: [ConnectAdapter] = [
            MetaMaskConnectAdapter(),
            ParticleConnectAdapter(),
            PhantomConnectAdapter(),
            WalletConnectAdapter(),
            RainbowConnectAdapter(),
            BitkeepConnectAdapter(),
            ImtokenConnectAdapter(),
            TrustConnectAdapter(),
            GnosisConnectAdapter()
        ]

        adapters.append(EVMConnectAdapter())
        adapters.append(SolanaConnectAdapter())

        let moreAdapterClasses: [WalletConnectAdapter.Type] =
            [ZerionConnectAdapter.self,
             MathConnectAdapter.self,
             OmniConnectAdapter.self,
             Inch1ConnectAdapter.self,
             ZengoConnectAdapter.self,
             AlphaConnectAdapter.self,
             BitpieConnectAdapter.self
            ]

        adapters.append(contentsOf: moreAdapterClasses.map {
            $0.init()
        })

        
        // select a network
        ParticleConnect.initialize(env: .debug, chainInfo: .ethereum(.mainnet), dAppData: dAppData) {
            adapters
        }

        // Custom Wallet GUI
        // Control if show test network
        ParticleWalletGUI.showTestNetwork(true)
        // Control support chains
//        ParticleWalletGUI.supportChain([.bsc, .arbitrum, .harmony])

        // Control if show manage wallet
//        ParticleWalletGUI.showManageWallet(true)

        // Control disable pay feature
//        ParticleWalletGUI.enablePay(false)
        // Control disable swap feature
//        ParticleWalletGUI.enableSwap(false)

        // show language setting in setting page
        ParticleWalletGUI.showLanguageSetting(true)
        // show appearance setting in setting page
        ParticleWalletGUI.showAppearanceSetting(true)
        // Set language
//        ParticleWalletGUI.setLanguage(.en)
        // Set user interface style
//        ParticleNetwork.setInterfaceStyle(.unspecified)

        // There is two way to set custom UI
        // 1.You can set custom ui json path to enable custom UI
        // In demo, make sure customUIConfig.json is mark Target Membership Demo.
//        if let path = Bundle.main.path(forResource: "customUIConfig", ofType: "json") {
//            try! ParticleWalletGUI.loadCustomUI(path: path)
//        }

        // 2.Another way to set custom ui is pass json string
//        let jsonString = ""
//        try! ParticleWalletGUI.loadCustomUIJsonString(jsonString)

        // Initialize particle wallet connect sdk
        ParticleWalletConnect.initialize(
            WalletMetaData(name: "Particle Wallet",
                           icon: URL(string: "https://connect.particle.network/icons/512.png")!,
                           url: URL(string: "https://particle.network")!,
                           description: nil))
        // Control if disable wallet connect feature.
        // If disable wallet connect feature, you dont need to initialize particle Wallet Connect.
        ParticleWalletGUI.supportWalletConnect(true)

        // Initialize Biconomy service
        BiconomyService.initialize(version: .v1_0_0, dappApiKeys: [:])
        // create a biconomy service
        let biconomyService = BiconomyService()
        // set it to ParticleNetwork
        ParticleNetwork.setBiconomyService(biconomyService)
        
        
        ParticleAuthService.setSecurityAccountConfig(config: .init(promptSettingWhenSign: 1, promptMasterPasswordSettingWhenLogin: 2))
        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        // if open Wallet Connect in GUI, you should call this method to handle wallet connect
        // You need paste your app scheme, GUI will return true if it can reslove the url with your scheme, otherwise return false.
        if ParticleWalletGUI.handleWalletConnectUrl(url, withScheme: "particlewallet") {
            return true
        } else {
            return ParticleConnect.handleUrl(url)
        }
    }
}
