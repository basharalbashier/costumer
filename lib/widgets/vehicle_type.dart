import 'package:costumer/controllers/Vehicle_tybe_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class VehicleType extends StatefulWidget {
  var vehicle;
  int? index;
  VehicleType(this.vehicle, this.index, {Key? key}) : super(key: key);

  @override
  State<VehicleType> createState() => _VehicleTypeState();
}

class _VehicleTypeState extends State<VehicleType> {
  var borderColor = Colors.grey;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
              child: GestureDetector(
                onTap: () {
                  context.read<VehicleTypeController>().setIndex(widget.index!);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: context.watch<VehicleTypeController>().count==widget.index?Colors.orange:Colors.grey, spreadRadius: 1),
                    ],
                  ),
                  height: 70,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          MdiIcons.tankerTruck,
                          size: 50,
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                            title: Text(
                              widget.vehicle['name'],
                              textScaleFactor: 1,
                              style: TextStyle(color: Colors.black),
                            ),
                            subtitle: Text(widget.vehicle['cap_en'])),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                right: 20,
                top: 15,
                child: Visibility(
                  visible:context.watch<VehicleTypeController>().count==widget.index,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.orange,
                  ),
                ))
          ],
        ),
        Visibility(
          visible: context.watch<VehicleTypeController>().count==widget.index,
          child: Padding(
            padding: const EdgeInsets.only(
                bottom: 30.0, left: 60.0, right: 60.0, top: 8),
            child: Container(
              child: Center(
                  child: Text(
                widget.vehicle['dis_en'],
                style: Theme.of(context).textTheme.caption,
              )),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
                // boxShadow: [
                //   BoxShadow(color: borderColor, spreadRadius: 1),
                // ],
              ),
              height: 100,
            ),
          ),
        ),
      ],
    );
  }
}
