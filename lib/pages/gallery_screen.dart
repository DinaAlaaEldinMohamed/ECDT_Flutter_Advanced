import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  CarouselController buttonCarouselController = CarouselController();
  int _currentImageIndex = 0;
  final List<String> imagesList = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    //Carousel slider package
    return Stack(
      children: [
        CarouselSlider(
          carouselController: buttonCarouselController,
          options: CarouselOptions(
              height: 400.0,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 10),
              viewportFraction: 0.9,
              initialPage: 2,
              onPageChanged: (index, reason) {
                _currentImageIndex = index;
                setState(() {});
              }),
          items: imagesList.map((img) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.asset(
                      img,
                      fit: BoxFit.cover,
                    ));
              },
            );
          }).toList(),
        ),
        Positioned(
          right: 10,
          top: 180,
          child: IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () => buttonCarouselController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 180,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => buttonCarouselController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: 0,
          right: 0,
          child: DotsIndicator(
            dotsCount: imagesList.length,
            position: _currentImageIndex,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
        )
      ],
    );
  }
}
