import 'package:shinro_int2/constant/app_properties.dart';
import 'package:shinro_int2/models/product.dart';
import 'package:shinro_int2/screens/game/game_room_page.dart';
import 'package:shinro_int2/screens/payment/unpaid_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'components/type_play_card.dart';
import 'components/shop_item_list.dart';

class GameHomePage extends StatefulWidget {
  @override
  _GameHomePageState createState() => _GameHomePageState();
}

class _GameHomePageState extends State<GameHomePage> {
  SwiperController swiperController = SwiperController();

  List<Product> products = [
    Product('assets/headphones.png',
        'Boat roackerz 400 On-Ear Bluetooth Headphones', 'description', 45.3),
  ];

  @override
  Widget build(BuildContext context) {
    Widget checkOutButton = InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => GameRoomPage())),
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("Start Game",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: darkGrey),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/icons/denied_wallet.png'),
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => UnpaidPage())),
          )
        ],
        title: Text(
          'Strart',
          style: TextStyle(
              color: darkGrey, fontWeight: FontWeight.w500, fontSize: 18.0),
        ),
      ),
      body: LayoutBuilder(
        builder: (_, constraints) => SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 132,
                  child: Scrollbar(
                    child: ListView.builder(
                      itemBuilder: (_, index) => ShopItemList(
                        products[index],
                        onRemove: () {
                          setState(() {
                            products.remove(products[index]);
                          });
                        },
                      ),
                      itemCount: products.length,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Payment',
                    style: TextStyle(
                        fontSize: 20,
                        color: darkGrey,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: Swiper(
                    itemCount: 2,
                    itemBuilder: (_, index) {
                      return TypePlayCard();
                    },
                    scale: 0.8,
                    controller: swiperController,
                    viewportFraction: 0.6,
                    loop: false,
                    fade: 0.7,
                  ),
                ),
                SizedBox(height: 24),
                Center(
                    child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom == 0
                          ? 20
                          : MediaQuery.of(context).padding.bottom),
                  child: checkOutButton,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Scroll extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    LinearGradient grT = LinearGradient(
        colors: [Colors.transparent, Colors.black26],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter);
    LinearGradient grB = LinearGradient(
        colors: [Colors.transparent, Colors.black26],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter);

    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, 30),
        Paint()
          ..shader = grT.createShader(Rect.fromLTRB(0, 0, size.width, 30)));

    canvas.drawRect(Rect.fromLTRB(0, 30, size.width, size.height - 40),
        Paint()..color = Color.fromRGBO(50, 50, 50, 0.4));

    canvas.drawRect(
        Rect.fromLTRB(0, size.height - 40, size.width, size.height),
        Paint()
          ..shader = grB.createShader(
              Rect.fromLTRB(0, size.height - 40, size.width, size.height)));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
