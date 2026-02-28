//
//  CoinPricesViewController.swift
//  UIKitBasics
//
//  Created by Tarun Sharma on 21/02/26.
//

import UIKit

let reuseIdentifier = "cell"

class CoinPricesViewController: UIViewController {
    
    private let tableView = UITableView()
    private var service = APICall()
    private var coins = [Coin]()
       

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "All Coins"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.rowHeight = 56
        
        Task { await fetchCoins() }
        
    }
    
    func fetchCoins() async {
        do {
            self.coins = try await service.networkCall()
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }


}

extension CoinPricesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(coins.count)
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CoinTableViewCell
        cell.coins = coins[indexPath.row]
        return cell
    }
}

extension CoinPricesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = coins[indexPath.row]
        let detailVC = CoinDetailViewController(coins: coin)
        show(detailVC, sender: self)
    }
}
