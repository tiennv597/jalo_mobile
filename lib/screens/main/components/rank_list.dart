import 'package:flutter/material.dart';
import 'package:shinro_int2/models/product.dart';

import 'package:shinro_int2/constant/app_colors.dart' as COLORS;
import 'package:shinro_int2/screens/main/learning/game_home_page.dart';

class RankList extends StatefulWidget {
  @override
  _RankListState createState() => _RankListState();
}

class _RankListState extends State<RankList>
    with TickerProviderStateMixin<RankList> {
  List<Product> products = [
    Product('assets/bad.png', 'Bag', 'Beautiful bag', 2.33),
    Product('assets/bad.png', 'Cap', 'Cap with beautiful design', 10),
    Product('assets/bad.png', 'Jeans', 'Jeans for you', 20),
    Product('assets/bad.png', 'Woman Shoes', 'Shoes with special discount', 30),
    Product('assets/bad.png', 'Bag Express', 'Bag for your shops', 40),
    Product('assets/bad.png', 'Jeans', 'Beautiful Jeans', 102.33),
    Product('assets/bad.png', 'Silver Ring', 'Description', 52.33),
    Product('assets/bad.png', 'Shoes', 'Description', 62.33),
    Product('assets/bad.png', 'Headphones', 'Description', 72.33),
  ];
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  Widget _buildTitleTab(String tile) {
    return Tab(
      child: Container(
        height: 20,
        child: Align(
          alignment: Alignment.center,
          child: Text(tile),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget tabBar = TabBar(
        unselectedLabelColor: COLORS.cyan700,
        indicator: BoxDecoration(
            gradient: LinearGradient(colors: [COLORS.cyan700, COLORS.cyan700]),
            borderRadius: BorderRadius.circular(10),
            color: COLORS.cyan700),
        tabs: [
          _buildTitleTab("Vocabulary"),
          _buildTitleTab("Grammar"),
          _buildTitleTab("Reading"),
          _buildTitleTab("Listen")
        ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: new Size(180.0, -20.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 24,
                child: tabBar,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 24, top: 8),
            child: TabBarView(
              children: [
                Flexible(
                  child: Container(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) =>
                          new ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => GameHomePage())),
                          child: Container(
                              decoration: BoxDecoration(),
                              child: Text("Top 1")),
                        ),
                      ),
                    ),
                  ),
                ),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
                Icon(Icons.directions_bike),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
