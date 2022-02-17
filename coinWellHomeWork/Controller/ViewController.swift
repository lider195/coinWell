import UIKit
final class ViewController: UIViewController {
    // MARK: - Properties
    // MARK: Public
    // MARK: Private
    private let exchangeRatesLabel = UILabel()
    private var coinTableView = UITableView()
    private var arrayOfCripto: [CoinClientModel] = [] {
        didSet {
            coinTableView.reloadData()
        }
    }
    private let reuseidentifier = "CoinTableViewCell"
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupTableView()
        addConstraints()
        setupUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ApiManager.instance.getAllExchanges() { data in
            self.arrayOfCripto = data
        }
    }
    // MARK: - Setups
    private func addSubviews(){
        view.addSubview(exchangeRatesLabel)
        view.addSubview(coinTableView)
    }
    private func setupTableView() {
        coinTableView.delegate = self
        coinTableView.dataSource = self
        coinTableView.rowHeight = UITableView.automaticDimension
        coinTableView.separatorStyle = .none
        self.coinTableView.register(CoinTableViewCell.self, forCellReuseIdentifier: reuseidentifier)
    }
    private func addConstraints() {
        exchangeRatesLabel.translatesAutoresizingMaskIntoConstraints = false
        exchangeRatesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        exchangeRatesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        exchangeRatesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        exchangeRatesLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        coinTableView.translatesAutoresizingMaskIntoConstraints = false
        coinTableView.topAnchor.constraint(equalTo: exchangeRatesLabel.bottomAnchor, constant: 15).isActive = true
        coinTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        coinTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        coinTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
    }
    private func setupUI() {
        view.backgroundColor = UIColor(red: 20/255, green: 18/255, blue: 29/255, alpha: 1.0)
        coinTableView.backgroundColor = UIColor(red: 20/255, green: 18/255, blue: 29/255, alpha: 1.0)
        exchangeRatesLabel.textColor = .white
        exchangeRatesLabel.textAlignment = .left
        exchangeRatesLabel.font = .systemFont(ofSize: 35, weight: .bold)
        exchangeRatesLabel.text = "Exchange Rates"
    }
    
    // MARK: - Helpers
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCripto.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: reuseidentifier)
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseidentifier, for: indexPath
        ) as? CoinTableViewCell {
            cell.set(data: arrayOfCripto[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

