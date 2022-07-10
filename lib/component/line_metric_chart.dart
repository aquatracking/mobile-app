import 'package:aquatracking/blocs/measurements_bloc.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/model/measurement_model.dart';
import 'package:aquatracking/model/measurement_settings_model.dart';
import 'package:aquatracking/model/measurement_type_model.dart';
import 'package:aquatracking/utils/date_tools.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineMetricChart extends StatelessWidget {
  final AquariumModel aquarium;
  final MeasurementSettingsModel measurementSettings;
  const LineMetricChart({Key? key, required this.aquarium, required this.measurementSettings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int fetchMode = measurementSettings.defaultMode;
    var measurementType = measurementSettings.type;
    final measurementsBloc = MeasurementsBloc(aquarium: aquarium, measurementType: measurementType);
    measurementsBloc.fetchMeasurements(fetchMode);

    return StreamBuilder<List<MeasurementModel>>(
      stream: measurementsBloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          List<MeasurementModel> measurements = [];

          // Reduce metrics numbers
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

          DateTime endDate = DateTime.now();
          DateTime startDate = endDate.subtract((fetchMode == 0) ? const Duration(hours: 6) : (fetchMode == 1) ? const Duration(days: 1) : (fetchMode == 2) ? const Duration(days: 7) : (fetchMode == 3) ? const Duration(days: 30) : (fetchMode == 4) ? const Duration(days: 365~/2) : const Duration(days: 365));
          double nbMinutes = double.parse(endDate.difference(startDate).inMinutes.toString());

          double minValue = 0;
          double maxValue = 0;
          double avg = 0;

          if(measurements.isNotEmpty) {
            measurements.sort((a, b) => a.value.compareTo(b.value));
            minValue = measurements.first.value;
            maxValue = measurements.last.value;
            measurements.sort((a, b) => a.measuredAt.compareTo(b.measuredAt));

            avg = measurements.map((m) => m.value).reduce((a, b) => a + b) / measurements.length;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 5),
                  Text(
                    measurementType.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).highlightColor
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      fetchMode = 5;
                      measurementsBloc.fetchMeasurements(fetchMode);
                    },
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: const Size(30, 30),
                    ),
                    child: Text(
                      '1a',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: (fetchMode == 5) ? Theme.of(context).highlightColor : Theme.of(context).primaryColor
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      fetchMode = 4;
                      measurementsBloc.fetchMeasurements(fetchMode);
                    },
                    style: TextButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: const Size(30, 30),
                    ),
                    child: Text(
                      '6m',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: (fetchMode == 4) ? Theme.of(context).highlightColor : Theme.of(context).primaryColor
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      fetchMode = 3;
                      measurementsBloc.fetchMeasurements(fetchMode);
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
                      measurementsBloc.fetchMeasurements(fetchMode);
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
                      measurementsBloc.fetchMeasurements(fetchMode);
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
                      measurementsBloc.fetchMeasurements(fetchMode);
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
                  const Spacer(),
                  IconButton(
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      measurementsBloc.fetchMeasurements(fetchMode);
                    },
                    icon: const Icon(Icons.refresh_rounded),
                    splashRadius: 16,
                    iconSize: 16,
                  )
                ],
              ),
              if(measurements.isEmpty) _buildVoidGraph(fetchMode, nbMinutes, endDate)
              else _buildGraph(measurements, fetchMode, measurementType, maxValue, minValue, nbMinutes, endDate),
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
                                measurements.isNotEmpty ? '${measurements.last.value.toStringAsFixed(2)} ${measurementType.unit}' : '-- ${measurementType.unit}',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: (measurementSettings.maxValue != null || measurementSettings.minValue != null) && measurements.isNotEmpty ? ((measurementSettings.maxValue != null && measurements.last.value >= measurementSettings.maxValue!) || (measurementSettings.minValue != null && measurements.last.value < measurementSettings.minValue!)) ? Colors.redAccent : Colors.greenAccent : Theme.of(context).highlightColor
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
                                measurements.isNotEmpty ? '${(minValue).toStringAsFixed(2)} ${measurementType.unit}' : '-- ${measurementType.unit}',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: (measurementSettings.maxValue != null || measurementSettings.minValue != null) && measurements.isNotEmpty ? ((measurementSettings.maxValue != null && minValue >= measurementSettings.maxValue!) || (measurementSettings.minValue != null && minValue < measurementSettings.minValue!)) ? Colors.redAccent : Colors.greenAccent : Theme.of(context).highlightColor
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
                                measurements.isNotEmpty ? '${(avg).toStringAsFixed(2)} ${measurementType.unit}' : '-- ${measurementType.unit}',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: (measurementSettings.maxValue != null || measurementSettings.minValue != null) && measurements.isNotEmpty ? ((measurementSettings.maxValue != null && avg >= measurementSettings.maxValue!) || (measurementSettings.minValue != null && avg < measurementSettings.minValue!)) ? Colors.redAccent : Colors.greenAccent : Theme.of(context).highlightColor
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
                                measurements.isNotEmpty ? '${(maxValue).toStringAsFixed(2)} ${measurementType.unit}' : '-- ${measurementType.unit}',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: (measurementSettings.maxValue != null || measurementSettings.minValue != null) && measurements.isNotEmpty ? ((measurementSettings.maxValue != null && maxValue >= measurementSettings.maxValue!) || (measurementSettings.minValue != null && maxValue < measurementSettings.minValue!)) ? Colors.redAccent : Colors.greenAccent : Theme.of(context).highlightColor
                                ),
                              ),
                            ]
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
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

  Widget _buildGraph(List<MeasurementModel> measurements, int fetchMode, MeasurementTypeModel measurementType, double maxValue, double minValue, nbMinutes, endDate) {
    double valueDifference = maxValue - minValue;
    double valueInterval;
    double valueMaxInterval;
    double valueMinInterval;

    if(valueDifference <= 0.5) {
      valueInterval = 0.1;
    } else if(valueDifference <= 1) {
      valueInterval = 0.2;
    } else if(valueDifference <= 5) {
      valueInterval = 0.5;
    } else if(valueDifference <= 100) {
      valueInterval = double.parse((valueDifference / 10).toStringAsFixed(0));
    } else {
      valueInterval =  50;
    }

    valueMinInterval = (minValue / valueInterval).floor() * valueInterval;
    valueMaxInterval = (maxValue / valueInterval).ceil() * valueInterval;

    if(valueDifference == 0.0) valueMaxInterval = valueMaxInterval + valueInterval;

    return Container(
      width: double.infinity,
      height: 180,
      padding: const EdgeInsets.only(right: 20, top: 10),
      child: LineChart(
        LineChartData(
            maxX: nbMinutes,
            minX: 0,
            minY: valueMinInterval,
            maxY: valueMaxInterval,
            lineTouchData: LineTouchData(
              handleBuiltInTouches: true,
              touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: Colors.transparent,
                  tooltipRoundedRadius: 0,
                  getTooltipItems: (List<LineBarSpot> spots) {
                    return spots.map((barSpot) {
                      DateTime date = endDate.subtract(Duration(minutes: (nbMinutes - barSpot.x).toInt()));

                      return LineTooltipItem(
                        '${barSpot.y.toStringAsFixed(2)}${measurementType.unit.isNotEmpty ? ' ${measurementType.unit}' : ''} - ${DateTools.convertDateToLongDateAndTimeString(date)}',
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      );
                    }).toList();
                  }
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
                  interval: valueInterval,
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
                  interval: (nbMinutes~/4).toDouble(),
                  getTitlesWidget: (value, meta) {
                    DateTime date = endDate.subtract(Duration(minutes: (nbMinutes - value).toInt()));

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: (fetchMode == 0 || fetchMode == 1) ? Text(
                        DateTools.convertDateToShortTimeString(date),
                      ) : Text(
                        DateTools.convertDateToShortDateString(date),
                      ),
                    );
                  },
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              verticalInterval: (nbMinutes~/4).toDouble(),
              horizontalInterval: valueInterval,
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: Colors.blueGrey,
                width: 0.2,
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                  isCurved: true,
                  dotData: FlDotData(
                    show: measurements.length < 25,
                  ),
                  spots: [
                    for(MeasurementModel measurement in measurements)
                      FlSpot(
                        nbMinutes - endDate.difference(measurement.measuredAt).inMinutes.toDouble(),
                        measurement.value,
                      ),
                  ]
              )
            ]
        ),
      ),
    );
  }
  Widget _buildVoidGraph(int fetchMode, double nbMinutes, endDate) {
    return Container(
      width: double.infinity,
      height: 180,
      padding: const EdgeInsets.only(right: 20, top: 10),
      child: LineChart(
        LineChartData(
            maxX: nbMinutes,
            minX: 0,
            minY: 0,
            maxY: 1,
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
                  interval: 0.2,
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
                  interval: (nbMinutes~/4).toDouble(),
                  getTitlesWidget: (value, meta) {
                    DateTime date = endDate.subtract(Duration(minutes: (nbMinutes - value).toInt()));

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: (fetchMode == 0 || fetchMode == 1) ? Text(
                        DateTools.convertDateToShortTimeString(date),
                      ) : Text(
                        DateTools.convertDateToShortDateString(date),
                      ),
                    );
                  },
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              verticalInterval: (nbMinutes~/4).toDouble(),
              horizontalInterval: 0.2,
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: Colors.blueGrey,
                width: 0.2,
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                  isCurved: true,
                  spots: [
                  ]
              )
            ]
        ),
      ),
    );
  }
}
