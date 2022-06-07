//
//  SwitchChainViewController.swift
//  Demo
//
//  Created by link on 2022/6/6.
//  Copyright © 2022 ParticleNetwork. All rights reserved.
//

import Foundation
import ParticleNetworkBase
import UIKit

typealias Chain = ParticleNetwork.ChainName
typealias SolanaNetwork = ParticleNetwork.SolanaNetwork
typealias EthereumNetwork = ParticleNetwork.EthereumNetwork
typealias BscNetwork = ParticleNetwork.BscNetwork
typealias PolygonNetwork = ParticleNetwork.PolygonNetwork
typealias AvalancheNetwork = ParticleNetwork.AvalancheNetwork
typealias FantomNetwork = ParticleNetwork.FantomNetwork
typealias ArbitrumNetwork = ParticleNetwork.ArbitrumNetwork
typealias MoonBeamNetwork = ParticleNetwork.MoonBeamNetwork
typealias MoonRiverNetwork = ParticleNetwork.MoonRiverNetwork
typealias HecoNetwork = ParticleNetwork.HecoNetwork
typealias AuroraNetwork = ParticleNetwork.AuroraNetwork
typealias HarmonyNetwork = ParticleNetwork.HarmonyNetwork

class SwitchChainViewController: UIViewController {
    
    var selectHandler:(() -> Void)?
    let tableView = UITableView(frame: .zero, style: .grouped)

    var data: [[String: [String]]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        configureTableView()
    }

    func configureData() {
        data.append([Chain.solana(.mainnet).name: [
            SolanaNetwork.mainnet.rawValue, SolanaNetwork.testnet.rawValue, SolanaNetwork.devnet.rawValue
        ]])
        data.append([Chain.ethereum(.mainnet).name: [
            EthereumNetwork.mainnet.rawValue, EthereumNetwork.kovan.rawValue
        ]])
        data.append([Chain.bsc(.mainnet).name: [
            BscNetwork.mainnet.rawValue, BscNetwork.testnet.rawValue
        ]])
        data.append([Chain.polygon(.mainnet).name: [
            PolygonNetwork.mainnet.rawValue, PolygonNetwork.testnet.rawValue
        ]])
        data.append([Chain.avalanche(.mainnet).name: [
            AvalancheNetwork.mainnet.rawValue, AvalancheNetwork.testnet.rawValue
        ]])
        data.append([Chain.fantom(.mainnet).name: [
            FantomNetwork.mainnet.rawValue, FantomNetwork.testnet.rawValue
        ]])
        data.append([Chain.arbitrum(.mainnet).name: [
            ArbitrumNetwork.mainnet.rawValue, ArbitrumNetwork.testnet.rawValue
        ]])
        data.append([Chain.moonBeam(.mainnet).name: [
            MoonBeamNetwork.mainnet.rawValue, MoonBeamNetwork.testnet.rawValue
        ]])
        data.append([Chain.moonRiver(.mainnet).name: [
            MoonRiverNetwork.mainnet.rawValue, MoonRiverNetwork.testnet.rawValue
        ]])
        data.append([Chain.heco(.mainnet).name: [
            HecoNetwork.mainnet.rawValue, HecoNetwork.testnet.rawValue
        ]])
        data.append([Chain.aurora(.mainnet).name: [
            AuroraNetwork.mainnet.rawValue, AuroraNetwork.testnet.rawValue
        ]])
        data.append([Chain.harmony(.mainnet).name: [
            HarmonyNetwork.mainnet.rawValue, HarmonyNetwork.testnet.rawValue
        ]])
    }

    func configureTableView() {
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SwitchChainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].values.first?.count ?? 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self), for: indexPath)
        let network = data[indexPath.section].values.first?[indexPath.row] ?? ""
        cell.textLabel?.text = network
        cell.selectionStyle = .none
        return cell
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label = UILabel()
//        label.text = "    " + (data[section].keys.first ?? "")
//        label.textColor = UIColor.black
//        label.font = UIFont.systemFont(ofSize: 20)
//        return label
//    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        data[section].keys.first
    }
}

extension SwitchChainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let network = data[indexPath.section].values.first?[indexPath.row] ?? ""
        let name = data[indexPath.section].keys.first ?? ""
    
        var chainName: Chain
        switch name {
        case Chain.solana(.mainnet).name:
            chainName = .solana(SolanaNetwork(rawValue: network)!)
        case Chain.ethereum(.mainnet).name:
            chainName = .ethereum(EthereumNetwork(rawValue: network)!)
        case Chain.bsc(.mainnet).name:
            chainName = .bsc(BscNetwork(rawValue: network)!)
        case Chain.polygon(.mainnet).name:
            chainName = .polygon(PolygonNetwork(rawValue: network)!)
        case Chain.avalanche(.mainnet).name:
            chainName = .avalanche(AvalancheNetwork(rawValue: network)!)
        case Chain.fantom(.mainnet).name:
            chainName = .fantom(FantomNetwork(rawValue: network)!)
        case Chain.arbitrum(.mainnet).name:
            chainName = .arbitrum(ArbitrumNetwork(rawValue: network)!)
        case Chain.moonBeam(.mainnet).name:
            chainName = .moonBeam(MoonBeamNetwork(rawValue: network)!)
        case Chain.moonRiver(.mainnet).name:
            chainName = .moonRiver(MoonRiverNetwork(rawValue: network)!)
        case Chain.heco(.mainnet).name:
            chainName = .heco(HecoNetwork(rawValue: network)!)
        case Chain.aurora(.mainnet).name:
            chainName = .aurora(AuroraNetwork(rawValue: network)!)
        case Chain.harmony(.mainnet).name:
            chainName = .harmony(HarmonyNetwork(rawValue: network)!)
        default:
            chainName = .ethereum(.mainnet)
        }
        
        ParticleNetwork.setChainName(chainName)
        
        let alert = UIAlertController(title: "Switch network", message: "current network is \(name) - \(network)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            
            if let selectHandler = self.selectHandler {
                selectHandler()
            }
            self.dismiss(animated: true)
        }))
        
        present(alert, animated: true)
    }
}
