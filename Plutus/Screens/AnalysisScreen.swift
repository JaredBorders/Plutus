//
//  AnalysisScreen.swift
//  Plutus
//
//  Created by Jared Borders on 1/16/21.
//

import SwiftUI

struct AnalysisScreen: View {
    @State private var isShowingDetailsScreen = false
    @State private var dictOfComparisons = [ComparisonDetails(cryptoTicker: "BTC", stockTicker: "DOW")]
    
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
            VStack {
                DateRangePickerView()
                Divider()
                ScrollView {
                    HStack {
                        Text("My Watch List")
                            .font(.custom(Fonts.quicksandSemiBold, size: 18))
                            .padding([.top, .leading])
                        Spacer()
                    }
                    ScrollView {
                        LazyVStack {
                            ForEach(0..<dictOfComparisons.count) { i in
                                ZStack {
                                    NavigationLink(
                                        destination: DetailsScreen(),
                                        isActive: $isShowingDetailsScreen) {}
                                    WatchListCard(isEditable: false,
                                                  edit: navigateToEditView,
                                                  cryptoTicker: $dictOfComparisons[i].cryptoTicker,
                                                  stockTicker: $dictOfComparisons[i].stockTicker)
                                        .padding(.top, 8)
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle("Plutus", displayMode: .automatic)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: DetailsScreen()) {
                            Image(systemSymbol: .plus)
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AnalysisScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisScreen()
        
    }
}
