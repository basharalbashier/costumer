import 'package:community_material_icon/community_material_icon.dart';
import 'package:costumer/helpers/gradiant_icon.dart';
import 'package:costumer/pages/google_map.dart';
import 'package:costumer/pages/location_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../controllers/Vehicle_tybe_controller.dart';

class PointsCard extends StatefulWidget {
  var info;
  PointsCard(this.info, {Key? key}) : super(key: key);

  @override
  State<PointsCard> createState() => _PointsCardState();
}

class _PointsCardState extends State<PointsCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(()=>const LocationDetails()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
                Card(
                  child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: 
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      context
                                              .watch<VehicleTypeController>()
                                              .firstPoint
                                              .isEmpty
                                          ? context
                                                  .watch<VehicleTypeController>()
                                                  .la
                                              ? 'موقع البداية'
                                              : 'Pick-up locaction'
                                          : context
                                              .watch<VehicleTypeController>()
                                              .firstPoint[0],
                                      // style: Theme.of(context).textTheme.headline6,
                                      // overflow: TextOverflow.fade,
                                      // textAlign: TextAlign.center,
                                      // maxLines: 1,
                                    ),
                                  ),
                                 const Text("A"),
                                ],
                              ),
                            ),
                ),
                        
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Provider.of<VehicleTypeController>(context,
                                              listen: false)
                                          .firstPoint
                                          .isNotEmpty
                                      ? Get.to(() => Mapi(1, widget.info))
                                      : null;
                                },
                                child: Row(
                                  mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        context
                                                .watch<VehicleTypeController>()
                                                .dropPoint
                                                .isEmpty
                                            ? context
                                                    .watch<VehicleTypeController>()
                                                    .la
                                                ? 'موقع الانزال'
                                                : 'Drop-off locaction'
                                            : context
                                                .watch<VehicleTypeController>()
                                                .dropPoint[0],
                                        // style: Theme.of(context).textTheme.headline6,
                                        // overflow: TextOverflow.fade,
                                        // textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const Text("B"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        
          ],
        ),
      ),
    );
    
    
    
    //  Padding(
    //   padding: const EdgeInsets.all(30.0),
    //   child: Card(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(15.0),
    //     ),
    //     elevation: 10,
    //     child: SizedBox(
    //       height: MediaQuery.of(context).size.height / 5,
    //       child: Row(
    //         children: [
    //           // Expanded(
    //           //   flex: 1,
    //           //   child: Column(
    //           //     // mainAxisSize: MainAxisSize.max,
    //           //     // mainAxisAlignment: MainAxisAlignment.start,
    //           //     children: <Widget>[
    //           //       Padding(
    //           //         padding: EdgeInsets.only(top: 10.0),
    //           //         child: GradientIcon(
    //           //           Icons.trip_origin,
    //           //           size: 20,
    //           //           gradient: LinearGradient(colors: [
    //           //             Colors.pink.shade700,
    //           //            Theme.of(context).colorScheme.secondary
    //           //           ]),
    //           //         ),
    //           //       ),
    //           //       for (int i = 0; i < MediaQuery.of(context).size.height/40; i++)
    //           //         Row(mainAxisAlignment: i.isEven?MainAxisAlignment.center:MainAxisAlignment.end,
    //           //           children: [
    //           //             Icon(
    //           //               Icons.circle,
    //           //               size: 5,
    //           //               color:i.isEven? Theme.of(context).colorScheme.primary:Colors.white,
    //           //             ),
    //           //           ],
    //           //         ),
    //           //          GradientIcon(
    //           //           CommunityMaterialIcons.map_marker,
    //           //            size: 25,
    //           //           gradient: LinearGradient(colors: [
    //           //             Colors.pink.shade700,
    //           //            Theme.of(context).colorScheme.secondary
    //           //           ]),
    //           //         ),
                 
    //           //     ],
    //           //   ),
    //           // ),
              
    //           Expanded(
    //             flex: 8,
    //             child: SingleChildScrollView(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: 
    //                     Row(
    //                       children: [
    //                         Expanded(
    //                           child: GestureDetector(
    //                             onTap: () => Get.to(() => Mapi(0, widget.info)),
    //                             child: Text(
    //                               context
    //                                       .watch<VehicleTypeController>()
    //                                       .firstPoint
    //                                       .isEmpty
    //                                   ? context
    //                                           .watch<VehicleTypeController>()
    //                                           .la
    //                                       ? 'موقع البداية'
    //                                       : 'Pick-up locaction'
    //                                   : context
    //                                       .watch<VehicleTypeController>()
    //                                       .firstPoint[0],
    //                               style: Theme.of(context).textTheme.headline6,
    //                               overflow: TextOverflow.fade,
    //                               textAlign: TextAlign.center,
    //                               maxLines: 1,
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   const Divider(),
    //                   Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: GestureDetector(
    //                       onTap: () {
    //                         Provider.of<VehicleTypeController>(context,
    //                                     listen: false)
    //                                 .firstPoint
    //                                 .isNotEmpty
    //                             ? Get.to(() => Mapi(1, widget.info))
    //                             : null;
    //                       },
    //                       child: Row(
    //                         mainAxisAlignment:
    //                             context.watch<VehicleTypeController>().la
    //                                 ? MainAxisAlignment.center
    //                                 : MainAxisAlignment.center,
    //                         children: [
    //                           Expanded(
    //                             child: Text(
    //                               context
    //                                       .watch<VehicleTypeController>()
    //                                       .dropPoint
    //                                       .isEmpty
    //                                   ? context
    //                                           .watch<VehicleTypeController>()
    //                                           .la
    //                                       ? 'موقع الانزال'
    //                                       : 'Drop-off locaction'
    //                                   : context
    //                                       .watch<VehicleTypeController>()
    //                                       .dropPoint[0],
    //                               style: Theme.of(context).textTheme.headline6,
    //                               overflow: TextOverflow.fade,
    //                               textAlign: TextAlign.center,
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
                    
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  
  }
}
