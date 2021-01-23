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
    var crypto: CryptoModel
    var stock: StockModel
}

struct AnalysisScreen: View {
    @State var manager: NetworkManager?
    var requestGroup = DispatchGroup()
    
    @State private var isShowingDetailsScreen = false
    @EnvironmentObject var modelData: ModelData

    var analysisData: [AnalysisModel] = []
//        [
//        AnalysisModel(timeRange: .Day, watchlist: WathclistModel(crypto: .BTC, stock: .IBM, cryptoValue: 38555, cryptoDifference: +12.65, stockValue: 30814.26, stockDifference: -1.0)),
//        AnalysisModel(timeRange: .Day, watchlist:  WathclistModel(crypto: .ETC, stock: .UVXY, cryptoValue: "356", cryptoDifference: "+22.55", stockValue: "30814.26", stockDifference: "-1.0")),
//        AnalysisModel(timeRange: .Day, watchlist: WathclistModel(crypto: .XRP, stock: .VXX, cryptoValue: "0.35", cryptoDifference: "-12.44", stockValue: "30814.26", stockDifference: "-1.0"))
//    ]
    
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
                List(modelData.data, id: \.watchlist.id) { watchListItem in
                    WatchListCard(watchListItem: watchListItem)
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
//        let comparisons = DefaultComparisons.comparison
        manager = NetworkManager()
        manager?.requestComparison(comparison: FavoriteComparison(crypto: .ROAD, stock: .AAPL, timeRange: .Day), completion: { (result) in
            print(result)
        })
//        comparisons.forEach { (comparison) in
//            requestGroup.enter()
//            manager?.requestComparison(comparison: comparisons.first!) { (result) in
//                switch result {
//                case .success(let data):
//                    print(data)
//                    modelData.data.append(data)
//                    requestGroup.leave()
//                case .failure(let err):
//                    print(err)
//                    requestGroup.leave()
//                }
//            }
//        }
        requestGroup.notify(queue: .main) { 
            print("request group is done")
        }
    }
}

struct AnalysisScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisScreen()
    }
}
