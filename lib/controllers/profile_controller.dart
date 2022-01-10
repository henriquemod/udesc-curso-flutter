import 'package:projeto_modulo_1/models/profile_model.dart';

class ProfileController {
  late List<bool> isSelected = [];
  late Profile profile;

  final Map<int, int> timers = {
    0: 999999999999999999,
    1: 43200,
    2: 86400,
    3: 604800,
    4: 2592000,
    5: 15,
    6: 30
  };

  ProfileController() {
    profile = Profile();
    isSelected.add(true);
    isSelected.add(true);
  }
}
