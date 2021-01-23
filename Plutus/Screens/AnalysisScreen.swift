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
    var id: UUID {
        return UUID()
    }
    
    let timeRange: DateRanges
    let cryptoName: DigitalCurrency
    let stockName: StockMarketIndex
    var crypto: CryptoModel
    var stock: StockModel
}

struct AnalysisScreen: View {
    @State var manager: NetworkManager?
    var requestGroup = DispatchGroup()
    
    @State private var isShowingDetailsScreen = false
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
            VStack {
                HStack {
                    Text("My Watch List")
                        .font(.custom(Fonts.quicksandSemiBold, size: 18))
                        .padding([.top, .leading])
                    Spacer()
                }
                List(modelData.data, id: \.id) { item in
                    WatchListCard(watchListItem: item)
                }
                .navigationBarTitle("Plutus", displayMode: .automatic)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: DetailsScreen(watclistItem: AnalysisModel(timeRange: .Day, watchlist: WathclistModel(crypto: .BTC, stock: .ARKG, cryptoValue: 38555, cryptoDifference: [12.65], stockValue: 30814.26, stockDifference: [-1.0])))) {
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
        manager = NetworkManager()
        
        comparisons.forEach { (comparison) in
            manager?.requestComparison(comparison: comparisons.first!) { (result) in
                switch result {
                case .success(let data):
                    print(data)
                    modelData.data.append(data)
                case .failure(let err):
                    print(err)
                }
            }
        }
    }
}

struct AnalysisScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisScreen()
    }
}
