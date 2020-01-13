import 'package:flutter/material.dart';

class FoodItemList{
  List<FoodItem> foodItems;
  FoodItemList({@required this.foodItems});
}

FoodItemList foodItemList = FoodItemList(foodItems: [
  FoodItem(
    id: 1,
    x:'Veg',
    title: "Beach BBQ Burger",
    hotel: "Las Vegas Hotel",
    price: 14.49,
    imgUrl:
        "https://hips.hearstapps.com/pop.h-cdn.co/assets/cm/15/05/480x240/54ca71fb94ad3_-_5summer_skills_burger_470_0808-de.jpg",
  ),
  FoodItem(
    x:'Nonveg',
    id: 2,
    title: "Kick Ass Burgers",
    hotel: "Dudleys",
    price: 11.99,
    imgUrl:
        "https://b.zmtcdn.com/data/pictures/chains/8/18427868/1269c190ab2f272599f8f08bc152974b.png",
  ),
  FoodItem(
    x:'Veg',
    id: 3,
    title: "Supreme Pizza Burger",
    hotel: "Golf Course",
    price: 8.49,
    imgUrl: "https://www.desktopbackground.org/download/2560x1440/2015/10/29/1034104_wallpapers-burgers-fast-food-hamburger-french-fries-1680x1050_5616x3744_h.jpg",
  ),
  FoodItem(
    x:'Nonveg',
    id: 4,
    title: "Chilly Cheeze Burger",
    hotel: "Las Vegas Hotel",
    price: 14.49,
    imgUrl: "https://www.seriouseats.com/images/2014/09/20140918-jamie-olivers-comfort-food-insanity-burger-david-loftus.jpg",
  ),
  FoodItem(
    x:'Veg',
    id: 5,
    title: "Beach BBQ Burger",
    hotel: "Las Vegas Hotel",
    price: 14.49,
    imgUrl: "https://www.foodiesfeed.com/wp-content/uploads/2015/09/summer-juicy-beef-burger.jpg",
  ),
  FoodItem(
    x:'Nonveg',
    id: 6,
    title: "Beach BBQ Burger",
    hotel: "Las Vegas Hotel",
    price: 14.49,
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