import UIKit
final class ViewController: UIViewController{
    // MARK: - Properties
    // MARK: Public
    // MARK: Private
    private let coinTableView = UITableView()
    private var search =  UISearchController ()
    private var arrayOfCripto: [CoinClientModel] = [] {
        didSet {
            coinTableView.reloadData()
        }
    }
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let reuseidentifier = "CoinTableViewCell"
    private var searchArray: [CoinClientModel] = []
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
        showActivityIndicator()
        ApiManager.instance.getAllExchanges() { data in
            self.arrayOfCripto = data
            self.hideActivityIndicator()
        }
    }
    // MARK: - Helpers
    private func showActivityIndicator(){
        view.isUserInteractionEnabled = false
        let viewController = tabBarController ?? navigationController ?? self
        activityIndicator.frame = CGRect(x: 0,
                                         y: 0,
                                         width: viewController.view.frame.width,
                                         height: viewController.view.frame.height
        )
        viewController.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    private func hideActivityIndicator(){
        view.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    // MARK: - Setups
    private func addSubviews(){
        view.addSubview(coinTableView)
    }
    private func setupTableView() {
        coinTableView.delegate = self
        coinTableView.dataSource = self
        search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        coinTableView.rowHeight = UITableView.automaticDimension
        coinTableView.separatorStyle = .none
        self.coinTableView.register(CoinTableViewCell.self, forCellReuseIdentifier: reuseidentifier)
    }
    private func addConstraints() {
        coinTableView.translatesAutoresizingMaskIntoConstraints = false
        coinTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        coinTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        coinTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        coinTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
    }
    private func setupUI() {
        view.backgroundColor = UIColor(red: 20/255, green: 18/255, blue: 29/255, alpha: 1.0)
        coinTableView.backgroundColor = UIColor(red: 20/255, green: 18/255, blue: 29/255, alpha: 1.0)
        search.searchBar.placeholder = "Search"
        navigationItem.searchController = search
        search.searchBar.searchTextField.layer.masksToBounds = true
        search.searchBar.searchTextField.layer.cornerRadius = 5
        search.searchBar.barTintColor = UIColor(red: 20/255, green: 18/255, blue: 29/255, alpha: 1.0)
        search.searchBar.backgroundColor = .clear
        title = "Exchange Rates"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 35),
                                                                   NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    // MARK: - Helpers
}
extension ViewController: UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if search.isActive{
            return searchArray.count
        }else{
            return arrayOfCripto.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: reuseidentifier)
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseidentifier, for: indexPath
        ) as? CoinTableViewCell {
            let coin = (search.isActive) ? searchArray[indexPath.row] : arrayOfCripto[indexPath.row]
            cell.set(coin.name ?? "", coin.priceUsd )
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
            })
    }
    func filterContent(for SearchText: String) {
        searchArray = arrayOfCripto.filter { array -> Bool in
            if let name = array.name?.lowercased() {
                return name.hasPrefix(SearchText.lowercased())
            }
            return false
        }
    }
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            coinTableView.reloadData()
        }
    }
}
