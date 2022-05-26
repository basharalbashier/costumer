




  // This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
  import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:costumer/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showCancelBottomSheet( context,id) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Sorry!'),
        message: const Text('Because we care, We would like to know why you cancele the shipping?'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            /// This parameter indicates the action would be a default
            /// defualt behavior, turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              cancelTheTrip(context, id, 1);
            },
            child: const Text('Took too long to get driver'),
          ),
           CupertinoActionSheetAction(
            /// This parameter indicates the action would be a default
            /// defualt behavior, turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
               cancelTheTrip(context, id, 2);
            },
            child: const Text('Because of the price'),
          ),
            CupertinoActionSheetAction(
            /// This parameter indicates the action would be a default
            /// defualt behavior, turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
                cancelTheTrip(context, id, 3);
              // Navigator.pop(context);
            },
            child: const Text('Because of driver attitude'),
          ),
      CupertinoActionSheetAction(
            /// This parameter indicates the action would be a default
            /// defualt behavior, turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              cancelTheTrip(context, id, 4);
            },
            child: const Text('Other'),
          ),
          CupertinoActionSheetAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as delete or exit and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          )
        ],
      ),
    );
  }


  cancelTheTrip(context,id,i)async{

    try{ var response =await http
      .put(Uri.parse('${url}api/orders/$id'), headers: header,body: {

        'status':i.toString()
      })
      ;
print(response.body);
  Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => CheckPoint()),
              (Route<dynamic> route) => false,
            );
}catch(e){
  
}

  }
