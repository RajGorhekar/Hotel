import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel/bloc/cartListBloc.dart';
import 'package:hotel/model/food_item.dart';


class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
    List<FoodItem> foodItems;
    return StreamBuilder(
      stream: bloc.listStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          foodItems = snapshot.data;
          return Scaffold(
            body: SafeArea(
              child: CartBody(foodItems),
            ),
            bottomNavigationBar: BottomBar(foodItems),
          );
        } else {
          return Container(
            child: Text("Something returned null"),
          );
        }
      },
    );
  }
}

class BottomBar extends StatelessWidget {
  final List<FoodItem> foodItems;

  BottomBar(this.foodItems);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35, bottom: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          totalAmount(foodItems),
          Divider(
            height: 1,
            color: Colors.grey[700],
          ),
          SizedBox(height: 20),
          nextButtonBar(context),
        ],
      ),
    );
  }

  Container totalAmount(List<FoodItem> foodItems) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Total  : ",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            "${returnTotalAmount(foodItems)}",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
          ),
        ],
      ),
    );
  }

  String returnTotalAmount(List<FoodItem> foodItems) {
    double totalAmount = 0.0;

    for (int i = 0; i < foodItems.length; i++) {
      totalAmount = totalAmount + foodItems[i].price * foodItems[i].quantity;
    }
    return totalAmount.toStringAsFixed(2);
  }

  GestureDetector nextButtonBar(context) {
    return GestureDetector(
      onTap: ()=> _ackAlert(context,returnTotalAmount(foodItems)),
        child: Container(
        margin: EdgeInsets.only(right: 25),
        padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
        decoration: BoxDecoration(
            color: Colors.cyan, borderRadius: BorderRadius.circular(15)),
        child: Text(
          "Place Order",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}

Future<void> _ackAlert(BuildContext context, String price) {

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Your Billing Amount is $price '),
        content: const Text('The Food is On its Way ! \n Enjoy Your Meal'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class CartBody extends StatelessWidget {
  final List<FoodItem> foodItems;

  CartBody(this.foodItems);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(35, 10, 25, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          Divider(thickness: 2, color: Colors.brown),
          SizedBox(height: 6),
          Expanded(
            flex: 1,
            child: foodItems.length > 0 ? foodItemList() : noItemContainer(),
          )
        ],
      ),
    );
  }

  Container noItemContainer() {
    return Container(
      child: Center(
        child: Text(
          "No More Items Left In The Cart",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
              fontSize: 20),
        ),
      ),
    );
  }

  ListView foodItemList() {
    return ListView.builder(
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        return ItemContent(foodItem: foodItems[index]);
      },
    );
  }

}

class ItemContent extends StatefulWidget {
  const ItemContent({
    Key key,
    @required this.foodItem,
  }) : super(key: key);

  final FoodItem foodItem;

  @override
  _ItemContentState createState() => _ItemContentState();
}

class _ItemContentState extends State<ItemContent> {
  @override
  Widget build(BuildContext context) {
    final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
    return Container(
      child: Column(
        children: <Widget>[
          Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                widget.foodItem.imgUrl,
                fit: BoxFit.cover,
                height: 55,
                width: 80,
              ),
            ),
            Column(
              children: <Widget>[
                RichText(
              text: TextSpan(
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                  children: [
                    TextSpan(text: widget.foodItem.quantity.toString()),
                    TextSpan(text: " x "),
                    TextSpan(
                      text: widget.foodItem.title,
                    ),
                  ]),
            ),
            Text(
              "${widget.foodItem.quantity * widget.foodItem.price} Rs",
              style:
                  TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w400),
            ),
              ],  
            ),
            GestureDetector(
                child: Icon(
                  Icons.delete,
                  size: 35,
                  color: Colors.redAccent,
                ),
              onTap: (){
                bloc.removeFromList(widget.foodItem);
                setState(() {
                  
                });
              } 
              
            ),
          ],
        ),
         SizedBox(height: 6),
          Divider(thickness: 2, color: Colors.brown),
          SizedBox(height: 6),
        ],
        
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            child: Icon(
              Icons.arrow_back,
              size: 30,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
      padding: const EdgeInsets.symmetric(vertical: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "My ",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 35,
                ),
              ),
              Text(
                "Order",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 35,
                ),
              ),
            ],
          )
        ],
      ),
    ),
      ],
    );
  }
}
