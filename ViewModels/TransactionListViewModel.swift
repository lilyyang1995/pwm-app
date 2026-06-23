import Foundation
import Combine

final class TransactionListViewModel: ObservableObject {
    @Published private(set) var transactions: [Transaction] = []

    private let storage: Storage

    init(storage: Storage) {
        self.storage = storage
        load()
    }

    var balance: Decimal {
        transactions.reduce(0) { acc, t in
            switch t.type {
            case .income: return acc + t.amount
            case .expense: return acc - t.amount
            }
        }
    }

    func load() {
        do {
            let txns = try storage.loadTransactions()
            DispatchQueue.main.async {
                self.transactions = txns.sorted { $0.date > $1.date }
            }
        } catch {
            // If missing or corrupt, start with sample data
            DispatchQueue.main.async {
                self.transactions = Self.sampleData()
                try? self.storage.saveTransactions(self.transactions)
            }
        }
    }

    func add(_ txn: Transaction) {
        transactions.insert(txn, at: 0)
        save()
    }

    func remove(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
        save()
    }

    private func save() {
        do {
            try storage.saveTransactions(transactions)
        } catch {
            print("保存交易失败: \(error)")
        }
    }

    private static func sampleData() -> [Transaction] {
        return [
            Transaction(date: Date(), type: .income, amount: 1200, note: "工资", accountId: nil, categoryId: nil),
            Transaction(date: Date().addingTimeInterval(-86400), type: .expense, amount: 50.5, note: "午餐", accountId: nil, categoryId: nil)
        ]
    }
}
