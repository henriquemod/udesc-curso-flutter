import 'package:projeto_modulo_1/models/profile_model.dart';

import '../models/product_model.dart';

class ProfileController {
  late List<bool> isSelected = [];
  Profile profile;

  ProfileController({required this.profile}) {
    profile = Profile(notificationFrequency: 0);
    isSelected.add(true);
    isSelected.add(true);
  }

  void updateProductList(List<Product> productList) {
    profile.userProductList = productList;
  }
}
