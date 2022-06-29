import 'dart:io';
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

class ApplyOrder extends StatefulWidget {
  const ApplyOrder({Key? key}) : super(key: key);

  @override
  State<ApplyOrder> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ApplyOrder> {
  File? orderImage;
  var comment = TextEditingController();
  var ho = TextEditingController();
  var item = TextEditingController();
  int howMany = 1;
  bool wait = false;





  
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    if (wait) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      // floatingActionButton: FloatingActionButton.extended(
      //     shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(5.0))
      // ),
      //   // extendedIconLabelSpacing:100.0,))

      //   label: Text("fkjh"), onPressed: () {  },
      // ),
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              CupertinoIcons.back,
              color: Colors.white,
            )),
        title: Text(
          context.watch<VehicleTypeController>().la
              ? "التفاصيل"
              : "Items details",
          style: const TextStyle(color: Colors.white),
        ),
        actions: [Container(), Container()],
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(context.watch<VehicleTypeController>().la
                ? "ماذا يمكننا أن ننقل  لك؟"
                : "What can we move for you?"),
          ),
          Text(
            context.watch<VehicleTypeController>().la
                ? "اكتب حجم العناصر وما إلى ذلك .."
                : "Write items size etc..",
            style: const TextStyle(color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 16,
              child: TextField(
                textAlign: context.watch<VehicleTypeController>().la
                    ? TextAlign.end
                    : TextAlign.start,
                controller: item,
                decoration: InputDecoration(
                  suffix: Visibility(
                    visible: !context.watch<VehicleTypeController>().la,
                    child: GestureDetector(
                        onTap: () => item.clear(),
                        child: const Icon(Icons.cancel)),
                  ),
                  prefix: Visibility(
                    visible: context.watch<VehicleTypeController>().la,
                    child: GestureDetector(
                        onTap: () => item.clear(),
                        child: const Icon(Icons.cancel)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 16,
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  suffix: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () => setState(() {
                                howMany != 1 ? howMany-- : null;
                              }),
                          child: const Icon(CupertinoIcons.minus)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(howMany.toString()),
                      ),
                      GestureDetector(
                          onTap: () => setState(() {
                                howMany++;
                              }),
                          child: const Icon(CupertinoIcons.add)),
                    ],
                  ),
                  label: Text(context.watch<VehicleTypeController>().la
                      ? "العدد"
                      : "How many?"),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 16,
              child: TextField(
                onTap: () => setPictuer(),
                readOnly: true,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  label: Text(context.watch<VehicleTypeController>().la
                      ? "إضافة الصورة"
                      : "Add picture "),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: context.watch<VehicleTypeController>().la
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Text(context.watch<VehicleTypeController>().la
                        ? "أضف المزيد من التفاصيل"
                        : 'Add more details'),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 13,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        comment.text = value;
                      });
                    },
                    textAlign: context.watch<VehicleTypeController>().la
                        ? TextAlign.end
                        : TextAlign.start,
                    keyboardType: TextInputType.multiline,
                    maxLines: 2,
                    decoration: InputDecoration(
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
              padding: EdgeInsets.only(
                  // left: 10.0,
                  // right: MediaQuery.of(context).size.width / 2.5,
                  top: MediaQuery.of(context).size.height / 9),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                textColor: Colors.white,
                                // color: ,
                                onPressed: () {
                                  if (Provider.of<VehicleTypeController>(
                                                  context,
                                                  listen: false)
                                              .index !=
                                          0 &&
                                      Provider.of<VehicleTypeController>(
                                              context,
                                              listen: false)
                                          .dropPoint
                                          .isNotEmpty &&
                                      Provider.of<VehicleTypeController>(
                                              context,
                                              listen: false)
                                          .firstPoint
                                          .isNotEmpty &&
                                      Provider.of<VehicleTypeController>(
                                                  context,
                                                  listen: false)
                                              .finalFee !=
                                          null) {
                                    var distance = calculateDistance(
                                        LatLng(
                                            double.parse(
                                                Provider.of<VehicleTypeController>(
                                                        context,
                                                        listen: false)
                                                    .firstPoint[1]),
                                            double.parse(
                                                Provider.of<VehicleTypeController>(
                                                        context,
                                                        listen: false)
                                                    .firstPoint[2])),
                                        LatLng(
                                            double.parse(
                                                Provider.of<VehicleTypeController>(
                                                        context,
                                                        listen: false)
                                                    .dropPoint[1]),
                                            double.parse(Provider.of<VehicleTypeController>(context, listen: false).dropPoint[2])));

                                    Provider.of<VehicleTypeController>(context,
                                            listen: false)
                                        .setDestance(
                                            distance.toStringAsFixed(2));

                                    Provider.of<VehicleTypeController>(context,
                                            listen: false)
                                        .setfinalFee(colculatingFedd(
                                            Provider.of<VehicleTypeController>(
                                                    context,
                                                    listen: false)
                                                .chosen['kilo_price'],
                                            Provider.of<VehicleTypeController>(
                                                    context,
                                                    listen: false)
                                                .chosen['sec_price'],
                                            distance));
                                  }

                                  setState(() {
                                    wait = !wait;
                                  });
                                  checkInternetConnection().then((value) => value ==
                                          1
                                      ? makeTrip(
                                              context,
                                              Provider.of<VehicleTypeController>(
                                                      context,
                                                      listen: false)
                                                  .info,
                                              Provider.of<VehicleTypeController>(
                                                      context,
                                                      listen: false)
                                                  .chosen,
                                              "$howMany ${item.text} \n ${comment.text}")
                                          .then((isItDone) =>
                                              Future.delayed(const Duration(microseconds: 1))
                                                  .then((kjfsaghiJK) =>
                                                      mounted && !isItDone
                                                          ? {
                                                              setState(() =>
                                                                  wait = false),
                                                              errono(
                                                                  "تعذر الإتصال بمشغلاتنا، رجاء حاول مرة أخرى",
                                                                  "Unable to contact our operators, please try again",
                                                                  context)
                                                            }
                                                          : null))
                                      : errono(
                                          "تعذر الإتصال بالإنترنت",
                                          "Unable to connect to the Internet",
                                          context));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                        context
                                                .watch<VehicleTypeController>()
                                                .la
                                            ? "إطلب الآن"
                                            : "Apply now",
                                      ),
                                    ),
                                  ),
                                )))),
                  ])),
        ],
      )),
    );
  }

  Future<dynamic> setPictuer() async {
    var picme;
    try {
      await ImagePicker()
          .pickImage(
              source: ImageSource.gallery,
              imageQuality: 100,
              maxHeight: 1000,
              maxWidth: 1000)
          .then((v) async {
        final bytes = (await v!.readAsBytes()).lengthInBytes;
        final kb = bytes / 1024;
        final mb = kb / 1024;
        if (v != null && mb < 1.0) {
          setState(() {
            orderImage = File(v.path);
          });
        } else {
          errono("  حجم الصورة كبير جدا", 'The image is too larg', context);
        }
      });
    } catch (e) {
      // print(e);
    }

    return picme;
  }
}
