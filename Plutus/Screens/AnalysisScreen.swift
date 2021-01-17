//
//  AnalysisScreen.swift
//  Plutus
//
//  Created by Jared Borders on 1/16/21.
//

import SwiftUI

struct AnalysisScreen: View {
    @State private var isShowingDetailsScreen = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: DetailsScreen(), isActive: $isShowingDetailsScreen) {}
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
            .navigationBarItems(trailing: Button {
                self.isShowingDetailsScreen = true
            } label: {
                Image(systemSymbol: .plus)
                    .foregroundColor(.black)
            })
        }
    }
}

struct AnalysisScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisScreen()
    }
}
