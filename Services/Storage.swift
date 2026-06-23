import Foundation

protocol Storage {
    func loadTransactions() throws -> [Transaction]
    func saveTransactions(_ txns: [Transaction]) throws
}

final class JSONStorage: Storage {
    private let fileName = "transactions.json"

    private var fileURL: URL? {
        #if os(iOS) || os(macOS)
        let fm = FileManager.default
        if let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first {
            return dir.appendingPathComponent(fileName)
        }
        #endif
        return nil
    }

    func loadTransactions() throws -> [Transaction] {
        guard let url = fileURL else { return [] }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode([Transaction].self, from: data)
    }

    func saveTransactions(_ txns: [Transaction]) throws {
        guard let url = fileURL else { return }
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(txns)
        try data.write(to: url, options: [.atomic])
    }
}
