

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/Vehicle_tybe_controller.dart';

Widget languageWidget(context,Color? color){


  return  Positioned(
              right: 0,
              top: 30,
              child: IconButton(
                icon:  Icon(
                  Icons.language,
                  color: color,
                ),
                onPressed: () =>
                    Provider.of<VehicleTypeController>(context, listen: false)
                        .setLa(!Provider.of<VehicleTypeController>(context,
                                listen: false)
                            .la),
              ));
          
}