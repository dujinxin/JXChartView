//
//  CombineChartViewController.swift
//  JXChartView
//
//  Created by 杜进新 on 2018/1/15.
//  Copyright © 2018年 dujinxin. All rights reserved.
//

import UIKit
import Charts

class CombineChartViewController: UIViewController {
    
    lazy var chartView: CombinedChartView = {
        let chart = CombinedChartView()
        chart.chartDescription?.enabled = false
        chart.drawGridBackgroundEnabled = false
        
        chart.highlightFullBarEnabled = false
        chart.drawBarShadowEnabled = false//是否绘制柱形的阴影背景
        chart.drawValueAboveBarEnabled = true//数值显示在柱形的上面还是下面
        
        chart.maxVisibleCount = 60
        
        chart.delegate = self
        
        //没有数据时的文字设置
        chart.noDataText = "暂无数据"
        chart.noDataFont = UIFont.systemFont(ofSize: 15)
        chart.noDataTextColor = UIColor.black
        
        
        //交互设置
        chart.setScaleEnabled(true) //启用缩放
        chart.pinchZoomEnabled = true //
        chart.scaleYEnabled = false//取消Y轴缩放
        chart.doubleTapToZoomEnabled = false//取消双击缩放
        chart.dragEnabled = true //启用拖拽
        chart.dragDecelerationEnabled = true //拖拽时是否有惯性效果
        chart.dragDecelerationFrictionCoef = 0.9//惯性摩擦系数（0-1）,系数越大，摩擦越大，惯性越不明显
        
        let xAxis = chart.xAxis
        xAxis.labelPosition = .bottom
        
        chart.leftAxis.enabled = false
        
        return chart
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(self.chartView)
        self.chartView.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 400)
        self.chartView.drawOrder = [CombinedChartView.DrawOrder.line.rawValue,CombinedChartView.DrawOrder.bar.rawValue]
        
        let xAxisFormatter = NumberFormatter()
        xAxisFormatter.minimumIntegerDigits = 0
        xAxisFormatter.maximumIntegerDigits = 1
        //xAxisFormatter.negativeSuffix = " w"
        //xAxisFormatter.positiveSuffix = " w"
        //上边的效果不起作用，用下边的
        xAxisFormatter.negativeFormat = "#0 day"
        xAxisFormatter.positiveFormat = "#0 day"
        
        //设置x轴样式
        let xAxis = self.chartView.xAxis //获取X轴
        xAxis.axisLineWidth = 0.5        //X轴线宽
        xAxis.axisLineColor = UIColor.black//线条颜色
        //xAxis.spaceMax = 30
        //xAxis.spaceMin = 10
        let scale = self.chartView.viewPortHandler     //设置x轴缩放，图表库默认只有缩放了才可以滑动
        scale?.setMinimumScaleX(1.5)
        
        xAxis.labelPosition = .bottom                  //label 显示位置
        xAxis.labelFont = UIFont.systemFont(ofSize: 10)//label 文字大小
        xAxis.labelTextColor = UIColor.black           //label 文字颜色
        
        xAxis.drawGridLinesEnabled = false//是否绘制网格线
        xAxis.axisMinimum = 0.0
        
        xAxis.granularity = 1
        xAxis.labelCount = 6              //x轴选项个数max = 25,min = 2,default = 6
        
        xAxis.valueFormatter = DefaultAxisValueFormatter.init(formatter: xAxisFormatter)//x轴label 数字显示格式
        
        //设置y轴样式，y轴分为左右两个，默认两个都会绘制
        //self.chartView.leftAxis.enabled = false//可以不绘制其中一个
        //设置左轴
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumIntegerDigits = 0
        leftAxisFormatter.maximumIntegerDigits = 1
        //leftAxisFormatter.negativeSuffix = " °C"
        //leftAxisFormatter.positiveSuffix = " °C"
        //上边的效果不起作用，用下边的
        leftAxisFormatter.negativeFormat = "#0 °C"
        leftAxisFormatter.positiveFormat = "#0 °C"
        
        let leftAxis = self.chartView.leftAxis
        leftAxis.enabled = true
        leftAxis.drawGridLinesEnabled = false
        
        leftAxis.axisMinimum = 0;//设置Y轴的最小值,意味着从0开始绘制，this replaces startAtZero = YES
        leftAxis.axisMaximum = 50;//设置Y轴的最大值
        //leftAxis.inverted = false;//是否将Y轴进行上下翻转
        //leftAxis.axisLineWidth = 0.5;//Y轴线宽
        //leftAxis.axisLineColor = UIColor.black;//Y轴颜色
        //leftAxis.resetCustomAxisMin()
        
        
        leftAxis.labelFont = UIFont.systemFont(ofSize: 10) //右轴label 文字大小
        leftAxis.labelTextColor = UIColor.black            //右轴label 文字颜色
        leftAxis.labelPosition = .outsideChart             //右轴label 位置
        
        //通过labelCount属性设置Y轴要均分的数量,设置的labelCount的值不一定就是Y轴要均分的数量，这还要取决于forceLabelsEnabled属性，如果forceLabelsEnabled等于YES, 则强制绘制指定数量的label, 但是可能不是均分的
        //leftAxis.forceLabelsEnabled = true//不强制绘制指定数量的label
        leftAxis.labelCount = 6 //右轴选项个数max = 25,min = 2,default = 6
        
        leftAxis.valueFormatter = DefaultAxisValueFormatter.init(formatter: leftAxisFormatter)//右轴label 数字显示格式
        
        leftAxis.spaceTop = 0.15
        leftAxis.axisMinimum = 0.0
        
        //设置Y轴上网格线的样式
        leftAxis.gridLineDashLengths = [3.0, 3.0]//设置虚线样式的网格线
        leftAxis.gridColor = UIColor.brown//网格线颜色
        leftAxis.gridAntialiasEnabled = true;//开启抗锯齿
        //设置右轴
        let rightAxisFormatter = NumberFormatter()
        rightAxisFormatter.minimumIntegerDigits = 0
        rightAxisFormatter.maximumIntegerDigits = 1
        //rightAxisFormatter.negativeSuffix = " w"
        //rightAxisFormatter.positiveSuffix = " w"
        //上边的效果不起作用，用下边的
        rightAxisFormatter.negativeFormat = "#0 w"
        rightAxisFormatter.positiveFormat = "#0 w"
        
        let rightAxis = self.chartView.rightAxis
        rightAxis.enabled = true
        
        rightAxis.axisMinimum = 20000;//设置Y轴的最小值,意味着从0开始绘制，this replaces startAtZero = YES
        rightAxis.axisMaximum = 45000;//设置Y轴的最大值
        //rightAxis.inverted = false;//是否将Y轴进行上下翻转
        //rightAxis.axisLineWidth = 0.5;//Y轴线宽
        //rightAxis.axisLineColor = UIColor.black;//Y轴颜色
        //rightAxis.resetCustomAxisMin()
        
        
        rightAxis.labelFont = UIFont.systemFont(ofSize: 10) //右轴label 文字大小
        rightAxis.labelTextColor = UIColor.black            //右轴label 文字颜色
        rightAxis.labelPosition = .outsideChart             //右轴label 位置
        
        //通过labelCount属性设置Y轴要均分的数量,设置的labelCount的值不一定就是Y轴要均分的数量，这还要取决于forceLabelsEnabled属性，如果forceLabelsEnabled等于YES, 则强制绘制指定数量的label, 但是可能不是均分的
        //rightAxis.forceLabelsEnabled = true//不强制绘制指定数量的label
        rightAxis.labelCount = 6 //右轴选项个数max = 25,min = 2,default = 6
        
        rightAxis.valueFormatter = DefaultAxisValueFormatter.init(formatter: rightAxisFormatter)//右轴label 数字显示格式
        
        rightAxis.spaceTop = 0.15
        rightAxis.axisMinimum = 0.0
        
        //设置Y轴上网格线的样式
        rightAxis.drawGridLinesEnabled = false //是否绘制网格线
        rightAxis.gridLineDashLengths = [3.0, 3.0]//设置虚线样式的网格线
        rightAxis.gridColor = UIColor.brown//网格线颜色
        rightAxis.gridAntialiasEnabled = true;//开启抗锯齿
        //在Y轴上添加限制线
        let limitLine = ChartLimitLine.init(limit: 45000, label: "限制线")
        limitLine.lineWidth = 2;
        limitLine.lineColor = UIColor.green
        limitLine.lineDashLengths = [5.0, 5.0]//虚线样式
        limitLine.labelPosition = .rightTop//位置
        rightAxis.addLimitLine(limitLine)//添加到Y轴上
        rightAxis.drawLimitLinesBehindDataEnabled = true//设置限制线绘制在柱形图的后面
        
        
        //设置其他样式
        //图表 说明
        //self.chartView.legend.enabled = false //不绘制图例说明
        self.chartView.chartDescription?.text = "i love you"//不设置文字说明
        let legend = self.chartView.legend
        legend.horizontalAlignment = .left //图例水平方向的位置
        legend.verticalAlignment = .bottom //图例竖直方向的位置
        legend.orientation = .horizontal
        legend.drawInside = false
        legend.form = .circle              //图例说明形状
        legend.formSize = 9.0              //图例说明大小
        legend.font = UIFont.init(name: "HelveticaNeue-Light", size: 11)!
        legend.xEntrySpace = 4.0
        
   
        self.reloadData()
    
        self.chartView.setVisibleXRangeMaximum(7) //限制最多显示多少根柱
    }
    func setBarChartData() -> BarChartData{
        let start : Int = 0
        var xyArray = Array<Any>()
        
        for i in start..<21 {
            let mult : Double = 25000 + 1
            let val : Double = Double(arc4random_uniform(UInt32(mult))) + 20000
            if arc4random_uniform(25000) < 2500{
                let obj = BarChartDataEntry.init(x: Double(i) + 0.25, y: val, icon: nil)
                xyArray.append(obj)
            }else{
                let obj = BarChartDataEntry.init(x: Double(i) + 0.25 , y: val)
                xyArray.append(obj)
            }
            
        }
        let set1 : BarChartDataSet
        set1 = BarChartDataSet(values: xyArray as? [ChartDataEntry], label: "i love you")
        set1.setColors(ChartColorTemplates.material(), alpha: 1.0)//设置柱形图颜色
        set1.drawIconsEnabled = false //是否绘制柱形图 icon
        set1.axisDependency = .right //设置从属与左轴还是右轴
        
        var dataSets = Array<Any>()
        dataSets.append(set1)
        
        
        let data = BarChartData(dataSets: dataSets as? [IChartDataSet])
        data.setValueFont(UIFont.init(name: "HelveticaNeue-Light", size: 10))
        data.setValueTextColor(UIColor.orange)//柱形图数值 颜色
        
//        let groupSpace = 0.06
//        let barSpace = 0.02 // x2 dataset
//        let barWidth = 0.45 // x2 dataset
//        data.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        data.barWidth = 0.5 //柱状图的宽：0...1,两条柱的间距也是由这个决定的，当为1时，没有间距
        //自定义数据显示格式
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.positiveFormat = "#0"//#0.0
        let valueFormatter = DefaultValueFormatter.init(formatter: numberFormatter)
        //设置柱顶 值的格式
        data.setValueFormatter(valueFormatter as IValueFormatter)
        
        return data
    }
    func setLineChartData() -> LineChartData{
        let start : Int = 0
        let xArray = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
        
        var xyArray1 = Array<Any>()
        
        for i in start..<xArray.count {
            let mult : Double = 25
            let val : Double = Double(arc4random_uniform(UInt32(mult + 1))) + 5
            let obj = BarChartDataEntry.init(x: Double(i) + 0.25, y: val)
            xyArray1.append(obj)
        }
    
        var set1 : LineChartDataSet


        set1 = LineChartDataSet(values: xyArray1 as? [ChartDataEntry], label: "i love you")
        set1.axisDependency = .left
        set1.setColors([UIColor.gray], alpha: 1.0)//设置线条颜色
        set1.setCircleColor(UIColor.red)
        set1.lineWidth = 2.5
        set1.circleRadius = 5.0
        set1.circleHoleRadius = 2.5
        set1.fillAlpha = 0.5
        set1.fillColor = UIColor.yellow
        set1.highlightColor = UIColor.orange
        set1.drawCircleHoleEnabled = false
        set1.mode = .cubicBezier
        
        var dataSets = Array<Any>()
        dataSets.append(set1)
        
        let data = LineChartData(dataSets: dataSets as? [IChartDataSet])
        data.setValueFont(UIFont.init(name: "HelveticaNeue-Light", size: 10))
        data.setValueTextColor(UIColor.orange)//柱形图数值 颜色
        
        
        //自定义数据显示格式
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.positiveFormat = "#0"//#0.0
        let valueFormatter = DefaultValueFormatter.init(formatter: numberFormatter)
        //设置柱顶 值的格式
        data.setValueFormatter(valueFormatter as IValueFormatter)
     
        return data
    }
    func reloadData() {
        let data = CombinedChartData()
        
        data.lineData = self.setLineChartData()
        data.barData = self.setBarChartData()
        
        self.chartView.xAxis.axisMaximum = data.xMax + 0.25;
        
        self.chartView.data = data
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //设置动画效果
        self.chartView.animate(xAxisDuration: 3, yAxisDuration: 3)
    }
    
}
extension CombineChartViewController:ChartViewDelegate{
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("chartValueSelected")
    }
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        print("chartValueNothingSelected")
    }
}
