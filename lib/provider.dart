import 'foodItem.dart';


class CartProvider {

  List<FoodgItem> foodItems = [];


  List<FoodgItem> addToList(FoodgItem foodItem) {
      bool isPresent = false;

    if (foodItems.length > 0) {
      for (var i = 0; i < foodItems.length; i ++) {
        if (foodItems[i].id == foodItem.id) {
          increaseItemQuantity(foodItem);
          isPresent = true;
          break;
        } else {
          isPresent = false;
        }
      }
      if (!isPresent) {
        foodItems.add(foodItem);
      }
    } else {
      foodItems.add(foodItem);
    }
    return foodItems;
  }


  void increaseItemQuantity(FoodgItem foodItem) => foodItem.incrementQuantity();

  void decreaseItemQuantity(FoodgItem foodItem) => foodItem.decrementQuantity();

  List<FoodgItem> removeFromList(FoodgItem foodItem) {

    if (foodItem.quantity > 1) {
      decreaseItemQuantity(foodItem);
    } else {
      foodItems.remove(foodItem);
    }
    return foodItems;
  }


}
