import 'index.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> homeButtonList = [
  {
    'image': 'assets/images/gym.png',
    'title': 'Fitness Hareketleri',
    'onTap': (BuildContext context) {
      Navigator.push(
          context, RouteAnimation.createRoute(FitnessMovementsScreen(), 1, 0));
    },
  },
  {
    'image': 'assets/images/educator.png',
    'title': 'Eğitmenler',
    'onTap': () {},
  },
  {
    'image': 'assets/images/training-video.png',
    'title': 'Eğitim Videoları',
    'onTap': () {},
  },
];
