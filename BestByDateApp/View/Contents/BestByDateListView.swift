import SwiftUI

struct BestByDateListView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @StateObject var bestByDateViewModel: BestByDateViewModel
    // 3日前に通知するため、現在日から４日後までは選択できないようにする
    let minDate = Calendar.current.date(byAdding: .day, value: 4, to: Date())!

    var body: some View {
        Text("期限切れリマインダー")
        NavigationView {
            List {
                ForEach(0..<bestByDateViewModel.bestByDateItemList.count, id: \.self) { index in
                    HStack(spacing: .zero) {
                        TextField("", text: $bestByDateViewModel.bestByDateItemList[index].name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Spacer()
                        DatePicker(
                            selection: $bestByDateViewModel.bestByDateItemList[index].bestByDate,
                            in: minDate...,
                            displayedComponents: [.date],
                            label: { Text("") }
                        )
                        .environment(\.locale, Locale(identifier: "ja_JP"))
                        Spacer().frame(width: 10)
                        Button(
                            // 通知ボタン押下で通知可否状態を変更する
                            action: { bestByDateViewModel.bestByDateItemList[index].notifyFlag.toggle() }
                        ){
                            // 通知可否の状態に応じて色を切り替える
                            Text("通知")
                                .foregroundColor(bestByDateViewModel.bestByDateItemList[index].notifyFlag ? .blue : .gray)
                                .padding(2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(bestByDateViewModel.bestByDateItemList[index].notifyFlag ? .blue : .gray, lineWidth: 2)
                                )
                        }
                        // MARK: buttonStyle設定しないとタッチイベントがListに吸収される
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
                // EditButton経由で削除した場合に呼ばれる
                .onDelete(perform: bestByDateViewModel.deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    // ＋ボタン
                    Button(action: bestByDateViewModel.addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        Button(action: { bestByDateViewModel.updateNotification() }) {
            Text("Send Notification!!")
        }
    }
}

struct BestByDateListView_Previews: PreviewProvider {
    static var previews: some View {
        BestByDateListView(bestByDateViewModel: .init(bestByDateItemList: []))
    }
}
