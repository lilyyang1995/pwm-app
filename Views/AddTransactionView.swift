import SwiftUI

struct AddTransactionView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var amountString: String = ""
    @State private var date: Date = Date()
    @State private var type: TransactionType = .expense
    @State private var note: String = ""

    var onSave: (Transaction) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("类型", selection: $type) {
                        Text("支出").tag(TransactionType.expense)
                        Text("收入").tag(TransactionType.income)
                    }
                    DatePicker("日期", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    TextField("金额", text: $amountString)
                        .keyboardType(.decimalPad)
                    TextField("备注", text: $note)
                }
            }
            .navigationTitle("添加交易")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") {
                        guard let amount = Decimal(string: amountString) else { return }
                        let txn = Transaction(date: date, type: type, amount: amount, note: note.isEmpty ? nil : note, accountId: nil, categoryId: nil)
                        onSave(txn)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") { presentationMode.wrappedValue.dismiss() }
                }
            }
        }
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView { _ in }
    }
}
