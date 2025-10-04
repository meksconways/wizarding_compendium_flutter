import 'package:flutter/material.dart';

class HouseColorTheme {
  static ({Color border, Color background}) getForHouse(String name) {
    switch (name.toLowerCase()) {
      case 'gryffindor':
        return (
          border: const Color(0xffDC2626),
          background: const Color(0x557F1D1D),
        );
      case 'slytherin':
        return (
          border: const Color(0xff16A34A),
          background: const Color(0x5514532D),
        );
      case 'ravenclaw':
        return (
          border: const Color(0xff2563EB),
          background: const Color(0x551E3A8A),
        );
      case 'hufflepuff':
        return (
          border: const Color(0xffEAB308),
          background: const Color(0x55854D0E),
        );
      default:
        return (
          border: const Color(0xff717679),
          background: const Color(0x55EFEEE9),
        );
    }
  }
}
