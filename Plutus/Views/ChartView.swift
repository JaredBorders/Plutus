//
//  DailyView.swift
//  Plutus
//
//  Created by Elena Sadler on 1/17/21.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    @ObservedObject private var store = ChartStore()

    func configureView() {
        print(store.getDataForStockChart())
    }

    var body: some View {
        MultiLineChartView(
            data: [
                (store.getDataForCryptoChart(), GradientColors.blue),
                (store.getDataForStockChart(), GradientColors.orange)
            ],
            title: "",
            legend: "",
            style: Styles.lineChartStyleOne,
            form: ChartForm.small,
            rateValue: 1,
            dropShadow: false,
            valueSpecifier: ""
        )
        .onAppear(perform: configureView)
    }
}

struct ChartViewPreviews: PreviewProvider {
    static var previews: some View {
        ChartView()
            .environmentObject(ChartStore())
    }
}
