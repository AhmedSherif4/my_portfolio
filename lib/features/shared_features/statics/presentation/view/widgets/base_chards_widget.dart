part of '../../../statics.dart';


class BaseChartWidget extends StatefulWidget {
  final String title;
  final List<DataForCharts> dataSource;
  final ChartType type;
  final int? yMax;
  final int? xMax;
  final String xTitle;
  final String yTitle;

  const BaseChartWidget(
      {super.key,
        required this.title,
        required this.dataSource,
        required this.type,
         this.yMax,
         this.xMax,
        required this.xTitle,
        required this.yTitle});

  @override
  State<BaseChartWidget> createState() => _BaseChartWidgetState();
}

class _BaseChartWidgetState extends State<BaseChartWidget> {
  int _currentPage = 0;
  final int _itemsPerPage = 7 ;

  void _nextPage() {
    setState(() {
      if ((_currentPage + 1) * _itemsPerPage < widget.dataSource.length) {
        _currentPage++;
      }
    });
  }

  void _previousPage() {
    setState(() {
      if (_currentPage > 0) {
        _currentPage--;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final startIndex = _currentPage * _itemsPerPage;
    final endIndex = (_currentPage + 1) * _itemsPerPage;
    final visibleItems = widget.dataSource.sublist(
      startIndex,
      endIndex > widget.dataSource.length ? widget.dataSource.length : endIndex,
    );




    return SizedBox(
      width: AppReference.deviceIsTablet&&!AppReference.isPortrait(context)?AppReference.deviceWidth(context)*0.5:double.infinity,
      height: AppReference.deviceIsTablet&&!AppReference.isPortrait(context)?AppReference.deviceHeight(context) * 0.28.responsiveHeightRatio:AppReference.deviceHeight(context) * 0.4.responsiveHeightRatio,

      child: Column(
        children: [
          Container(
            width: AppReference.deviceIsTablet&&!AppReference.isPortrait(context)?AppReference.deviceWidth(context)*0.5:double.infinity,
            height: AppReference.deviceIsTablet&&!AppReference.isPortrait(context)?AppReference.deviceHeight(context) * 0.25.responsiveHeightRatio:AppReference.deviceHeight(context) * 0.35.responsiveHeightRatio,
            padding: EdgeInsets.all(AppPadding.p10.responsiveSize),
            decoration: AppConstants.containerDecoration(
              backgroundColor: AppColors.white,
            ),
            child: charts.SfCartesianChart(
              plotAreaBorderWidth: 0,
              title: charts.ChartTitle(
                text: widget.title,
                alignment: charts.ChartAlignment.far,
                textStyle: AppTextStyle.bodyLarge16,
              ),
              series: <charts.CartesianSeries<DataForCharts, num>>[
                switch (widget.type) {
                  ChartType.pointColumn => charts.ColumnSeries<DataForCharts, num>(

                    markerSettings: charts.MarkerSettings(
                      isVisible: true,
                      shape: charts.DataMarkerType.circle,
                      height: 6.responsiveSize,
                      width: 6.responsiveSize,

                      color: AppColors.primaryColor2,
                    ),
                    dataSource: visibleItems,
                     xValueMapper: (DataForCharts sales, _) => sales.index,
                    yValueMapper: (DataForCharts sales, _) => sales.data,
                  ),

                  ChartType.timeArea => charts.SplineAreaSeries<DataForCharts, num>(
                    markerSettings: charts.MarkerSettings(
                      isVisible: true,
                      shape: charts.DataMarkerType.circle,
                      height: 6.responsiveSize,
                      width: 6.responsiveSize,
                      color: AppColors.primaryColor2,
                    ),
                    dataSource: visibleItems,
                    xValueMapper: (DataForCharts sales, _) => sales.index,
                    yValueMapper: (DataForCharts sales, _) => sales.data,
                  ),
                  ChartType.attemptsLinear => charts.LineSeries<DataForCharts, num>(
                    markerSettings: charts.MarkerSettings(
                      isVisible: true,
                      shape: charts.DataMarkerType.circle,
                      height: 6.responsiveSize,
                      width: 6.responsiveSize,
                      color: AppColors.primaryColor2,
                    ),
                    dataSource: visibleItems,
                    xValueMapper: (DataForCharts sales, _) => sales.index,
                    yValueMapper: (DataForCharts sales, _) => sales.data,
                  ),
                }
              ],
              enableAxisAnimation: true,
              palette: const [
                AppColors.primaryColor,
              ],

              zoomPanBehavior: charts.ZoomPanBehavior(
                enablePinching: true,
                enablePanning: true,
              ),
              tooltipBehavior: charts.TooltipBehavior(
                  enable: true, header: '', canShowMarker: false),
              primaryXAxis: charts.CategoryAxis(
                majorGridLines: const charts.MajorGridLines(width: 0),
                labelIntersectAction: charts.AxisLabelIntersectAction.wrap,
                crossesAt: -2,
                placeLabelsNearAxisLine: false,
                interval: 1,
                // zoomPosition: .20,
                // zoomFactor: dataSource.length > 10 ? 0.4 : 0.99,
                autoScrollingMode: charts.AutoScrollingMode.start,
                minimum: 0,
                labelStyle: const AppTextStyle().s8.bodySmall12,
                // maximum: double.tryParse('${widget.xMax}'),
                title: charts.AxisTitle(
                  text: widget.xTitle,
                  alignment: charts.ChartAlignment.far,
                  textStyle: AppTextStyle.bodySmall12,
                ),
              ),
              primaryYAxis: charts.NumericAxis(
                  // maximum: double.tryParse('${widget.yMax}'),
                  labelStyle: const AppTextStyle().s8.bodySmall12,
                  title: charts.AxisTitle(
                    text: widget.yTitle,
                    alignment: charts.ChartAlignment.far,
                    textStyle: AppTextStyle.bodySmall12,
                  ),
                  labelPosition: charts.ChartDataLabelPosition.outside,
                  minimum: 0,
                  axisLine: const charts.AxisLine(width: 0),
                  interval: 2,
                  majorTickLines: const charts.MajorTickLines(size: 0)),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                   style: ElevatedButton.styleFrom(
                     backgroundColor: AppColors.primaryColor,
                     foregroundColor: AppColors.white,
                     elevation: 0
                   ),
                  onPressed: _previousPage,
                  child: const Text('السابق'),
                ),
                if(AppReference.deviceIsTablet)
                30.sizedBoxWidth,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.white,
                      elevation: 0
                  ),
                  onPressed: _nextPage,
                  child: const Text('التالي'),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

enum ChartType { pointColumn, timeArea, attemptsLinear }



