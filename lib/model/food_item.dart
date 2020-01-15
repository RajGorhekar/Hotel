import 'package:flutter/material.dart';

class FoodItemList{
  List<FoodItem> foodItems;
  FoodItemList({@required this.foodItems});
}

FoodItemList foodItemList = FoodItemList(foodItems: [
  FoodItem(
    id: 1,
    x:'Veg',
    title: "Luger spec Burger",
    hotel: "The Smokin' Patty",
    price: 180,
    imgUrl:
        "https://coolmaterial.com/wp-content/uploads/2014/05/double-animal-in-and-out.jpg",
  ),
  FoodItem(
    x:'Nonveg',
    id: 2,
    title: "Le Pigeon Burger",
    hotel: "Burger Basement",
    price: 250,
    imgUrl:
        "https://coolmaterial.com/wp-content/uploads/2014/05/double-patty-cheese-holeman.jpg",
  ),
  FoodItem(
    x:'Veg',
    id: 3,
    title: "Whiskey King Burger",
    hotel: "Golf Course",
    price: 150,
    imgUrl: "https://www.desktopbackground.org/download/2560x1440/2015/10/29/1034104_wallpapers-burgers-fast-food-hamburger-french-fries-1680x1050_5616x3744_h.jpg",
  ),
  FoodItem(
    x:'Nonveg',
    id: 4,
    title: "Buckhorn Burger",
    hotel: "The Smokin' Patty",
    price: 375,
    imgUrl: "https://www.seriouseats.com/images/2014/09/20140918-jamie-olivers-comfort-food-insanity-burger-david-loftus.jpg",
  ),
  FoodItem(
    x:'Veg',
    id: 5,
    title: "Patty Cheeseburger",
    hotel: "Sin City Burgers",
    price: 175,
    imgUrl: "https://www.foodiesfeed.com/wp-content/uploads/2015/09/summer-juicy-beef-burger.jpg",
  ),
  FoodItem(
    x:'Nonveg',
    id: 6,
    title: "Beach BBQ Burger",
    hotel: "Burger Basement",
    price: 150,
    imgUrl:
        "https://cdn.pixabay.com/photo/2018/03/04/20/08/burger-3199088__340.jpg",
  ),
]);

class FoodItem{
  int id;
  String title;
  String hotel;
  double price;
  String imgUrl;
  int quantity;
  String x;

  FoodItem({
    @required this.x,
    @required this.id,
    @required this.title,
    @required this.hotel,
    @required this.price,
    @required this.imgUrl,
    this.quantity = 1,
  });

  void incrementQuantity(){
    this.quantity++;
  }

  void decrementQuantity(){
    this.quantity--;
  }

}