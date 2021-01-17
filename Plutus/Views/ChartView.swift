//
//  DailyView.swift
//  Plutus
//
//  Created by Elena Sadler on 1/17/21.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    let chart_data = StaticChartData()

    var body: some View {

        
        MultiLineChartView(data: [(chart_data.minorNegativeLine, GradientColors.orange), (chart_data.extraPositiveLine, GradientColors.blue)], title: "", legend: "", style: Styles.lineChartStyleOne, form: ChartForm.small, rateValue: 1, dropShadow: false, valueSpecifier: "")

    }
}

struct ChartViewPreviews: PreviewProvider {
    static var previews: some View {
        ChartView().environmentObject(ChartStore())
    }
}

