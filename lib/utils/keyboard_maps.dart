import 'package:flutter/services.dart';

final kLogicalKeyToAndroid = kAndroidToLogicalKey.map((key, value) => MapEntry(value, key));
final kLogicalKeyToGlfw = kGlfwToLogicalKey.map((key, value) => MapEntry(value, key));
final kLogicalKeyToGtk = kGtkToLogicalKey.map((key, value) => MapEntry(value, key));
