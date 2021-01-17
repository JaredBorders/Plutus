//
//  AnalysisScreen.swift
//  Plutus
//
//  Created by Jared Borders on 1/16/21.
//

import SwiftUI

struct AnalysisScreen: View {
    @State private var isShowingDetailsScreen = false

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
                HStack {
                    Text("My Watch List")
                        .font(.custom(Fonts.quicksandSemiBold, size: 18))
                        .padding([.top, .leading])
                    Spacer()
                }
                ScrollView {
                    WatchListCard()
                        .padding(.top, 8)
                        .padding(.horizontal)
                    WatchListCard()
                        .padding(.top, 8)
                        .padding(.horizontal)
                    WatchListCard()
                        .padding(.top, 8)
                        .padding(.horizontal)
                    WatchListCard()
                        .padding(.top, 8)
                        .padding(.horizontal)
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
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AnalysisScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisScreen()

    }
}
