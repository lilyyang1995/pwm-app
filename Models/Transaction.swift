import Foundation

enum TransactionType: String, Codable {
    case income
    case expense
}

struct Transaction: Identifiable, Codable {
    var id: UUID = UUID()
    var date: Date
    var type: TransactionType
    var amount: Decimal
    var note: String?
    var accountId: UUID?
    var categoryId: UUID?
}
