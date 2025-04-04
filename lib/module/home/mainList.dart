import 'package:fitness_app/module/coaches/coaches_screen.dart';
import 'package:fitness_app/module/education_videos/education_categories_screen.dart';

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
    'title': 'Kişisel Antrenörler',
    'onTap': (BuildContext context) {
      Navigator.push(
          context, RouteAnimation.createRoute(CoachesScreen(), 1, 0));
    },
    'coaches': [
      {
        'photo': 'assets/images/man.png',
        'name': 'Mehmet Yılmaz',
        'age': 45,
        'field': 'Kuvvet ve Kondisyon',
        'description':
            '20 yıllık deneyime sahip. Kas kütlesi artırma ve kondisyon geliştirme üzerine uzman.',
        'experience': '20 yıl',
        'services': ['Bireysel Antrenman', 'Grup Dersleri'],
        'availableDays': ['Pazartesi', 'Salı', 'Çarşamba', 'Perşembe', 'Cuma'],
        'availableHours': ['09:00 - 18:00'],
        'sessionDuration': '60 dakika',
        'pricing': '250 TL / Seans',
        'location': 'Spor Salonu A',
      },
      {
        'photo': 'assets/images/woman.png',
        'name': 'Ayşe Demir',
        'age': 38,
        'field': 'Fonksiyonel Antrenman',
        'description':
            'Fonksiyonel hareketler ve dayanıklılık artırıcı egzersizler konusunda uzman.',
        'experience': '15 yıl',
        'services': ['Bireysel Antrenman', 'Online Dersler'],
        'availableDays': ['Salı', 'Perşembe'],
        'availableHours': ['10:00 - 16:00'],
        'sessionDuration': '45 dakika',
        'pricing': '200 TL / Seans',
        'location': 'Online',
      },
      {
        'photo': 'assets/images/man.png',
        'name': 'Can Özkan',
        'age': 42,
        'field': 'Vücut Geliştirme',
        'description':
            'Profesyonel vücut geliştirme eğitmeni, kas kazanımı ve definasyon programları sunuyor.',
        'experience': '18 yıl',
        'services': ['Bireysel Antrenman', 'Grup Dersleri'],
        'availableDays': ['Pazar', 'Çarşamba'],
        'availableHours': ['08:00 - 12:00'],
        'sessionDuration': '75 dakika',
        'pricing': '300 TL / Seans',
        'location': 'Spor Salonu B',
      },
      {
        'photo': 'assets/images/woman.png',
        'name': 'Zeynep Arslan',
        'age': 35,
        'field': 'Pilates & Core Antrenmanı',
        'description':
            'Core güçlendirme ve postür düzeltme üzerine odaklanan pilates antrenörü.',
        'experience': '12 yıl',
        'services': ['Bireysel Antrenman', 'Grup Dersleri'],
        'availableDays': ['Pazar', 'Perşembe'],
        'availableHours': ['11:00 - 17:00'],
        'sessionDuration': '50 dakika',
        'pricing': '220 TL / Seans',
        'location': 'Spor Salonu C',
      },
      {
        'photo': 'assets/images/man.png',
        'name': 'Hakan Kurt',
        'age': 50,
        'field': 'Fonksiyonel Fitness',
        'description':
            'Günlük yaşam aktivitelerini kolaylaştırmaya yönelik fitness programları hazırlıyor.',
        'experience': '25 yıl',
        'services': ['Bireysel Antrenman'],
        'availableDays': ['Pazartesi', 'Cuma'],
        'availableHours': ['07:00 - 15:00'],
        'sessionDuration': '60 dakika',
        'pricing': '270 TL / Seans',
        'location': 'Spor Salonu A',
      },
      {
        'photo': 'assets/images/woman.png',
        'name': 'Elif Kılıç',
        'age': 29,
        'field': 'Pilates',
        'description':
            'Yoga ve esneklik artırıcı egzersizlerle, kasların daha sağlıklı çalışmasını sağlıyor.',
        'experience': '8 yıl',
        'services': ['Bireysel Antrenman', 'Online Dersler'],
        'availableDays': ['Salı', 'Cumartesi'],
        'availableHours': ['09:30 - 14:00'],
        'sessionDuration': '45 dakika',
        'pricing': '180 TL / Seans',
        'location': 'Online',
      },
      {
        'photo': 'assets/images/man.png',
        'name': 'Ahmet Uçar',
        'age': 40,
        'field': 'HIIT (Yüksek Yoğunluklu Antrenman)',
        'description':
            'Yağ yakımı ve kardiyovasküler dayanıklılığı artıran yüksek yoğunluklu antrenmanlar yapıyor.',
        'experience': '10 yıl',
        'services': ['Bireysel Antrenman', 'Grup Dersleri'],
        'availableDays': ['Pazartesi', 'Perşembe'],
        'availableHours': ['10:00 - 18:00'],
        'sessionDuration': '30 dakika',
        'pricing': '220 TL / Seans',
        'location': 'Spor Salonu B',
      },
      {
        'photo': 'assets/images/woman.png',
        'name': 'Selin Güneş',
        'age': 33,
        'field': 'Beslenme & Kişisel Antrenman',
        'description':
            'Kişiye özel fitness ve beslenme programlarıyla sağlıklı yaşamı destekliyor.',
        'experience': '7 yıl',
        'services': ['Bireysel Antrenman', 'Online Dersler'],
        'availableDays': ['Salı', 'Cuma'],
        'availableHours': ['09:00 - 15:00'],
        'sessionDuration': '60 dakika',
        'pricing': '230 TL / Seans',
        'location': 'Online',
      },
      {
        'photo': 'assets/images/man.png',
        'name': 'Murat Aksoy',
        'age': 37,
        'field': 'Kickboks Fitness',
        'description':
            'Kickboks hareketleriyle kardiyo ve güç antrenmanlarını birleştirerek etkili egzersizler sunuyor.',
        'experience': '12 yıl',
        'services': ['Bireysel Antrenman'],
        'availableDays': ['Çarşamba', 'Cumartesi'],
        'availableHours': ['08:30 - 12:30'],
        'sessionDuration': '45 dakika',
        'pricing': '250 TL / Seans',
        'location': 'Spor Salonu C',
      },
      {
        'photo': 'assets/images/woman.png',
        'name': 'Ebru Şahin',
        'age': 31,
        'field': 'Kilo Verme & Kardiyo',
        'description':
            'Kardiyo ve direnç antrenmanlarıyla yağ yakımı ve kilo verme konusunda destek sağlıyor.',
        'experience': '9 yıl',
        'services': ['Bireysel Antrenman', 'Grup Dersleri', 'Online Dersler'],
        'availableDays': ['Pazar', 'Çarşamba'],
        'availableHours': ['09:00 - 16:00'],
        'sessionDuration': '60 dakika',
        'pricing': '210 TL / Seans',
        'location': 'Spor Salonu A',
      }
    ]
  },
  {
    'image': 'assets/images/training-video.png',
    'title': 'Eğitim Videoları',
    'onTap': (BuildContext context) {
      Navigator.push(context,
          RouteAnimation.createRoute(EducationCategoriesScreen(), 1, 0));
    },
  },
];
