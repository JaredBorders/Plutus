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

struct AnalysisModel: Decodable {
    var timeRange: DateRanges
    var watchlist: WathclistModel
}

struct WathclistModel: Codable, Identifiable {
    var id: String {
        return UUID().uuidString
    }
    
    let crypto: DigitalCurrency
    let stock: StockMarketIndex
    let cryptoValue: Double
    let cryptoDifference: [Double]
    let stockValue: Double
    let stockDifference: [Double]
}

struct ComparisonValueModel: Codable {
    var id: String {
        return stock.requestID
    }
    
    let timeRange: DateRanges
    let cryptoName: DigitalCurrency
    let stockName: StockMarketIndex
    var crypto: CryptoModel
    var stock: StockModel
}

struct AnalysisScreen: View {
    @State var manager: NetworkManager?
    @State private var isShowingDetailsScreen = false
    @State private var listOfComparisons = [ComparisonDetails(cryptoTicker: "BTC", stockTicker: "DOW")]
    @ObservedObject var store = ChartStore()
    @EnvironmentObject var modelData: ModelData
    
    init() {
        UINavigationBar.appearance().tintColor = UIColor.label
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: Fonts.quicksandBold, size: 20)!
        ]
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: Fonts.quicksandBold, size: 40)!
        ]
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
                    List(modelData.data, id: \.id) { item in
                        WatchListCard(isEditable: false, edit: {}, watchListItem: item)
                            .padding(.top)
                    }
                    
                    ForEach(modelData.data, id: \.id) { item in
                        WatchListCard(isEditable: false, edit: {}, watchListItem: item)
                            .padding(.top)
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
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: {
            parseCoinList()
            updateData()
        })
    }
    
    private func parseCoinList() {
        
    }
    
    private func updateData() {
        let comparisons = DefaultComparisons.comparison
        comparisons.forEach { (comparison) in
            NetworkManager.shared.requestComparison(comparison: comparison) { (result) in
                switch result {
                case .success(let data):
                    print(data)
                    modelData.data.append(data)
                case .failure(let err):
                    print(err)
                }
            }
        }
//        store.fetchDaily()
    }
}

struct AnalysisScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisScreen()
    }
}
