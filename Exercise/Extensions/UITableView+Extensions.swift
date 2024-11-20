import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(withType tableCellType: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: tableCellType)

        register(tableCellType, forCellReuseIdentifier: identifier)

        guard let tableCell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("ERROR: TableCell Identifier not found")
        }

        return tableCell
    }
}
