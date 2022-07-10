import 'package:aquatracking/component/inputs/number_input.dart';
import 'package:aquatracking/model/measurement_settings_model.dart';
import 'package:flutter/material.dart';

class MeasurementSettingsCard extends StatefulWidget{
  final MeasurementSettingsModel measurementSettings;

  const MeasurementSettingsCard({Key? key, required this.measurementSettings}) : super(key: key);

  @override
  State<MeasurementSettingsCard> createState() => _MeasurementSettingsCardState();
}

class _MeasurementSettingsCardState extends State<MeasurementSettingsCard> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    var color = (widget.measurementSettings.visible || open) ? Colors.white : Colors.grey;
    return InkWell(
      onTap: () {
        setState(() {
          open = !open;
        });
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              color: (open) ? Theme.of(context).highlightColor : Theme.of(context).backgroundColor,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => {
                      widget.measurementSettings.visible = !widget.measurementSettings.visible,
                      setState(() {})
                    },
                    icon: (widget.measurementSettings.visible) ? Icon(Icons.visibility_rounded, color: color) : Icon(Icons.visibility_off_rounded, color: color),
                  ),
                  Text(widget.measurementSettings.type.name, style: TextStyle(color: color)),
                  const Spacer(),
                  Icon(Icons.menu, color: color),
                ]
              ),
            ),
            if(open) Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Mode par défaut :"),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.measurementSettings.defaultMode = 4;
                          });
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
                              color: (widget.measurementSettings.defaultMode == 4) ? Theme.of(context).highlightColor : Theme.of(context).primaryColor
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.measurementSettings.defaultMode = 3;
                          });
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
                              color: (widget.measurementSettings.defaultMode == 3) ? Theme.of(context).highlightColor : Theme.of(context).primaryColor
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.measurementSettings.defaultMode = 2;
                          });
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
                              color: (widget.measurementSettings.defaultMode == 2) ? Theme.of(context).highlightColor : Theme.of(context).primaryColor
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.measurementSettings.defaultMode = 1;
                          });
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
                              color: (widget.measurementSettings.defaultMode == 1) ? Theme.of(context).highlightColor : Theme.of(context).primaryColor
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.measurementSettings.defaultMode = 0;
                          });
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
                              color: (widget.measurementSettings.defaultMode == 0) ? Theme.of(context).highlightColor : Theme.of(context).primaryColor
                          ),
                        ),
                      ),
                    ]
                  ),
                  NumberInput(
                    label: 'Valeur minimum',
                    icon: Icons.arrow_downward,
                    defaultValue: (widget.measurementSettings.minValue != null) ? widget.measurementSettings.minValue.toString() : '',
                    onChanged: (value) {
                      widget.measurementSettings.minValue = (value == '') ? null : double.parse(value);
                      setState(() {});
                    },
                  ),
                  NumberInput(
                    label: 'Valeur maximum',
                    icon: Icons.arrow_upward,
                    defaultValue: (widget.measurementSettings.maxValue != null) ? widget.measurementSettings.maxValue.toString() : '',
                    onChanged: (value) {
                      widget.measurementSettings.maxValue = (value == '') ? null : double.parse(value);
                      setState(() {});
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Notification par mail'),
                    secondary: const Icon(Icons.email_rounded),
                    activeColor: Theme.of(context).highlightColor,
                    contentPadding: const EdgeInsets.all(0),
                    value: widget.measurementSettings.mailAlert,
                    onChanged: (value) {
                      widget.measurementSettings.mailAlert = value;
                      setState(() {});
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Notification push'),
                    secondary: const Icon(Icons.notifications_rounded),
                    activeColor: Theme.of(context).highlightColor,
                    contentPadding: const EdgeInsets.all(0),
                    value: widget.measurementSettings.notificationAlert,
                    onChanged: (value) {
                      widget.measurementSettings.notificationAlert = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}