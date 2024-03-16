import SwiftUI

struct BestByDateListView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @StateObject var vm: BestByDateViewModel
    @State var isNotifiedInfo = false
    @State var notifiedInfo: [String]? {
        didSet {
            isNotifiedInfo = notifiedInfo != nil
        }
    }

    // 3日前に通知するため、現在日から４日後までは選択できないようにする
    let minDate = Calendar.current.date(byAdding: .day, value: 4, to: Date())!

    var body: some View {
        ZStack {
            VStack(spacing: .zero) {
                NavigationView {
                    VStack(spacing: .zero) {
                        ScrollView() {
                            ForEach(vm.viewBestByDateItemList.indices, id: \.self) { index in
                                bestByDateRow(index: index)
                                Rectangle()
                                    .frame(height: 1)
                                  .foregroundColor(Color.gray)
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                vm.copyButtonTapped(str: vm.groupInfo.groupId)
                            }) {
                                HStack(spacing: 6) {
                                    Text("group_id: \(vm.groupInfo.groupId)")
                                    Label("", systemImage: "doc.on.doc.fill")
                                }
                            }
                        }
                        ToolbarItem {
                            // ＋ボタン
                            Button(action: vm.addItemButtonTapped) {
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                    }
                }
                .navigationTitle(vm.groupInfo.groupName)
                .navigationBarItems(
                    trailing: Button(action: {
                        vm.updateButtonTapped()
                    }) {
                        Text("Save")
                    }
                )
                .padding(.bottom, 15)
                Button(action: { notifiedInfo = vm.notifyButtonTapped() }) {
                    Text("期限の3日前に通知する")
                        .foregroundColor(.blue)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.blue, lineWidth: 2)
                        )
                }
            }
            ProgressIndicator(isLoading: vm.isLoading)
        }
        .alert("以下の情報が期限日の3日前に通知されます。", isPresented: $isNotifiedInfo) {
            Button(action: {self.notifiedInfo = nil}) {
                Text("OK")
            }
        } message: {
            if let info = notifiedInfo {
                Text(info.joined(separator: ","))
            }
        }
    }
    
    @ViewBuilder
    func bestByDateRow(index: Int) -> some View{
        HStack(spacing: .zero) {
            VStack(spacing: 5) {
                TextField("", text: $vm.viewBestByDateItemList[index].name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
                HStack(spacing: 15) {
                    Spacer()
                    DatePicker(
                        selection: $vm.viewBestByDateItemList[index].bestByDate,
                        in: minDate...,
                        displayedComponents: [.date],
                        label: { Text("") }
                    )
                    .environment(\.locale, Locale(identifier: "ja_JP"))
                    Button(
                        // 通知ボタン押下で通知可否状態を変更する
                        action: { vm.notifyToggleTapped(index: index) }
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
                    Spacer().frame(width: 5)
                }
            }
            Button(action: {
                vm.deleteButtonTapped(index: index)
            }) {
                Label("", systemImage: "trash.fill")
            }
            .modifier(TapGestureWithEffect {})
            .padding()
        }
        .onChange(of: vm.viewBestByDateItemList[index]) { _ in
            vm.onChangeItem(index: index)
        }
        .padding(.vertical, 5)
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
