//
//  CoinTableViewCell.swift
//  UIKitBasics
//
//  Created by Tarun Sharma on 21/02/26.
//

import UIKit
import Kingfisher

class CoinTableViewCell: UITableViewCell {
    
    var coins: Coin? {
        didSet {
            configure()
        }
    }
    
    private let coinRankLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let coinImageView = UIImageView()
    
    private let coinNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let coinSymbolLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let coinPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let coinPercentageChangeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let coins else { return }
        let url = URL(string: coins.image!)
        coinImageView.kf.setImage(with: url)
        
        coinRankLabel.text = "\(String(describing: coins.marketCapRank ?? 0))"
        coinNameLabel.text = coins.name
        coinSymbolLabel.text = coins.symbol
        coinPriceLabel.text = "$ \(String(describing: coins.currentPrice ?? 0))"
        
        let change = coins.priceChangePercentage24H 
        
        let formattedChange = String(format: "%.2f", abs(change!))
        
        if change! < 0 {
            coinPercentageChangeLabel.textColor = .red
            coinPercentageChangeLabel.text = "-\(formattedChange)%"
        } else {
            coinPercentageChangeLabel.textColor = .green
            coinPercentageChangeLabel.text = "\(formattedChange)%"
        }
    }
    
    
    private func configureUI() {
        contentView.addSubview(coinRankLabel)
        coinRankLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        coinRankLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        coinRankLabel.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        contentView.addSubview(coinImageView)
        coinImageView.leftAnchor.constraint(equalTo: coinRankLabel.rightAnchor, constant: 4).isActive = true
        coinImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        coinImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        coinImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        coinImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let coinNameStackView = UIStackView(arrangedSubviews: [coinNameLabel, coinSymbolLabel])
        coinNameStackView.axis = .vertical
        coinNameStackView.spacing = 4
        coinNameStackView.alignment = .leading
        
        contentView.addSubview(coinNameStackView)
        coinNameStackView.translatesAutoresizingMaskIntoConstraints = false
        coinNameStackView.leftAnchor.constraint(equalTo: coinImageView.rightAnchor, constant: 16).isActive = true
        coinNameStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        
        let coinPriceStackView = UIStackView(arrangedSubviews: [coinPriceLabel, coinPercentageChangeLabel])
        coinPriceStackView.axis = .vertical
        coinPriceStackView.spacing = 4
        coinPriceStackView.alignment = .trailing
        
        contentView.addSubview(coinPriceStackView)
        coinPriceStackView.translatesAutoresizingMaskIntoConstraints = false
        coinPriceStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        coinPriceStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
    }
    
    
    
}
