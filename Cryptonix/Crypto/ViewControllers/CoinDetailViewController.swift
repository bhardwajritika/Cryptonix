//
//  CoinDetailViewController.swift
//  UIKitBasics
//
//  Created by Tarun Sharma on 21/02/26.
//

import UIKit

class CoinDetailViewController: UIViewController {
    
    var coins: Coin
    
    init(coins: Coin) {
        self.coins = coins
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .left
        return label
    } ()
    
    var coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    var coinPercentageChangeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var overviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Overview"
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
  
    var currentPriceLabel : UILabel = {
        let label = UILabel()
        label.text = "Current Price"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var currentPriceValueLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    } ()
    
    var currentPriceChangeLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    var marketCapLabel : UILabel = {
        let label = UILabel()
        label.text = "Market Capitalization"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var marketCapValueLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    } ()
    
    var marketCapChangeLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    var rankLabel : UILabel = {
        let label = UILabel()
        label.text = "Rank"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var rankValueLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    } ()
    
    var volumeLabel : UILabel = {
        let label = UILabel()
        label.text = "Volume"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var volumeValueLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    } ()
    
    var additionalLabel: UILabel = {
        let label = UILabel()
        label.text = "Additional Information"
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var priceHighLabel : UILabel = {
        let label = UILabel()
        label.text = "High Price - 24hr"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var priceHighValueLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    } ()
    
    var priceLowLabel : UILabel = {
        let label = UILabel()
        label.text = "Low Price - 24hr"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var priceLowValueLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = coins.name
        configure()
        
        let change = coins.marketCapChangePercentage24H!
        let formatted = String(format: "%.2f", abs(change))
        if change < 0 {
            coinPercentageChangeLabel.text = " ↓ \(formatted)% "
            coinPercentageChangeLabel.backgroundColor = .red
        } else {
            coinPercentageChangeLabel.text = " ↑ \(formatted)% "
            coinPercentageChangeLabel.backgroundColor = .green
        }
        currentPriceValueLabel.text = "$ \(String(describing: coins.currentPrice ?? 0))"
        
        let formattedPrice = String(format: "%.2f", abs(coins.priceChange24H!))
        if coins.priceChange24H! < 0 {
            currentPriceChangeLabel.textColor = .red
            currentPriceChangeLabel.text = "-\(formattedPrice)%"
        } else {
            currentPriceChangeLabel.textColor = .green
            currentPriceChangeLabel.text = "\(formattedPrice)%"
        }
        
        marketCapValueLabel.text = "$ \(coins.marketCap!.abbreviated())"
        
        marketCapChangeLabel.text = "\(coins.marketCapChangePercentage24H!.formatted())%"
        if coins.marketCapChangePercentage24H! < 0 {
            marketCapChangeLabel.textColor = .red
        } else {
            marketCapChangeLabel.textColor = .green
        }
        
        volumeValueLabel.text = coins.totalVolume!.abbreviated()
        rankValueLabel.text = "\(coins.marketCapRank ?? 0)"
        
        priceHighValueLabel.text = "$ \(String(describing: coins.high24H ?? 0))"
        priceLowValueLabel.text = "$ \(String(describing: coins.low24H ?? 0))"
        
        
        navigationItem.title = coins.symbol
        
        
    }
    
    func configure() {
        view.backgroundColor = .systemBackground
        coinImageView.kf.setImage(with: URL(string: coins.image!)!)
        coinImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        coinImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        let titleNameStackView = UIStackView(arrangedSubviews: [coinImageView, titleLabel])
        view.addSubview(titleNameStackView)
        titleNameStackView.axis = .horizontal
        titleNameStackView.spacing = 4
        titleNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        titleNameStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleNameStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(coinPercentageChangeLabel)
        coinPercentageChangeLabel.topAnchor.constraint(equalTo: titleNameStackView.bottomAnchor, constant: 10).isActive = true
        coinPercentageChangeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        coinPercentageChangeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        coinPercentageChangeLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(overviewLabel)
        overviewLabel.topAnchor.constraint(equalTo: coinPercentageChangeLabel.bottomAnchor, constant: 20).isActive = true
        overviewLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        
        let currentPriceStack = UIStackView(arrangedSubviews: [currentPriceLabel, currentPriceValueLabel, currentPriceChangeLabel])
        currentPriceStack.axis = .vertical
        currentPriceStack.spacing = 4
        currentPriceStack.alignment = .leading
        currentPriceStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currentPriceStack)

        
        let marketCapStack = UIStackView(arrangedSubviews: [marketCapLabel, marketCapValueLabel, marketCapChangeLabel])
        marketCapStack.axis = .vertical
        marketCapStack.spacing = 4
        marketCapStack.alignment = .trailing
        marketCapStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(marketCapStack)
        
        let upperStack = UIStackView(arrangedSubviews: [currentPriceStack, marketCapStack])
        upperStack.axis = .horizontal
        upperStack.alignment = .leading
        upperStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(upperStack)
        upperStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        upperStack.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20).isActive = true
        upperStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        
        let rankStack = UIStackView(arrangedSubviews: [rankLabel, rankValueLabel])
        rankStack.axis = .vertical
        rankStack.spacing = 4
        rankStack.alignment = .leading
        rankStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rankStack)
        
        let volumeStack = UIStackView(arrangedSubviews: [volumeLabel, volumeValueLabel])
        volumeStack.axis = .vertical
        volumeStack.spacing = 4
        volumeStack.alignment = .leading
        volumeStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(volumeStack)
        
        let lowerStack = UIStackView(arrangedSubviews: [rankStack, volumeStack])
        lowerStack.axis = .horizontal
        lowerStack.alignment = .leading
        lowerStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lowerStack)
        lowerStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        lowerStack.topAnchor.constraint(equalTo: upperStack.bottomAnchor, constant: 20).isActive = true
        lowerStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        
        view.addSubview(additionalLabel)
        additionalLabel.topAnchor.constraint(equalTo: lowerStack.bottomAnchor, constant: 40).isActive = true
        additionalLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        
        
        let priceHighStack = UIStackView(arrangedSubviews: [priceHighLabel, priceHighValueLabel])
        priceHighStack.axis = .vertical
        priceHighStack.spacing = 4
        priceHighStack.alignment = .leading
        priceHighStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(priceHighStack)
        
        let priceLowStack = UIStackView(arrangedSubviews: [priceLowLabel, priceLowValueLabel])
        priceLowStack.axis = .vertical
        priceLowStack.spacing = 4
        priceLowStack.alignment = .leading
        priceLowStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(priceLowStack)
        
        let additionalInfoStack = UIStackView(arrangedSubviews: [priceHighStack, priceLowStack])
        additionalInfoStack.axis = .horizontal
        additionalInfoStack.alignment = .leading
        additionalInfoStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(additionalInfoStack)
        additionalInfoStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        additionalInfoStack.topAnchor.constraint(equalTo: additionalLabel.bottomAnchor, constant: 20).isActive = true
        additionalInfoStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        
        
    }

}
