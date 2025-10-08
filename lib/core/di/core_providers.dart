import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/hp_api.dart';

final hpApiProvider = Provider<HpApi>((ref) => HpApi());