import 'package:cafetopia_flutter/profile/profile_page.dart';
import 'package:cafetopia_flutter/view_models/cafe_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

import 'components/arguments.dart';
import 'components/cafe_list.dart';
import 'components/cafe_detail_tile.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cafes',
      routes: <String, Widget Function(BuildContext)>{
        ExtractRouteArguments.routeName: (_) => const ExtractRouteArguments()
      },
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MainPageState();
}

typedef CardSelectedCallback = void Function(int?);

class _MainPageState extends State<HomePage>
    with TickerProviderStateMixin, ChangeNotifier {
  // A listener used for the controllers to reanimate the staggered animation of
  // the navigation elements.
  ValueNotifier<bool?> showGridView = ValueNotifier<bool?>(false);

  // Override the application's directionality.
  TextDirection directionalityOverride = TextDirection.ltr;

  // The index of the selected mail card.
  int? selected;
  CafeViewModel viewModel = CafeViewModel();

  void selectCard(int? index) {
    setState(() {
      selected = index;
    });
  }

  // The index of the navigation screen. Only impacts body/secondaryBody
  int _navigationIndex = 0;

  // The controllers used for the staggered animation of the navigation elements.
  late AnimationController _homeIconSlideController;
  late AnimationController _favoritesIconSlideController;
  late AnimationController _profileIconSlideController;

  @override
  void initState() {
    showGridView.addListener(() {
      Navigator.popUntil(
          context, (Route<dynamic> route) => route.settings.name == '/');
      _homeIconSlideController
        ..reset()
        ..forward();
      _favoritesIconSlideController
        ..reset()
        ..forward();
      _profileIconSlideController
        ..reset()
        ..forward();
    });
    _homeIconSlideController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    )..forward();
    _favoritesIconSlideController = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
    )..forward();
    _profileIconSlideController = AnimationController(
      duration: const Duration(milliseconds: 140),
      vsync: this,
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    _homeIconSlideController.dispose();
    _favoritesIconSlideController.dispose();
    _profileIconSlideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const List<NavigationDestination> destinations = <NavigationDestination>[
      NavigationDestination(
        label: 'Home',
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
      ),
      NavigationDestination(
        label: 'Favorites',
        icon: Icon(Icons.favorite_border_outlined),
        selectedIcon: Icon(Icons.favorite),
      ),
      NavigationDestination(
        label: 'Profile',
        icon: Icon(Icons.person_outline),
        selectedIcon: Icon(Icons.person),
      ),
    ];

    // Updating the listener value.
    showGridView.value = Breakpoints.mediumAndUp.isActive(context);

    return Directionality(
      textDirection: directionalityOverride,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 234, 227, 241),
        body: AdaptiveLayout(
          primaryNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig?>{
              Breakpoints.medium: SlotLayout.from(
                key: const Key('primaryNavigation'),
                builder: (_) {
                  return AdaptiveScaffold.standardNavigationRail(
                    onDestinationSelected: (int index) {
                      setState(() {
                        _navigationIndex = index;
                      });
                    },
                    selectedIndex: _navigationIndex,
                    leading: ScaleTransition(
                      scale: _favoritesIconSlideController,
                    ),
                    backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                    destinations: <NavigationRailDestination>[
                      slideInNavigationItem(
                        begin: -1,
                        controller: _homeIconSlideController,
                        icon: _navigationIndex == 0 ? Icons.home : Icons.home_outlined,
                        label: 'Inbox',
                      ),
                      slideInNavigationItem(
                        begin: -2,
                        controller: _favoritesIconSlideController,
                        icon: _navigationIndex == 1 ? Icons.favorite : Icons.favorite_border_outlined,
                        label: 'Favorites',
                      ),
                      slideInNavigationItem(
                        begin: -3,
                        controller: _profileIconSlideController,
                        icon: _navigationIndex == 2 ? Icons.person : Icons.person_outline,
                        label: 'Profile',
                      ),
                    ],
                  );
                },
              ),
              Breakpoints.large: SlotLayout.from(
                key: const Key('Large primaryNavigation'),
                // The AdaptiveScaffold builder here greatly simplifies
                // navigational elements.
                builder: (_) => AdaptiveScaffold.standardNavigationRail(
                  onDestinationSelected: (int index) {
                    setState(() {
                      _navigationIndex = index;
                    });
                  },
                  selectedIndex: _navigationIndex,
                  extended: true,
                  destinations:
                      destinations.map((NavigationDestination destination) {
                    return AdaptiveScaffold.toRailDestination(destination);
                  }).toList(),
                ),
              ),
            },
          ),
          body: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig?>{
              Breakpoints.standard: SlotLayout.from(
                key: const Key('body'),
                // The conditional here is for navigation screens. The first
                // screen shows the main screen and every other screen shows
                //  ExamplePage.
                builder: /*(_) => (_navigationIndex == 0)
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                        child: CafeList(
                          selected: selected,
                          viewModel: viewModel,
                          selectCard: selectCard,
                        ),
                      )
                    : const _ExamplePage(),*/
                (_) => (_navigationIndex == 0)
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                        child: CafeList(
                          selected: selected,
                          viewModel: viewModel,
                          selectCard: selectCard,
                        ),
                      )
                    : (_navigationIndex == 1)
                        ? const _ExamplePage()
                        : const ProfilePage(),
                ),
            },
          ),
          secondaryBody: _navigationIndex == 0
              ? SlotLayout(
                  config: <Breakpoint, SlotLayoutConfig?>{
                    Breakpoints.mediumAndUp: SlotLayout.from(
                      // This overrides the default behavior of the secondaryBody
                      // disappearing as it is animating out.
                      outAnimation: AdaptiveScaffold.stayOnScreen,
                      key: const Key('Secondary Body'),
                      builder: (_) => SafeArea(
                        child: CafeDetailTile(cafe: viewModel.cafes[selected ?? 0]),
                      ),
                    )
                  },
                )
              : null,
          bottomNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig?>{
              Breakpoints.small: SlotLayout.from(
                key: const Key('bottomNavigation'),
                // You can define inAnimations or outAnimations to override the
                // default offset transition.
                outAnimation: AdaptiveScaffold.topToBottom,
                builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
                  destinations: destinations,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _navigationIndex = index;
                    });
                  },
                  currentIndex: _navigationIndex,
                ),
              )
            },
          ),
        ),
      ),
    );
  }

  NavigationRailDestination slideInNavigationItem({
    required double begin,
    required AnimationController controller,
    required IconData icon,
    required String label,
  }) {
    return NavigationRailDestination(
      icon: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(begin, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic),
        ),
        child: Icon(icon),
      ),
      label: Text(label),
    );
  }
}

// The ScreenArguments used to pass arguments to the RouteDetailView as a named
// route.

class _ExamplePage extends StatelessWidget {
  const _ExamplePage();

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.grey);
  }
}
/*
class MainPage extends StatefulWidget {
  const MainPage({super.key, this.transitionDuration = 1000});

  /// Declare transition duration.
  final int transitionDuration;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedNavigation = 0;
  int _transitionDuration = 1000;

  // Initialize transition time variable.
  @override
  void initState() {
    super.initState();
    setState(() {
      _transitionDuration = widget.transitionDuration;
    });
  }

  @override
  Widget build(BuildContext context) {
    final NavigationRailThemeData navRailTheme =
        Theme.of(context).navigationRailTheme;

    // Define the children to display within the body.
    final List<Widget> children = List<Widget>.generate(10, (int index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: const Color.fromARGB(255, 234, 201, 163),
          height: 400,
        ),
      );
    });

    // Define the list of destinations to be used within the app.
    const List<NavigationDestination> destinations = <NavigationDestination>[
      NavigationDestination(
        label: 'Inbox',
        icon: Icon(Icons.inbox_outlined),
        selectedIcon: Icon(Icons.inbox),
      ),
      NavigationDestination(
        label: 'Articles',
        icon: Icon(Icons.article_outlined),
        selectedIcon: Icon(Icons.article),
      ),
      NavigationDestination(
        label: 'Chat',
        icon: Icon(Icons.chat_outlined),
        selectedIcon: Icon(Icons.chat),
      ),
    ];

    // Animation
    return AdaptiveLayout(
      transitionDuration: Duration(milliseconds: _transitionDuration),
      primaryNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.medium: SlotLayout.from(
            inAnimation: AdaptiveScaffold.leftOutIn,
            key: const Key('Primary Navigation Medium'),
            builder: (_) => AdaptiveScaffold.standardNavigationRail(
              selectedIndex: selectedNavigation,
              onDestinationSelected: (int newIndex) {
                setState(() {
                  selectedNavigation = newIndex;
                });
              },
              leading: const Icon(Icons.menu),
              destinations: destinations
                  .map((NavigationDestination destination) =>
                      AdaptiveScaffold.toRailDestination(destination))
                  .toList(),
              backgroundColor: navRailTheme.backgroundColor,
              selectedIconTheme: navRailTheme.selectedIconTheme,
              unselectedIconTheme: navRailTheme.unselectedIconTheme,
              selectedLabelTextStyle: navRailTheme.selectedLabelTextStyle,
              unSelectedLabelTextStyle: navRailTheme.unselectedLabelTextStyle,
            ),
          ),
          Breakpoints.large: SlotLayout.from(
            key: const Key('Primary Navigation Large'),
            inAnimation: AdaptiveScaffold.leftOutIn,
            builder: (_) => AdaptiveScaffold.standardNavigationRail(
              selectedIndex: selectedNavigation,
              onDestinationSelected: (int newIndex) {
                setState(() {
                  selectedNavigation = newIndex;
                });
              },
              extended: true,
              leading: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'REPLY',
                    style: TextStyle(color: Color.fromARGB(255, 255, 201, 197)),
                  ),
                  Icon(Icons.menu_open)
                ],
              ),
              destinations: destinations
                  .map((NavigationDestination destination) =>
                      AdaptiveScaffold.toRailDestination(destination))
                  .toList(),
              backgroundColor: navRailTheme.backgroundColor,
              selectedIconTheme: navRailTheme.selectedIconTheme,
              unselectedIconTheme: navRailTheme.unselectedIconTheme,
              selectedLabelTextStyle: navRailTheme.selectedLabelTextStyle,
              unSelectedLabelTextStyle: navRailTheme.unselectedLabelTextStyle,
            ),
          ),
        },
      ),
      // Body switches between a ListView and a GridView from small to medium
      // breakpoints and onwards.
      body: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: const Key('Body Small'),
            builder: (_) => ListView.builder(
              itemCount: children.length,
              itemBuilder: (BuildContext context, int index) => children[index],
            ),
          ),
          Breakpoints.mediumAndUp: SlotLayout.from(
            key: const Key('Body Medium'),
            builder: (_) =>
                GridView.count(crossAxisCount: 2, children: children),
          )
        },
      ),
      // BottomNavigation is only active in small views defined as under 600 dp
      // width.
      bottomNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.small: SlotLayout.from(
            key: const Key('Bottom Navigation Small'),
            inAnimation: AdaptiveScaffold.bottomToTop,
            outAnimation: AdaptiveScaffold.topToBottom,
            builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
              destinations: destinations,
              currentIndex: selectedNavigation,
              onDestinationSelected: (int newIndex) {
                setState(() {
                  selectedNavigation = newIndex;
                });
              },
            ),
          )
        },
      ),
    );
  }
}*/

/* @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Cafes"),
          ),
          bottomNavigationBar: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.favorite_border)),
              Tab(icon: Icon(Icons.person_rounded)),
            ],
          ),
          body: const TabBarView(
            children: <Widget>[
              SingleChildScrollView(child:
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.notifications_sharp),
                        title: Text('Notification 1'),
                        subtitle: Text('This is a notification'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.notifications_sharp),
                        title: Text('Notification 2'),
                        subtitle: Text('This is a notification'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.notifications_sharp),
                        title: Text('Notification 1'),
                        subtitle: Text('This is a notification'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.notifications_sharp),
                        title: Text('Notification 1'),
                        subtitle: Text('This is a notification'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.notifications_sharp),
                        title: Text('Notification 1'),
                        subtitle: Text('This is a notification'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.notifications_sharp),
                        title: Text('Notification 1'),
                        subtitle: Text('This is a notification'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.notifications_sharp),
                        title: Text('Notification 1'),
                        subtitle: Text('This is a notification'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.notifications_sharp),
                        title: Text('Notification 1'),
                        subtitle: Text('This is a notification'),
                      ),
                    ),
                  ],
                ),
              ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.notifications_sharp),
                        title: Text('Notification 1'),
                        subtitle: Text('This is a notification'),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.notifications_sharp),
                        title: Text('Notification 2'),
                        subtitle: Text('This is a notification'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }*/
