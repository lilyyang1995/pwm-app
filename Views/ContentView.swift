import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: TransactionListViewModel
    @State private var showingAdd = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("余额: \(formatDecimal(vm.balance))")) {
                    ForEach(vm.transactions) { t in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(t.note ?? (t.type == .income ? "收入" : "支出"))
                                    .font(.headline)
                                Text(dateFormatter.string(from: t.date))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text((t.type == .income ? "+" : "-") + formatDecimal(t.amount))
                                .foregroundColor(t.type == .income ? .green : .red)
                        }
                    }
                    .onDelete(perform: vm.remove)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("私人记账")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAdd = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAdd) {
                AddTransactionView { txn in
                    vm.add(txn)
                    showingAdd = false
                }
            }
        }
    }
}

private func formatDecimal(_ d: Decimal) -> String {
    let nf = NumberFormatter()
    nf.numberStyle = .decimal
    nf.maximumFractionDigits = 2
    return nf.string(from: d as NSDecimalNumber) ?? "0"
}

private let dateFormatter: DateFormatter = {
    let f = DateFormatter()
    f.dateStyle = .medium
    f.timeStyle = .short
    return f
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TransactionListViewModel(storage: JSONStorage()))
    }
}
