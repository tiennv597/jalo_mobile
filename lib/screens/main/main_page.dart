import 'package:shinro_int2/constant/app_properties.dart';
import 'package:shinro_int2/screens/game/game_room_page.dart';
import 'package:shinro_int2/screens/grammar/example_page.dart';
import 'package:shinro_int2/screens/main/components/rank_type_tab.dart';
import 'package:shinro_int2/constant/app_colors.dart' as COLORS;
import 'package:shinro_int2/screens/profile/profile_page.dart';
import 'package:shinro_int2/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'components/tab_view.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

List<Product> products = [
  Product(
      'assets/image.jpg',
      'Skullcandy headset L325',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
      102.99),
  Product(
      'assets/image.jpg',
      'Skullcandy headset X25',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
      55.99),
  Product(
      'assets/image.jpg',
      'Blackzy PRO hedphones M003',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
      152.99),
];

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  SwiperController swiperController;
  TabController tabController;
  TabController tabController2;
  TabController bottomTabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController2 = TabController(length: 5, vsync: this);
    bottomTabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Widget tabBar = TabBar(
      tabs: [
        Tab(text: 'Related'),
        Tab(text: 'Hot'),
        Tab(text: 'Explore'),
      ],
      labelStyle: TextStyle(fontSize: 16.0),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0,
      ),
      labelColor: darkGrey,
      unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.5),
      isScrollable: true,
      controller: tabController,
      indicatorColor: transparentPurple,
    );
    // Widget tabBar2 = TabBar(
    //   tabs: [
    //     Tab(text: 'Related'),
    //     Tab(text: 'Hot'),
    //     Tab(text: 'Explore'),
    //     Tab(text: 'Explore'),
    //     Tab(text: 'Explore'),
    //   ],
    //   labelStyle: TextStyle(fontSize: 16.0),
    //   unselectedLabelStyle: TextStyle(
    //     fontSize: 14.0,
    //   ),
    //   labelColor: darkGrey,
    //   unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.5),
    //   isScrollable: true,
    //   controller: tabController2,
    //   indicatorColor: transparentPurple,
    // );
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    Widget _buildTypeBtn(
        String title, String urlImage, LinearGradient lgColor) {
      var withS = MediaQuery.of(context).size.width / 2.5;
      var heightS = MediaQuery.of(context).size.height / 8;
      return RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        color: Colors.white,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => GameRoomPage()));
        },
        textColor: Colors.white,
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: withS,
          height: heightS,
          decoration: BoxDecoration(
            gradient: lgColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                  width: withS / 4,
                  height: withS / 4,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill, image: ExactAssetImage(urlImage)))),
              Text(title),
            ],
          ),
        ),
      );
    }

    List<Widget> _widgetOptions = <Widget>[
      SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverToBoxAdapter(
                child: tabBar,
              )
            ];
          },
          body: TabView(
            tabController: tabController,
          ),
        ),
      ),
      ExamplePage(),
      //GameHomePage(),
      SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Game',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          FlatButton(
                            child: Text('View All'),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 0, left: 8, right: 8),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _buildTypeBtn('Competition',
                                    'assets/ninja.png', COLORS.colorOrange),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _buildTypeBtn('JLPT',
                                    'assets/benkyou.png', COLORS.colorBlue),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _buildTypeBtn('Practice',
                                    'assets/gokaku.png', COLORS.colorGreen),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _buildTypeBtn('Competition',
                                    'assets/good.png', COLORS.colorPurple),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverAppBar(
                  title: Text('Tab Controller Example'),
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    tabs: <Widget>[
                      Tab(
                        text: "Home",
                        icon: Icon(Icons.home),
                      ),
                      Tab(
                        text: "Example page",
                        icon: Icon(Icons.help),
                      ),
                      Tab(
                        text: "Home",
                        icon: Icon(Icons.home),
                      ),
                      Tab(
                        text: "Example page",
                        icon: Icon(Icons.help),
                      ),
                      Tab(
                        text: "Example page",
                        icon: Icon(Icons.help),
                      )
                    ],
                    controller: tabController2,
                  ),
                ),
              )
            ];
          },
          body: RankTypeTab(
            tabController: tabController2,
          ),
        ),
      ),
      ProfilePage()
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.g_translate),
            title: Text('Grammar'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            title: Text('Game'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            title: Text('Profile'),
          ),
        ],
        iconSize: 28,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        fixedColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions[_selectedIndex],
    );
  }
}
