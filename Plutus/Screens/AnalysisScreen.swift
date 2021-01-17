//
//  AnalysisScreen.swift
//  Plutus
//
//  Created by Jared Borders on 1/16/21.
//

import SwiftUI

enum TimeRange {
    case daily, weekly, monthly, yearly
}

struct AnalysisModel: Identifiable {
    var id = UUID()
    
    var timeRange: DateRanges
    var watchlist: WathclistModel
}

struct WathclistModel: Codable, Identifiable {
    var id: String {
        return UUID().uuidString
    }
    
    let crypto: DigitalCurrency
    let stock: StockMarketIndex
    let cryptoValue: String
    let cryptoDifference: String
    let stockValue: String
    let stockDifference: String
}

struct AnalysisScreen: View {
    @State private var isShowingDetailsScreen = false
    @State private var listOfComparisons = [ComparisonDetails(cryptoTicker: "BTC", stockTicker: "DOW")]
    @ObservedObject var store = ChartStore()

    var analysisData: [AnalysisModel] = [
        AnalysisModel(timeRange: .Day, watchlist: WathclistModel(crypto: .BTC, stock: .DJI, cryptoValue: "38555", cryptoDifference: "+12.65", stockValue: "30814.26", stockDifference: "-1.0")),
        AnalysisModel(timeRange: .Day, watchlist:  WathclistModel(crypto: .ETC, stock: .DJI, cryptoValue: "356", cryptoDifference: "+22.55", stockValue: "30814.26", stockDifference: "-1.0")),
        AnalysisModel(timeRange: .Day, watchlist: WathclistModel(crypto: .XRP, stock: .DJI, cryptoValue: "0.35", cryptoDifference: "-12.44", stockValue: "30814.26", stockDifference: "-1.0"))
    ]
    
    init() {
        UINavigationBar.appearance().tintColor = UIColor.label
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: Fonts.quicksandBold, size: 20)!
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: Fonts.quicksandBold, size: 40)!
        ]
    }
    
    func navigateToEditView() {
        self.isShowingDetailsScreen = true
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    HStack {
                        Text("My Watch List")
                            .font(.custom(Fonts.quicksandSemiBold, size: 18))
                            .padding([.top, .leading])
                        Spacer()
                    }
                    
                    ForEach(analysisData, id: \.id) { watchListItem in
                        WatchListCard(isEditable: false, edit: {}, cryptoTicker: watchListItem.watchlist.crypto.rawValue, stockTicker: watchListItem.watchlist.stock.rawValue, watchListItem: watchListItem)
                            .padding(.top)
                    }
                }
            }
            .navigationTitle("Plutus")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddComparisonScreen(isShowingDetailsScreen: $isShowingDetailsScreen, listOfComparisons: $listOfComparisons)) {
                        Image(systemSymbol: .plus)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: updateData)
    }
    
    private func updateData() {
        store.fetchDaily()
    }
}

struct AnalysisScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisScreen()
    }
}
