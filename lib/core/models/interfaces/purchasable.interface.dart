import 'package:flutter/foundation.dart';

abstract class Purchasable {
  double price;
  bool canBuy;
  Purchasable({@required this.price, @required this.canBuy});
}
