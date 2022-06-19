import 'package:costumer/controllers/Vehicle_tybe_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../helpers/gradiant_icon.dart';

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
                      BoxShadow(
                          color: context.watch<VehicleTypeController>().count ==
                                  widget.index
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.grey,
                          spreadRadius: 2),
                    ],
                  ),
                  height: 70,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      
                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: 
                          GradientIcon(
                             MdiIcons.tankerTruck,
                          size: 50,
                        gradient: LinearGradient(colors: [
                          Colors.pink.shade700,
                         Theme.of(context).colorScheme.secondary
                        ]),
                      ),
                    
                      ),
                      Flexible(
                        child: ListTile(
                            trailing: SizedBox(
                              width: 55,
                              child: Text(
                                context
                                            .watch<VehicleTypeController>()
                                            .finalFeeData ==
                                        '0.00'
                                    ? ''
                                    : '${context.watch<VehicleTypeController>().finalFeeData} ${context.watch<VehicleTypeController>().la ? 'ر.س' : ' SAR'}',
                                // style: Theme.of(context).textTheme.headline6,
                                textAlign: TextAlign.center,

                                //    overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            title: Text(
                              context.watch<VehicleTypeController>().la
                                  ? widget.vehicle['name']
                                  : widget.vehicle['namee'],
                              textScaleFactor: 1,
                              style: const TextStyle(color: Colors.black),
                            ),
                            subtitle: Visibility(
                                visible: context
                                        .watch<VehicleTypeController>()
                                        .count ==
                                    widget.index,
                                child: Text(context
                                        .watch<VehicleTypeController>()
                                        .la
                                    ? widget.vehicle['cap_ar'].toString()
                                    : widget.vehicle['cap_en'].toString()))),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                right: 18,
                top: 14,
                child: Visibility(
                  visible: context.watch<VehicleTypeController>().count ==
                      widget.index,
                  child: Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ))
          ],
        ),
        Visibility(
          visible: context.watch<VehicleTypeController>().count == widget.index,
          child: Padding(
            padding: const EdgeInsets.only(
                bottom: 30.0, left: 60.0, right: 60.0, top: 8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
                // boxShadow: [
                //   BoxShadow(color: borderColor, spreadRadius: 1),
                // ],
              ),
              height: 100,
              child: Center(
                  child: Text(
                !context.watch<VehicleTypeController>().la
                    ? widget.vehicle['dis_ar']
                    : widget.vehicle['dis_en'],
                style: Theme.of(context).textTheme.caption,
              )),
            ),
          ),
        ),
      ],
    );
  }
}
