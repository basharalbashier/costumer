import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class SlidingHeadings extends StatefulWidget {
  const SlidingHeadings({Key? key}) : super(key: key);

  @override
  State<SlidingHeadings> createState() => _SlidingHeadingsState();
}

class _SlidingHeadingsState extends State<SlidingHeadings> {
  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      width: double.infinity,
      height: 200,
      initialPage: 0,
      indicatorColor: Colors.white,
      indicatorBackgroundColor: Colors.grey,
      onPageChanged: (value) {
        // debugPrint('Page changed: $value');
      },
      autoPlayInterval: 3000,
      isLoop: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(const Radius.circular(20))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.pink,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        ),
      ],
    );
  }
}
