import 'package:flutter/material.dart';

Widget statusIcon(String status) {
  print(status + 'ddddddddddddd');

  switch (status) {
    case '7':
      return Row(
        children: [
          Text('Status : Driver is on the way'),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: CircularProgressIndicator(
              backgroundColor: Colors.pink.shade200,
              strokeWidth: .5,
            ),
          ),
        ],
      );
    case '8':
      return Row(
        children: [
          Text('Status : Driver has arrived at pick-up point'),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: CircularProgressIndicator(
              backgroundColor: Colors.pink.shade200,
              strokeWidth: .5,
            ),
          ),
        ],
      );
    case '9':
      return Row(
        children: [
          Text('Status : Driver is on the way to the drop point'),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: CircularProgressIndicator(
              backgroundColor: Colors.pink.shade200,
              strokeWidth: .5,
            ),
          ),
        ],
      );
    case '10':
      return Row(
        children: [
          Text('Status : Driver has arrived  the drop point'),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: CircularProgressIndicator(
              backgroundColor: Colors.pink.shade200,
              strokeWidth: .5,
            ),
          ),
        ],
      );
    case '11':
      return Row(
        children: [
          Text('Thank you for trust, Would you mind to rate the driver?'),
        ],
      );
  }
  return Row(
    children: [
      Text('Status : Searching for a vehicle'),
      Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: CircularProgressIndicator(
          backgroundColor: Colors.pink.shade200,
          strokeWidth: .5,
        ),
      ),
    ],
  );
}
