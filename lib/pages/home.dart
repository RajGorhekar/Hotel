import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:hotel/bloc/cartListBloc.dart';
import 'package:hotel/model/food_item.dart';
import 'cart.dart';



class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: ListView(
          children: <Widget>[
            FirstHalf(),
            SizedBox(height: 20),
            for (var foodItem in foodItemList.foodItems)
              Builder(
                builder: (context) {
                  return ItemContainer(foodItem: foodItem);
                },
              )
          ],
        ),
      )),
    );
  }
}

class ItemContainer extends StatefulWidget {
  ItemContainer({
    @required this.foodItem,
  });

  final FoodItem foodItem;

  get x => foodItem.x;

  @override
  _ItemContainerState createState() => _ItemContainerState();
}

class _ItemContainerState extends State<ItemContainer> {
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  addToCart(FoodItem foodItem) {
    
    bloc.addToList(foodItem);
    setState(() {});
  }

  removeFromList(FoodItem foodItem) {
    bloc.removeFromList(foodItem);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addToCart(widget.foodItem);
        final snackBar = SnackBar(
          content: Text('${widget.foodItem.title} added to Cart'),
          duration: Duration(milliseconds: 550),
        );

        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Items(
        x: widget.x,
        hotel: widget.foodItem.hotel,
        itemName: widget.foodItem.title,
        itemPrice: widget.foodItem.price,
        imgUrl: widget.foodItem.imgUrl,
      ),
    );
  }
}

class FirstHalf extends StatelessWidget {
  const FirstHalf({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          //you could also use the spacer widget to give uneven distances, i just decided to go with a sizebox
          SizedBox(height: 6),
          Divider(thickness: 2, color: Colors.brown),
          SizedBox(height: 6),
          searchBar(),
          SizedBox(height: 45),
          categories(),
        ],
      ),
    );
  }
}

Widget categories() {

  return Padding(
    padding: EdgeInsets.only(left: 35),
    child: Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CategoryListItem(
            categoryName: "Burgers",
            availability: 12,
            selected: true,
          ),
          Container(
            height: 50.0,
            width: 2.0,
            color: Colors.brown,
            margin: const EdgeInsets.only(left: 0, right: 15.0),
          ),
          CategoryListItem(
            categoryName: "Pizza",
            availability: 12,
            selected: false,
          ),
          Container(
            height: 50.0,
            width: 2.0,
            color: Colors.brown,
            margin: const EdgeInsets.only(left: 0, right: 15.0),
          ),
          CategoryListItem(
            categoryName: "Rolls",
            availability: 12,
            selected: false,
          ),
          Container(
            height: 50.0,
            width: 2.0,
            color: Colors.brown,
            margin: const EdgeInsets.only(left: 0, right: 15.0),
          ),
          CategoryListItem(
            categoryName: "sandwich",
            availability: 12,
            selected: false,
          ),
          Container(
            height: 50.0,
            width: 2.0,
            color: Colors.brown,
            margin: const EdgeInsets.only(left: 0, right: 15.0),
          ),
          CategoryListItem(
            categoryName: "tacos",
            availability: 12,
            selected: false,
          ),
        ],
      ),
    ),
  );
}

class Items extends StatelessWidget {
  Items({
    @required this.imgUrl,
    @required this.itemName,
    @required this.itemPrice,
    @required this.hotel,
    this.x,
  });

  final String imgUrl;
  final String itemName;
  final double itemPrice;
  final String hotel;
  final x;

  @override
  Widget build(BuildContext context) {
    double containerPadding = 45;
    double containerBorderRadius = 10;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          SizedBox(height: containerPadding / 6),
          Divider(thickness: 2, color: Colors.brown),
          SizedBox(height: containerPadding / 6),
          Container(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(containerBorderRadius),
                        ),
                        child: Image.network(
                          imgUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      //left :275,
                      left: x.toString().toLowerCase().contains('non')
                          ? 275
                          : 290,
                      child: Type(x),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(itemName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                )),
                          ),
                          Text("$itemPrice Rs",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              )),
                        ],
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 15),
                              children: [
                                TextSpan(text: "by "),
                                TextSpan(
                                    text: hotel,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700))
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    Key key,
    @required this.categoryName,
    @required this.availability,
    @required this.selected,
  }) : super(key: key);

  final String categoryName;
  final int availability;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: selected ? Colors.cyan : Colors.white,
        border: Border.all(
            color: selected ? Colors.transparent : Colors.grey[200],
            width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100],
            blurRadius: 15,
            offset: Offset(15, 0),
            spreadRadius: 5,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            categoryName,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : Colors.black,
                fontSize: 15),
          ),
          SizedBox(width: 10),
          Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: selected ? Colors.white : Colors.black,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      color: selected ? Colors.transparent : Colors.grey[200],
                      width: 1.5)),
              child: Text(
                availability.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.black : Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}

Widget searchBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Icon(
        Icons.search,
        color: Colors.black45,
      ),
      SizedBox(width: 20),
      Expanded(
        child: TextField(
          decoration: InputDecoration(
              hintText: "Search....",
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              hintStyle: TextStyle(
                color: Colors.black87,
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red))),
        ),
      ),
    ],
  );
}

Widget title() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "The Times",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
          ),
          Text(
            "Hotels ",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 30,
            ),
          ),
        ],
      )
    ],
  );
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(),
          Icon(Icons.menu),
          SizedBox(),
          title(),
          SizedBox(),
          StreamBuilder(
            stream: bloc.listStream,
            builder: (context, snapshot) {
              List<FoodItem> foodItems = snapshot.data;
              int length = foodItems != null ? foodItems.length : 0;
              return buildGestureDetector(length, context, foodItems);
            },
          )
        ],
      ),
    );
  }

  GestureDetector buildGestureDetector(
      int length, BuildContext context, List<FoodItem> foodItems) {
    return GestureDetector(
      onTap: () {
        if (length > 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else {
          return;
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 30),
        child: Text(length.toString(),style: TextStyle(
          color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20
        ),),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.cyan, borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class Type extends StatelessWidget {
  final String x;
  Type(this.x);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.cyan),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
            )
          ]),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Text(
            x,
            style: TextStyle(
                fontSize: 12,
                color:
                    x.toLowerCase().contains('non') ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
