import 'package:carousel_slider/carousel_slider.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //use fan_carousel_image_slider
  CarouselController buttonCarouselController = CarouselController();
  final List<String> imagesList = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FanCarouselImageSlider.sliderType1(
          imagesLink: imagesList,
          isAssets: true,
          autoPlay: false,
          sliderHeight: 400,
          showIndicator: true,
          showArrowNav: true,
        ),
        FanCarouselImageSlider.sliderType2(
          imagesLink: imagesList,
          isAssets: false,
          autoPlay: false,
          sliderHeight: 300,
          currentItemShadow: const [],
          sliderDuration: const Duration(milliseconds: 200),
          imageRadius: 0,
          slideViewportFraction: 1.2,
        ),
      ],
    );
  }
}
