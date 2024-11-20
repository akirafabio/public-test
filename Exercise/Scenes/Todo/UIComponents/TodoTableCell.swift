import UIKit

final class TodoTableCell: UITableViewCell {
    enum LoadingState {
        case loading
        case completed
        case failure
    }

    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    required init?(coder: NSCoder) { nil }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildLayout()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        activityIndicator.stopAnimating()
    }
}

extension TodoTableCell {
    func setupLabelText(_ text: String) {
        label.text = text
    }

    func setupLoadingState(_ loadingState: LoadingState) {
        switch loadingState {
        case .loading:
            activityIndicator.startAnimating()
        default:
            activityIndicator.stopAnimating()
        }
    }
}

extension TodoTableCell: ViewConfiguration {
    func setupViewHierarchy() {
        contentView.addSubview(label)
        contentView.addSubview(activityIndicator)
    }

    func setupViewConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: activityIndicator.leadingAnchor, constant: -8),
            activityIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
