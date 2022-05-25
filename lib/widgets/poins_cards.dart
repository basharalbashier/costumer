import 'package:community_material_icon/community_material_icon.dart';
import 'package:costumer/pages/google_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controllers/Vehicle_tybe_controller.dart';

class PointsCard extends StatefulWidget {
  const PointsCard({Key? key}) : super(key: key);

  @override
  State<PointsCard> createState() => _PointsCardState();
}

class _PointsCardState extends State<PointsCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10,
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 6,
          child: Column(children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                   mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Icon(
                        Icons.trip_origin,
                        size: 15,
                      ),
                      Icon(
                        Icons.circle,
                        size: 5,
                      ),
                      Icon(
                        Icons.circle,
                        size: 5,
                      ),
                      Icon(
                        Icons.circle,
                        size: 5,
                      ),  Icon(
                        Icons.circle,
                        size: 5,
                      ),
                      Icon(
                        Icons.circle,
                        size: 5,
                      ),  Icon(
                        Icons.circle,
                        size: 5,
                      ),
                      Icon(
                        Icons.circle,
                        size: 5,
                      ),
                      Icon(
                        Icons.circle,
                        size: 5,
                      ),
                      Icon(
                        CommunityMaterialIcons.map_marker,
                        size: 20,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                     GestureDetector(
                          onTap: () => Get.to(Mapi(0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                 context.watch<VehicleTypeController>().firstPoint.isEmpty? 'Pick-up locaction':context.watch<VehicleTypeController>().firstPoint[0],
                                  style: Theme.of(context).textTheme.headline6,
                                     overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // ElevatedButton.icon(
                              //   style: ElevatedButton.styleFrom(
                              //       primary: Colors.white),
                              //   onPressed: () {},
                              //   icon: const Icon(
                              //     Icons.alarm,
                              //     color: Colors.blueGrey,
                              //   ),
                              //   label: Text(
                              //     'NOW',
                              //     style: Theme.of(context).textTheme.button,
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => Get.to(Mapi(1)),
                          child: Text(
                          context.watch<VehicleTypeController>().dropPoint.isEmpty?  'Drop-off locaction':context.watch<VehicleTypeController>().dropPoint[0],
                            style: Theme.of(context).textTheme.headline6,
                               overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                       const Divider(),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                          context.watch<VehicleTypeController>().finalFeeData.isEmpty?  '':context.watch<VehicleTypeController>().finalFeeData.toString()+' SAR',
                            style: Theme.of(context).textTheme.headline6,
                            //    overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Divider(),
            // Center(
            //   child: ElevatedButton.icon(
            //     onPressed: () {},
            //     icon: Icon(Icons.add),
            //     label: Text(
            //       'NOW',
            //       style: Theme.of(context).textTheme.button,
            //     ),
            //   ),
            // )
          ]),
        ),
      ),
    );
  }
}
