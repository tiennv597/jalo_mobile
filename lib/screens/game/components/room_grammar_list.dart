import 'package:shinro_int2/constant/app_properties.dart';
import 'package:shinro_int2/models/product.dart';
import 'package:shinro_int2/screens/product/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RoomGrammarList extends StatelessWidget {
//   List<Product> products = [
//     Product('assets/image.jpg', 'Bag', 'Beautiful bag', 2.33),
//     Product('assets/image.jpg', 'Cap', 'Cap with beautiful design', 10),
//     Product('assets/image.jpg', 'Jeans', 'Jeans for you', 20),
//     Product('assets/image.jpg', 'Woman Shoes', 'Shoes with special discount', 30),
//     Product('assets/image.jpg', 'Bag Express', 'Bag for your shops', 40),
//     Product('assets/image.jpg', 'Jeans', 'Beautiful Jeans', 102.33),
//     Product('assets/image.jpg', 'Silver Ring', 'Description', 52.33),
//     Product('assets/image.jpg', 'Shoes', 'Description', 62.33),
//     Product('assets/image.jpg', 'Headphones', 'Description', 72.33),
// ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(left: 16.0, right: 8.0),
                  width: 4,
                  color: mediumYellow,
                ),
              ),
              Center(
                  child: Text(
                'Grammar',
                style: TextStyle(
                    color: darkGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ),
    //     Flexible(
    //       child: Container(
    //         padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
    //         child: StaggeredGridView.countBuilder(
    // physics: NeverScrollableScrollPhysics(),
    //           padding: EdgeInsets.zero,
    //           crossAxisCount: 4,
    //           itemCount: products.length,
    //           itemBuilder: (BuildContext context, int index) => new ClipRRect(
    //                 borderRadius: BorderRadius.all(Radius.circular(5.0)),
    //                 child: InkWell(
    //                   onTap: () => Navigator.of(context).push(
    //                       MaterialPageRoute(builder: (_) => ProductPage(product:products[index]))),
    //                   child: Container(
    //                       decoration: BoxDecoration(
    //                         gradient: RadialGradient(
    //                             colors: [Colors.grey[500], Colors.grey[700]],
    //                             center: Alignment(0, 0),
    //                             radius: 0.6,
    //                             focal: Alignment(0, 0),
    //                             focalRadius: 0.1),
    //                       ),
    //                       // child: Hero(
    //                       //     tag: products[index].image,
    //                       //     child: Image.asset(products[index].image))
    //                           ),
    //                 ),
    //               ),
    //           staggeredTileBuilder: (int index) =>
    //               new StaggeredTile.count(2, index.isEven ? 3 : 2),
    //           mainAxisSpacing: 4.0,
    //           crossAxisSpacing: 4.0,
    //         ),
    //       ),
    //     ),
      ],
    );
  }
}
