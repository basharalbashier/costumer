import 'dart:io';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:costumer/helpers/error_snack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../controllers/Vehicle_tybe_controller.dart';
import '../helpers/check_internet.dart';
import '../helpers/make_trip.dart';
import 'models/colculating_distans.dart';
import 'models/colculating_fee.dart';

class LocationDetails extends StatefulWidget {
  const LocationDetails({Key? key}) : super(key: key);

  @override
  State<LocationDetails> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LocationDetails> {
  var name = TextEditingController();
  var phone = TextEditingController();
  var appartment = TextEditingController();

  bool how = true;

  double screenWidth = 0.0;
  double screenHight = 0.0;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHight = MediaQuery.of(context).size.height;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (name.text.isEmpty) {
        name.text = Provider.of<VehicleTypeController>(context, listen: false)
            .info['name'];
        phone.text = Provider.of<VehicleTypeController>(context, listen: false)
            .info['phone'];
      }
    });
    FlutterNativeSplash.remove();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              CupertinoIcons.back,
              color: Colors.white,
            )),
        title: Text(
          context.watch<VehicleTypeController>().la
              ? "تفاصيل الموقع"
              : "Location details",
          style: const TextStyle(color: Colors.white),
        ),
        actions: [Container(), Container()],
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  CommunityMaterialIcons.map_marker,
                ),
                Flexible(
                  child: Text(
                      context.watch<VehicleTypeController>().firstPoint.isEmpty
                          ? ""
                          : context
                              .watch<VehicleTypeController>()
                              .firstPoint[0],
                      style: const TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                width: screenWidth,
                height: screenHight / 8,
                color: Colors.white.withOpacity(0.7),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  // textColor: Colors.white,
                                  color: Colors.white,
                                  onPressed: () => setState(() {
                                        how = !how;
                                      }),
                                  child: SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Checkbox(
                                              value: how, onChanged: (v) {}),
                                          Text(
                                            context
                                                    .watch<
                                                        VehicleTypeController>()
                                                    .la
                                                ? "أنا"
                                                : "I did",
                                          ),
                                          Container()
                                        ],
                                      ),
                                    ),
                                  )))),
                      Expanded(
                          flex: 2,
                          child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  // textColor: Colors.white,
                                  color: Colors.white,
                                  onPressed: () => setState(() {
                                        how = !how;
                                      }),
                                  child: SizedBox(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Checkbox(
                                            value: !how, onChanged: (v) {}),
                                        Text(
                                          context
                                                  .watch<
                                                      VehicleTypeController>()
                                                  .la
                                              ? "شخص آخر"
                                              : "Someone else",
                                        ),
                                        Container()
                                      ],
                                    ),
                                  )))),
                    ])),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: context.watch<VehicleTypeController>().la
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Text(context.watch<VehicleTypeController>().la
                        ? "إسم المشتري"
                        : 'Purchaser Name'),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 16,
                  child: TextField(
                    readOnly: how,
                    controller: name,
                    onSubmitted: (value) {
                      if (name.text.isEmpty) {
                      } else {
                        Provider.of<VehicleTypeController>(context,
                                listen: false)
                            .byerUpdate(name.text);
                      }
                    },
                    textAlign: context.watch<VehicleTypeController>().la
                        ? TextAlign.end
                        : TextAlign.start,
                    decoration: InputDecoration(
                      suffix: Visibility(
                          visible: !context.watch<VehicleTypeController>().la &&
                              !how,
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                  context.watch<VehicleTypeController>().la
                                      ? " تم"
                                      : 'OK'))),
                      prefix: Visibility(
                          visible:
                              context.watch<VehicleTypeController>().la && !how,
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                  context.watch<VehicleTypeController>().la
                                      ? " تم"
                                      : 'OK'))),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: context.watch<VehicleTypeController>().la
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Text(context.watch<VehicleTypeController>().la
                        ? "هاتف المشتري"
                        : 'Purchaser phone number'),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 16,
                  child: TextField(
                    readOnly: how,
                    controller: phone,

                    textAlign: context.watch<VehicleTypeController>().la
                        ? TextAlign.end
                        : TextAlign.start,
                    // keyboardType: TextInputType.multiline,
                    // maxLines: 2,
                    decoration: InputDecoration(
                      suffix: Visibility(
                          visible: !context.watch<VehicleTypeController>().la &&
                              !how,
                          child: TextButton(
                              onPressed: () {
                                if (phone.text.isEmpty) {
                                } else {
                                  Provider.of<VehicleTypeController>(context,
                                          listen: false)
                                      .byerPhoneUpdate(phone.text);
                                }
                              },
                              child: Text(
                                  context.watch<VehicleTypeController>().la
                                      ? " تم"
                                      : 'OK'))),
                      prefix: Visibility(
                          visible:
                              context.watch<VehicleTypeController>().la && !how,
                          child: TextButton(
                              onPressed: () {
                                if (phone.text.isEmpty) {
                                } else {
                                  Provider.of<VehicleTypeController>(context,
                                          listen: false)
                                      .byerPhoneUpdate(phone.text);
                                }
                              },
                              child: Text(
                                  context.watch<VehicleTypeController>().la
                                      ? " تم"
                                      : 'OK'))),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  CommunityMaterialIcons.map_marker,
                ),
                Flexible(
                  child: Text(
                      context.watch<VehicleTypeController>().dropPoint.isEmpty
                          ? ""
                          : context.watch<VehicleTypeController>().dropPoint[0],
                      style: const TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: context.watch<VehicleTypeController>().la
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Text(context.watch<VehicleTypeController>().la
                        ? "رقم الشقة"
                        : 'Appartment number'),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 16,
                  child: TextField(
                    controller: appartment,
                    textAlign: context.watch<VehicleTypeController>().la
                        ? TextAlign.end
                        : TextAlign.start,
                    // keyboardType: TextInputType.multiline,
                    // maxLines: 2,
                    decoration: InputDecoration(
                      suffix: Visibility(
                          visible: !context.watch<VehicleTypeController>().la &&
                              !how,
                          child: TextButton(
                              onPressed: () {
                                Provider.of<VehicleTypeController>(context,
                                        listen: false)
                                    .updateDrop(appartment.text);
                              },
                              child: Text(
                                  context.watch<VehicleTypeController>().la
                                      ? " تم"
                                      : 'OK'))),
                      prefix: Visibility(
                          visible:
                              context.watch<VehicleTypeController>().la ,
                          child: TextButton(
                              onPressed: () {
                                {
                                  Provider.of<VehicleTypeController>(context,
                                          listen: false)
                                      .updateDrop(appartment.text);
                                }
                              },
                              child: Text(
                                  context.watch<VehicleTypeController>().la
                                      ? " تم"
                                      : 'OK'))),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: SizedBox(
          //     height: MediaQuery.of(context).size.height / 16,
          //     child: TextField(
          //       textAlign: context.watch<VehicleTypeController>().la
          //           ? TextAlign.end
          //           : TextAlign.start,
          //       controller: item,
          //       decoration: InputDecoration(
          //         suffix: Visibility(
          //           visible: !context.watch<VehicleTypeController>().la,
          //           child: GestureDetector(
          //               onTap: () => item.clear(),
          //               child: const Icon(Icons.cancel)),
          //         ),
          //         prefix: Visibility(
          //           visible: context.watch<VehicleTypeController>().la,
          //           child: GestureDetector(
          //               onTap: () => item.clear(),
          //               child: const Icon(Icons.cancel)),
          //         ),
          //         focusedBorder: const OutlineInputBorder(
          //           borderSide: BorderSide(width: 1.0),
          //         ),
          //         enabledBorder: OutlineInputBorder(
          //           borderRadius: const BorderRadius.all(Radius.circular(5)),
          //           borderSide: BorderSide(
          //               color: Theme.of(context).colorScheme.primary,
          //               width: 1.0),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height / 20,
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: SizedBox(
          //     height: MediaQuery.of(context).size.height / 16,
          //     child: TextField(
          //       readOnly: true,
          //       decoration: InputDecoration(
          //         suffix: Row(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           children: [
          //             GestureDetector(
          //                 onTap: () => setState(() {
          //                       howMany != 1 ? howMany-- : null;
          //                     }),
          //                 child: const Icon(CupertinoIcons.minus)),
          //             Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Text(howMany.toString()),
          //             ),
          //             GestureDetector(
          //                 onTap: () => setState(() {
          //                       howMany++;
          //                     }),
          //                 child: const Icon(CupertinoIcons.add)),
          //           ],
          //         ),
          //         label: Text(context.watch<VehicleTypeController>().la
          //             ? "العدد"
          //             : "How many?"),
          //         focusedBorder: const OutlineInputBorder(
          //           borderSide: BorderSide(width: 1.0),
          //         ),
          //         enabledBorder: OutlineInputBorder(
          //           borderRadius: const BorderRadius.all(Radius.circular(5)),
          //           borderSide: BorderSide(
          //               color: Theme.of(context).colorScheme.primary,
          //               width: 1.0),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: ListView(
          //     shrinkWrap: true,
          //     children: [
          //       Row(
          //         mainAxisAlignment: context.watch<VehicleTypeController>().la
          //             ? MainAxisAlignment.end
          //             : MainAxisAlignment.start,
          //         children: [
          //           Text(context.watch<VehicleTypeController>().la
          //               ? "أضف المزيد من التفاصيل"
          //               : 'Add more details'),
          //         ],
          //       ),
          //       SizedBox(
          //         height: MediaQuery.of(context).size.height / 13,
          //         child: TextField(
          //           onChanged: (value) {
          //             setState(() {
          //               comment.text = value;
          //             });
          //           },
          //           textAlign: context.watch<VehicleTypeController>().la
          //               ? TextAlign.end
          //               : TextAlign.start,
          //           keyboardType: TextInputType.multiline,
          //           maxLines: 2,
          //           decoration: InputDecoration(
          //             focusedBorder: const OutlineInputBorder(
          //               borderSide: BorderSide(width: 1.0),
          //             ),
          //             enabledBorder: OutlineInputBorder(
          //               borderRadius:
          //                   const BorderRadius.all(Radius.circular(5)),
          //               borderSide: BorderSide(
          //                   color: Theme.of(context).colorScheme.primary,
          //                   width: 1.0),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      )),
    );
  }
}
