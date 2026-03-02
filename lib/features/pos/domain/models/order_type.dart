enum OrderType {
  dineIn,
  takeAway,
  goFood,
  shopeeFood,
  grabFood,
}

extension OrderTypeExtension on OrderType {
  String get label {
    switch (this) {
      case OrderType.dineIn:
        return "Dine In";
      case OrderType.takeAway:
        return "Take Away";
      case OrderType.goFood:
        return "GoFood";
      case OrderType.shopeeFood:
        return "ShopeeFood";
      case OrderType.grabFood:
        return "GrabFood";
    }
  }
}