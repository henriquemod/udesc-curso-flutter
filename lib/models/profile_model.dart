import 'package:projeto_modulo_1/models/product_model.dart';

/*
Notifications
0 = Twice a day
1 = Daily
2 = Weekly
3 = Monthly
4 = Cusom
*/

class Profile {
  List<Product>? userProductList;
  int notificationFrequency;

  Profile({this.userProductList, required this.notificationFrequency});
}
