import SwiftUI

@main
struct PrivateWealthManagerApp: App {
    @StateObject private var txnListVM = TransactionListViewModel(storage: JSONStorage())

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(txnListVM)
        }
    }
}
