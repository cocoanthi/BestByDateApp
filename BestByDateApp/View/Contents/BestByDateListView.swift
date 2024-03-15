import SwiftUI

struct BestByDateListView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @StateObject var vm: BestByDateViewModel
    // 3日前に通知するため、現在日から４日後までは選択できないようにする
    let minDate = Calendar.current.date(byAdding: .day, value: 4, to: Date())!

    var body: some View {
        VStack(spacing: .zero) {
            NavigationView {
                List {
                    ForEach(0..<vm.viewBestByDateItemList.count, id: \.self) { index in
                        HStack(spacing: .zero) {
                            TextField("", text: $vm.viewBestByDateItemList[index].name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Spacer()
                            DatePicker(
                                selection: $vm.viewBestByDateItemList[index].bestByDate,
                                in: minDate...,
                                displayedComponents: [.date],
                                label: { Text("") }
                            )
                            .environment(\.locale, Locale(identifier: "ja_JP"))
                            Spacer().frame(width: 10)
                            Button(
                                // 通知ボタン押下で通知可否状態を変更する
                                action: { vm.toggle(index: index) }
                            ){
                                // 通知可否の状態に応じて色を切り替える
                                Text("通知")
                                    .foregroundColor(vm.viewBestByDateItemList[index].isNotify ? .blue : .gray)
                                    .padding(2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(vm.viewBestByDateItemList[index].isNotify ? .blue : .gray, lineWidth: 2)
                                    )
                            }
                            // MARK: buttonStyle設定しないとタッチイベントがListに吸収される
                            .buttonStyle(BorderlessButtonStyle())
                        }
                        .onChange(of: vm.viewBestByDateItemList[index]) { _ in
                            vm.onChangeItem(index: index)
                        }
                        
                    }
                    // EditButton経由で削除した場合に呼ばれる
                    .onDelete(perform: vm.deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        // ＋ボタン
                        Button(action: vm.addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            }
            .navigationTitle("期限切れリマインダー")
            .navigationBarItems(
                trailing: Button(action: {
                    vm.updateButtonTapped()
                }) {
                    Text("Save")
                }
            )
            Button(action: { vm.updateNotification() }) {
                Text("Send Notification!!")
            }
        }
    }
}

struct BestByDateListView_Previews: PreviewProvider {
    static var previews: some View {
        BestByDateListView(
            vm: .init(
                groupInfo: .init(
                    groupId: "",
                    groupName: "",
                    groupPassword: ""
                )
            )
        )
    }
}
