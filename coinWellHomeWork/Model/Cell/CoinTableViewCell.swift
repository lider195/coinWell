import UIKit
final class CoinTableViewCell: UITableViewCell {
    // MARK: - Properties
    // MARK: Public
    // MARK: Private
    private let colorView = UIView()
    private var nameOfCriptoLabel = UILabel()
    private var valueOfCriptoLabel = UILabel()
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - API
    func set(data: CoinClientModel) {
        nameOfCriptoLabel.text = data.name
         let price = data.priceUsd  
        valueOfCriptoLabel.text = "$\(NSString(format: "%.3f", price))"
    }
    // MARK: - Setups
    private func addSubviews() {
        contentView.addSubview(colorView)
        contentView.addSubview(nameOfCriptoLabel)
        contentView.addSubview(valueOfCriptoLabel)
    }
    private func setupConstraints() {
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        colorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        colorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7).isActive = true
        colorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7).isActive = true
        colorView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameOfCriptoLabel.translatesAutoresizingMaskIntoConstraints = false
        nameOfCriptoLabel.centerYAnchor.constraint(equalTo: colorView.centerYAnchor, constant: 0).isActive = true
        nameOfCriptoLabel.leadingAnchor.constraint(equalTo: colorView.leadingAnchor, constant: 15).isActive = true
        nameOfCriptoLabel.trailingAnchor.constraint(equalTo: colorView.centerXAnchor, constant: 0).isActive = true
        nameOfCriptoLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        valueOfCriptoLabel.translatesAutoresizingMaskIntoConstraints = false
        valueOfCriptoLabel.centerYAnchor.constraint(equalTo: colorView.centerYAnchor, constant: 0).isActive = true
        valueOfCriptoLabel.leadingAnchor.constraint(equalTo: colorView.centerXAnchor, constant: 0).isActive = true
        valueOfCriptoLabel.trailingAnchor.constraint(equalTo: colorView.trailingAnchor, constant: -15).isActive = true
        valueOfCriptoLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    private func setupUI() {
        contentView.backgroundColor = UIColor(red: 20/255, green: 18/255, blue: 29/255, alpha: 1.0)
        colorView.backgroundColor = UIColor(red: 37/255, green: 35/255, blue: 51/255, alpha: 1.0)
        colorView.layer.cornerRadius = 8
        colorView.layer.masksToBounds = true
        nameOfCriptoLabel.textColor = .white
        nameOfCriptoLabel.textAlignment = .left
        nameOfCriptoLabel.font = .systemFont(ofSize: 20, weight: .bold)
        valueOfCriptoLabel.textColor = .lightGray
        valueOfCriptoLabel.textAlignment = .right
        valueOfCriptoLabel.font = .systemFont(ofSize: 20, weight: .medium)
    }
    // MARK: - Helpers
}

