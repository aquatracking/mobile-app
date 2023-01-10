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
    var colorScheme = Theme.of(context).colorScheme;
    var color = (widget.measurementSettings.visible || open) ? colorScheme.onSurface : colorScheme.onSurface.withOpacity(0.5);
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
              color: (open) ? colorScheme.surfaceVariant : colorScheme.surface,
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
                  Icon(Icons.drag_handle_rounded, color: color),
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
                            widget.measurementSettings.defaultMode = 5;
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
                              color: (widget.measurementSettings.defaultMode == 5) ? colorScheme.primary : colorScheme.onSurfaceVariant
                          ),
                        ),
                      ),
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
                          '6m',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: (widget.measurementSettings.defaultMode == 4) ? colorScheme.primary : colorScheme.onSurfaceVariant
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
                              color: (widget.measurementSettings.defaultMode == 3) ? colorScheme.primary : colorScheme.onSurfaceVariant
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
                              color: (widget.measurementSettings.defaultMode == 2) ? colorScheme.primary : colorScheme.onSurfaceVariant
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
                              color: (widget.measurementSettings.defaultMode == 1) ? colorScheme.primary : colorScheme.onSurfaceVariant
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
                              color: (widget.measurementSettings.defaultMode == 0) ? colorScheme.primary : colorScheme.onSurfaceVariant
                          ),
                        ),
                      ),
                    ]
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      widget.measurementSettings.maxValue = (value == '') ? null : double.parse(value);
                      setState(() {});
                    },
                    initialValue: (widget.measurementSettings.maxValue != null) ? widget.measurementSettings.maxValue.toString() : '',
                    decoration: const InputDecoration(
                      labelText: 'Valeur maximale',
                      prefixIcon: Icon(
                        Icons.trending_up_rounded,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      widget.measurementSettings.minValue = (value == '') ? null : double.parse(value);
                      setState(() {});
                    },
                    initialValue: (widget.measurementSettings.minValue != null) ? widget.measurementSettings.minValue.toString() : '',
                    decoration: const InputDecoration(
                      labelText: 'Valeur minimum',
                      prefixIcon: Icon(
                        Icons.trending_down_rounded,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SwitchListTile(
                    title: const Text('Notification par mail'),
                    secondary: const Icon(Icons.email_rounded),
                    activeColor: colorScheme.primary,
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
                    activeColor: colorScheme.primary,
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