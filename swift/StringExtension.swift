import Foundation

extension String {
    func localizedString() -> String {
        return Bundle
            .main
            .localizedString(forKey: self, value: nil, table: nil)
    }
}
