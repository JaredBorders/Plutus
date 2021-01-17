//
//  StaticChart.swift
//  Plutus
//
//  Created by Elena Sadler on 1/17/21.
//

import SwiftUI
import SwiftUICharts

struct StaticChart: View {
    var chart_data = StaticChartData()
    @State var line1: [Double]
    @State var line2: [Double]

    var body: some View {
        MultiLineChartView(data: [(line1, GradientColors.orange), (line2, GradientColors.blue)], title: "", legend: "", style: Styles.lineChartStyleOne, form: ChartForm.small, rateValue: 1, dropShadow: false, valueSpecifier: "")
    }
}

struct PosNegChart_Previews: PreviewProvider {
    static var previews: some View {
        let chart_data = StaticChartData()
        StaticChart(line1: chart_data.exraNegativeLine, line2: chart_data.minorNegativeLine)
    }
}
