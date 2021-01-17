//
//  StaticChart.swift
//  Plutus
//
//  Created by Elena Sadler on 1/17/21.
//

import SwiftUI
import SwiftUICharts

struct StaticChart: View {
    var line1 = [9.0, 15.0, 24.0, 19.0, 25.0, 46.0, 5.0, 18.0, 4.0, 3.0]
    var line2 = [34.0, 42.0, 20.0, 37.0, 22.0, 7.0, 25.0, 21.0, 44.0, 43.0]

    var body: some View {
        MultiLineChartView(
            data: [
                (line1, GradientColors.orange),
                (line2, GradientColors.blue)
            ],
            title: "",
            legend: "",
            style: Styles.lineChartStyleOne,
            form: ChartForm.small,
            rateValue: 1,
            dropShadow: false,
            valueSpecifier: ""
        )
    }
}
//
//struct PosNegChart_Previews: PreviewProvider {
//    static var previews: some View {
//        let chart_data = StaticChartData()
//        StaticChart(line1: chart_data.exraNegativeLine, line2: chart_data.minorNegativeLine)
//    }
//}
