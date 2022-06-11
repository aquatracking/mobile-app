import 'package:aquatracking/blocs/abstract_measurements_bloc.dart';
import 'package:aquatracking/model/abstract_measurement_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineMetricChart extends StatelessWidget {
  final String aquariumId;
  final AbstractMeasurementsBloc measurementsBloc;
  final String metric;
  final String unit;
  final int defaultFetchMode;
  const LineMetricChart({Key? key, required this.measurementsBloc, required this.aquariumId, required this.metric, required this.unit, this.defaultFetchMode = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int fetchMode = defaultFetchMode;
    measurementsBloc.fetchMeasurements(aquariumId, fetchMode);

    return StreamBuilder<List<AbstractMeasurementModel>>(
      stream: measurementsBloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<AbstractMeasurementModel> measurements = [];

          int measurementNeeded = 70;
          if(snapshot.data!.length > measurementNeeded) {
            int indexSelector = snapshot.data!.length~/measurementNeeded;
            for(int i = 0; i < snapshot.data!.length; i++) {
              if(i%indexSelector == 0 || i == snapshot.data!.length - 1) {
                measurements.add(snapshot.data![i]);
              }
            }
          } else {
            measurements = snapshot.data!;
          }


          measurements.sort((a, b) => a.value.compareTo(b.value));
          double minValue = measurements.first.value;
          double maxValue = measurements.last.value;
          measurements.sort((a, b) => b.measuredAt.compareTo(a.measuredAt));
          
          DateTime startDate = measurements.first.measuredAt;
          DateTime endDate = measurements.last.measuredAt;
          double nbHours = double.parse(startDate.difference(endDate).inHours.toString());

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$metric ($unit)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).highlightColor
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      fetchMode = 3;
                      measurementsBloc.fetchMeasurements(aquariumId, fetchMode);
                    },
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: const Size(30, 30),
                    ),
                    child: Text(
                      '30j',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: (fetchMode == 3) ? Theme.of(context).highlightColor : Theme.of(context).primaryColor
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      fetchMode = 2;
                      measurementsBloc.fetchMeasurements(aquariumId, fetchMode);
                    },
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: const Size(30, 30),
                    ),
                    child: Text(
                      '7j',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: (fetchMode == 2) ? Theme.of(context).highlightColor : Theme.of(context).primaryColor
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      fetchMode = 1;
                      measurementsBloc.fetchMeasurements(aquariumId, fetchMode);
                    },
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: const Size(30, 30),
                    ),
                    child: Text(
                      '24h',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                          color: (fetchMode == 1) ? Theme.of(context).highlightColor : Theme.of(context).primaryColor
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      fetchMode = 0;
                      measurementsBloc.fetchMeasurements(aquariumId, fetchMode);
                    },
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: const Size(30, 30),
                    ),
                    child: Text(
                      '6h',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: (fetchMode == 0) ? Theme.of(context).highlightColor : Theme.of(context).primaryColor
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      measurementsBloc.fetchMeasurements(aquariumId, fetchMode);
                    },
                    icon: const Icon(Icons.refresh_rounded),
                    splashRadius: 16,
                    iconSize: 16,
                  )
                ],
              ),
              Container(
                width: double.infinity,
                height: 180,
                padding: const EdgeInsets.only(right: 20, top: 10),
                child: LineChart(
                  LineChartData(
                      minX: 0,
                      maxX: nbHours,
                      minY: double.parse((minValue - 0.05).toStringAsFixed(1)),
                      maxY: double.parse((maxValue + 0.05).toStringAsFixed(1)),
                      lineTouchData: LineTouchData(
                        handleBuiltInTouches: true,
                        touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor: Colors.transparent,
                            tooltipRoundedRadius: 0,
                        ),
                      ),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 45,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toStringAsFixed(1),
                              );
                            },
                          ),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              int hours = endDate.subtract(Duration(hours: (value - nbHours).abs().toInt())).toLocal().hour;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Text(
                                  '${hours}h',
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      lineBarsData: [
                        LineChartBarData(
                            isCurved: true,
                            dotData: FlDotData(
                              show: measurements.length < 25,
                            ),
                            spots: [
                              for(AbstractMeasurementModel measurement in measurements)
                                FlSpot(
                                  double.parse((measurement.measuredAt.difference(endDate).inMinutes / 60).toStringAsFixed(4)),
                                  measurement.value,
                                ),
                            ]
                        )
                      ]
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 15)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Dernière',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '${measurements.first.value.toStringAsFixed(2)} $unit',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).highlightColor
                                ),
                              ),
                            ]
                        ),
                        const Padding(padding: EdgeInsets.only(top: 5)),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Minimum',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '${(minValue).toStringAsFixed(2)} $unit',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).highlightColor
                                ),
                              ),
                            ]
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 10)),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Moyenne',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '${(measurements.map((m) => m.value).reduce((a, b) => a + b) / measurements.length).toStringAsFixed(2)} $unit',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).highlightColor
                                ),
                              ),
                            ]
                        ),
                        const Padding(padding: EdgeInsets.only(top: 5)),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Maximum',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '${(maxValue).toStringAsFixed(2)} $unit',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).highlightColor
                                ),
                              ),
                            ]
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}
