import 'package:costumer/pages/models/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../controllers/Vehicle_tybe_controller.dart';

class SlidingHeadings extends StatefulWidget {
  const SlidingHeadings({Key? key}) : super(key: key);

  @override
  State<SlidingHeadings> createState() => _SlidingHeadingsState();
}

class _SlidingHeadingsState extends State<SlidingHeadings> {
  List pointsList=[];
  getData()async{
    var points=await DBProvider.db.getPoints();
  if(points!=0){
     setState(() {
     pointsList=points;   
   });
  }
  }
  @override
  void initState() {
   getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(pointsList.isEmpty){
      return Container();
    }
    return ImageSlideshow(
      width: double.infinity,
      height: 200,
      initialPage: 0,
      indicatorColor:Theme.of(context).colorScheme.secondary,
      indicatorBackgroundColor: Colors.white,
      onPageChanged: (value) {
        // debugPrint('Page changed: $value');
      },
      // autoPlayInterval: 3000,
      isLoop: true,
      children: [
       for(var i in pointsList)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
             
                                  Provider.of<VehicleTypeController>(context,listen: false)
                                      .setFirstPoint([i['address'],i['late'],i['longe']]);
            },
            child: Container(
              decoration:  BoxDecoration(
                    gradient: LinearGradient(colors: [
                          Colors.pink.shade700,
                         Theme.of(context).colorScheme.secondary
                        ]),
                  borderRadius: BorderRadius.all( Radius.circular(20))),
              child: Stack(
                children: [
                GoogleMap(
                
                   
                    myLocationButtonEnabled: false,
                    initialCameraPosition:CameraPosition(
                       tilt: 59.440717697143555,
                        target: LatLng(double.parse(i['late']),double.parse(i['late'])),
                        zoom: 20.151926040649414,
                      ),  ),
                  Center(child: Text(i['address'],textAlign: TextAlign.center,)),
                ],
              ),
            ),
          ),
        ),
      
      ],
    );
  }
}
