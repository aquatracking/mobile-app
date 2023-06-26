import 'package:aquatracking/blocs/measurements_bloc.dart';
import 'package:aquatracking/component/aquarium_detail_tile.dart';
import 'package:aquatracking/component/aquarium_measurement_stats_tile.dart';
import 'package:aquatracking/model/aquarium_model.dart';
import 'package:aquatracking/model/measurement_model.dart';
import 'package:aquatracking/model/measurement_settings_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AquariumMeasurementScreen extends StatefulWidget {
  final AquariumModel aquarium;
  final MeasurementSettingsModel metric;

  const AquariumMeasurementScreen({Key? key, required this.aquarium, required this.metric}) : super(key: key);

  @override
  State<AquariumMeasurementScreen> createState() => _AquariumMeasurementScreenState();
}

class _AquariumMeasurementScreenState extends State<AquariumMeasurementScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final measurementsBloc = MeasurementsBloc(aquarium: widget.aquarium, measurementType: widget.metric.type);
    measurementsBloc.fetchMeasurements(widget.metric.defaultMode);

    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.aquarium.name + ' - ' + widget.metric.type.name),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        )
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<MeasurementModel>>(
          stream: measurementsBloc.stream,
          builder: (context, snapshot) {
            List<MeasurementModel> measurements = [];
            if(snapshot.hasData) {
              List<MeasurementModel> data = snapshot.data!;

              // reduce the number of measurements to display
              if(data.isNotEmpty && data.length > 150) {
                int cap = (data.length-2) ~/ 100;

                measurements.add(data[0]);
                for(int i = 1; i < (data.length - 1); i += cap) {
                  List<MeasurementModel> toReduce = data.sublist(i, (((data.length - 1) - i) < cap) ? (data.length - 1) : (i + cap));
                  MeasurementModel reduced = MeasurementModel(
                    id: toReduce[0].id,
                    value: double.parse((toReduce.map((e) => e.value).reduce((value, element) => value + element) / toReduce.length).toStringAsFixed(2)),
                    measuredAt: toReduce.map((e) => e.measuredAt).reduce((value, element) => value.isAfter(element) ? value : element),
                  );
                  measurements.add(reduced);
                }
                measurements.add(data[data.length - 1]);
              } else {
                measurements = data;
              }
            }

            int fetchMode = measurementsBloc.lastFetchMode;
            DateTime endDate = DateTime.now();
            DateTime startDate = endDate.subtract((fetchMode == 0) ? const Duration(hours: 6) : (fetchMode == 1) ? const Duration(days: 1) : (fetchMode == 2) ? const Duration(days: 7) : (fetchMode == 3) ? const Duration(days: 30) : (fetchMode == 4) ? const Duration(days: 365~/2) : const Duration(days: 365));
            double nbMinutes = double.parse(endDate.difference(startDate).inMinutes.toString());

            MeasurementModel? minMeasurement = (measurements.isNotEmpty) ? measurements[0] : null;
            MeasurementModel? maxMeasurement = (measurements.isNotEmpty) ? measurements[0] : null;
            MeasurementModel? lastMeasurement = (measurements.isNotEmpty) ? measurements.last : null;
            double sumOfMeasurements = (measurements.isNotEmpty) ? measurements[0].value : 0;
            MeasurementModel? maxVariation = (measurements.isNotEmpty) ? MeasurementModel(id: '', value: 0, measuredAt: measurements[0].measuredAt) : null;

            for(int i = 1; i < measurements.length; i++) {
              // get max measurement
              if(measurements[i].value > maxMeasurement!.value) {
                maxMeasurement = measurements[i];
              }

              // get min measurement
              if(measurements[i].value < minMeasurement!.value) {
                minMeasurement = measurements[i];
              }

              // get sum of measurements
              sumOfMeasurements += measurements[i].value;

              // get max variation
              double variation = double.parse((measurements[i].value - measurements[i-1].value).toStringAsFixed(2));
              if(variation.abs() > maxVariation!.value.abs()) {
                maxVariation.value = variation;
                maxVariation.measuredAt = measurements[i].measuredAt;
              }
            }

            // get average measurement
            double? averageMeasurement = (measurements.isNotEmpty) ? double.parse((sumOfMeasurements / measurements.length).toStringAsFixed(2)) : null;

            // get range of variation
            double? diff = (measurements.isNotEmpty) ? double.parse((maxMeasurement!.value - minMeasurement!.value).toStringAsFixed(2)) : null;

            double minY = 0;
            double maxY = 0;
            if(measurements.isNotEmpty) {
              minY = double.parse(minMeasurement!.value.toStringAsFixed(1));
              maxY = double.parse(maxMeasurement!.value.toStringAsFixed(1));
            }
            double rangeY = double.parse((maxY - minY).toStringAsFixed(1));
            double horizontalInterval = (maxY - minY) / 5;

            // todo : optimize calculation of the interval
            if(rangeY <= 0.5) {
              minY -= (0.5 - rangeY) / 2;
              minY = double.parse(minY.toStringAsFixed(1));
              if(minY < 0) {
                minY = 0;
              }
              maxY = minY + 0.5;
              rangeY = maxY - minY;
              horizontalInterval = (maxY - minY) / 5;
            } else if(rangeY <= 1) {
              minY -= (1 - rangeY) / 2;
              minY = double.parse(minY.toStringAsFixed(1));
              if(minY < 0) {
                minY = 0;
              }
              maxY = minY + 1;
              rangeY = maxY - minY;
              horizontalInterval = (maxY - minY) / 5;
            } else if(rangeY <= 5) {
              minY -= (5 - rangeY) / 2;
              minY = double.parse(minY.toStringAsFixed(0));
              if(minY < 0) {
                minY = 0;
              }
              maxY = minY + 5;
              rangeY = maxY - minY;
              horizontalInterval = (maxY - minY) / 5;
            } else if(rangeY <= 10) {
              minY -= (10 - rangeY) / 2;
              minY = double.parse(minY.toStringAsFixed(1));
              if(minY < 0) {
                minY = 0;
              }
              maxY = minY + 10;
              rangeY = maxY - minY;
              horizontalInterval = (maxY - minY) / 5;
            } else if(rangeY <= 25) {
              minY -= (25 - rangeY) / 2;
              minY = double.parse(minY.toStringAsFixed(1));
              if(minY < 0) {
                minY = 0;
              }
              maxY = minY + 25;
              rangeY = maxY - minY;
              horizontalInterval = (maxY - minY) / 5;
            } else if(rangeY <= 50) {
              minY -= (50 - rangeY) / 2;
              minY = double.parse(minY.toStringAsFixed(1));
              if(minY < 0) {
                minY = 0;
              }
              maxY = minY + 50;
              rangeY = maxY - minY;
              horizontalInterval = (maxY - minY) / 5;
            }

            double verticalInterval = 0.0;
            switch(measurementsBloc.lastFetchMode) {
              case 0:
                verticalInterval = (nbMinutes ~/ 6).toDouble();
                break;
              case 1:
                verticalInterval = (nbMinutes ~/ 4).toDouble();
                break;
              case 2:
                verticalInterval = (nbMinutes ~/ 7).toDouble();
                break;
              case 3:
                verticalInterval = (nbMinutes ~/ 6).toDouble();
                break;
              case 4:
                verticalInterval = (nbMinutes ~/ 6).toDouble();
                break;
              case 5:
                verticalInterval = (nbMinutes ~/ 6).toDouble();
                break;
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: LineChart(
                      LineChartData(
                        minX: 0,
                        maxX: nbMinutes,
                        minY: minY,
                        maxY: maxY,
                        gridData: FlGridData(
                          show: true,
                          horizontalInterval: horizontalInterval,
                          verticalInterval: verticalInterval,
                          drawHorizontalLine: true,
                          drawVerticalLine: true,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: colorScheme.onSurface.withOpacity(0.2),
                              strokeWidth: 1,
                            );
                          },
                          getDrawingVerticalLine: (value) {
                            return FlLine(
                              color: colorScheme.onSurface.withOpacity(0.2),
                              strokeWidth: 1,
                            );
                          },
                        ),
                        lineTouchData: LineTouchData(
                          enabled: true,
                          touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor: colorScheme.surface,
                            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                              return touchedBarSpots.map((flSpot) {
                                return LineTooltipItem(
                                  '${flSpot.y.toStringAsFixed(2)}${widget.metric.type.unit} ${DateFormat('dd/MM/yyyy HH:mm').format(startDate.add(Duration(minutes: flSpot.x.toInt())))}',
                                  TextStyle(color: colorScheme.onSurface),
                                );
                              }).toList();
                            },
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(color: colorScheme.onSurface.withOpacity(0.2), width: 1),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            color: colorScheme.secondary,
                            spots: [
                              for(MeasurementModel measurement in measurements)
                                FlSpot(double.parse(measurement.measuredAt.difference(startDate).inMinutes.toString()), measurement.value),
                            ],
                            isCurved: false,
                            barWidth: 2,
                            dotData: FlDotData(
                              show: (measurements.length > 10) ? false : true,
                              getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                                radius: 4,
                                color: colorScheme.onPrimary,
                                strokeWidth: 1,
                                strokeColor: colorScheme.primary,
                              ),
                            )
                          ),
                        ],
                        titlesData: FlTitlesData(
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            )
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false
                            )
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              interval: verticalInterval,
                              getTitlesWidget: (value, meta) {
                                DateTime date = startDate.add(Duration(minutes: value.toInt()));

                                String text = DateFormat('HH:mm').format(date);
                                if(measurementsBloc.lastFetchMode > 1) {
                                  text = DateFormat('dd/MM').format(date);
                                }
                                if(measurementsBloc.lastFetchMode > 3) {
                                  text = DateFormat.LLL('fr').format(date);
                                }

                                return Text(
                                  text,
                                  style: TextStyle(color: colorScheme.onSurface),
                                );
                              }
                            )
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: horizontalInterval,
                              reservedSize: 45,
                            )
                          ),
                        )
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  child: ToggleButtons(
                    borderRadius: BorderRadius.circular(90),
                    borderColor: Theme.of(context).colorScheme.outline,
                    selectedColor: Theme.of(context).colorScheme.onSecondaryContainer,
                    color: Theme.of(context).colorScheme.onSurface,
                    fillColor: Theme.of(context).colorScheme.secondaryContainer,
                    selectedBorderColor: Theme.of(context).colorScheme.outline,
                    onPressed: (int index) {
                      measurementsBloc.fetchMeasurements(index);
                    },
                    children: const [
                      Text('6h'),
                      Text('24h'),
                      Text('7j'),
                      Text('30j'),
                      Text('6m'),
                      Text('1a'),
                    ],
                    isSelected: <bool>[
                      measurementsBloc.lastFetchMode == 0,
                      measurementsBloc.lastFetchMode == 1,
                      measurementsBloc.lastFetchMode == 2,
                      measurementsBloc.lastFetchMode == 3,
                      measurementsBloc.lastFetchMode == 4,
                      measurementsBloc.lastFetchMode == 5,
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 2),
                  child: Card(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Période',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            AquariumDetailTile(metric: 'Du', value: DateFormat('EEEE d MMMM y à HH:mm', 'fr').format(startDate)),
                            AquariumDetailTile(metric: 'Au', value: DateFormat('EEEE d MMMM y à HH:mm', 'fr').format(endDate)),
                          ],
                        ),
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 16),
                  child: Card(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Statistiques',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            AquariumDetailStatsTile(measurementSettings: widget.metric, stats: 'Dernière', measurement: lastMeasurement, warningDesignation: 'La dernière valeur', showDate: true),
                            AquariumDetailStatsTile(measurementSettings: widget.metric, stats: 'Minimum', measurement: minMeasurement, warningDesignation: 'La valeur la plus basse', showDate: true),
                            AquariumDetailStatsTile(measurementSettings: widget.metric, stats: 'Maximum', measurement: maxMeasurement, warningDesignation: 'La valeur la plus haute', showDate: true),
                            AquariumDetailStatsTile(measurementSettings: widget.metric, stats: 'Moyenne', measurement: (averageMeasurement != null) ? MeasurementModel(id: '', value: averageMeasurement, measuredAt: DateTime.now()) : null, warningDesignation: 'La moyenne des valeurs', showDate: false),
                            AquariumDetailStatsTile(measurementSettings: widget.metric, stats: 'Tranche de variation', measurement: (diff != null) ? MeasurementModel(id: '', value: diff, measuredAt: DateTime.now()) : null),
                            AquariumDetailStatsTile(measurementSettings: widget.metric, stats: 'Variation maximal', measurement: (measurements.length > 1) ? maxVariation : null, showDate: true),
                          ],
                        ),
                      )
                  ),
                ),
              ],
            );
          },
        ),
      )
    );
  }
}