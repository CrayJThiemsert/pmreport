import 'package:flutter/material.dart';
import 'package:pmreport/ui/home/home.dart';
import 'package:pmreport/ui/measure/view/measure_page.dart';
import 'package:pmreport/ui/models/selected_option.dart';
import 'package:pmreport/ui/report/view/report_page.dart';
import 'package:pmreport/utils/fade_animation_page.dart';
import '';

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {

  final GlobalKey<NavigatorState> navigatorKey;

  AppState appState = AppState();

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
  }

  AppRoutePath get currentConfiguration {
    if(appState.selectedIndex == 1) {
      return AppReportPath();
    } else if(appState.selectedIndex == 2) {
      return AppMeasurePath();
    } else if(appState.selectedOption == null) {
      return AppHomePath();
    } else {
      switch(appState.getSelectedOptionType()) {
        case 'category': {
          return AppCategoryPath(appState.selectedOption.uid);
        }
        break;
        case 'part': {
          return AppPartPath(appState.selectedOption.uid);
        }
        break;
        case 'topic': {
          return AppTopicPath(appState.selectedOption.uid);
        }
        break;
        case 'item': {
          return AppItemPath(appState.selectedOption.uid);
        }
        break;
        case 'form': {
          return AppFormPath(appState.selectedOption.uid);
        }
        break;
        
        default: {
          return AppHomePath();
        }
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(child: AppShell(appState: appState),
        ),
      ],
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath path) async {
    // Do only initial 
    if(path is AppHomePath) {
      appState.selectedIndex = 0;
      appState.selectedOption = null;
    } 
  }

}

abstract class AppRoutePath {}

class AppHomePath extends AppRoutePath {}

class AppReportPath extends AppRoutePath {}

class AppMeasurePath extends AppRoutePath {}

class AppCategoryPath extends AppRoutePath {
  final String uid;

  AppCategoryPath(this.uid);
}

class AppPartPath extends AppRoutePath {
  final String uid;

  AppPartPath(this.uid);
}

class AppTopicPath extends AppRoutePath {
  final String uid;

  AppTopicPath(this.uid);
}

class AppItemPath extends AppRoutePath {
  final String uid;

  AppItemPath(this.uid);
}

class AppFormPath extends AppRoutePath {
  final String uid;

  AppFormPath(this.uid);
}

class AppState extends ChangeNotifier {
  int _selectedIndex;
  
  SelectedOption _selectedOption;
  String _selectedOptionType;
  
  final List<String> optionTypes = [
    'category',
    'part',
    'topic',
    'item',
    'form',
  ];

  AppState() : _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int idx) {
    _selectedIndex = idx;
    if (_selectedIndex == 1) {
      // Remove this line if you want to keep the selected book when navigating
      // between "settings" and "home" which book was selected when Settings is
      // tapped.
      // selectedBook = null;
    }
    notifyListeners();
  }

  SelectedOption get selectedOption => _selectedOption;

  set selectedOption(SelectedOption option) {
    _selectedOption = option;
    notifyListeners();
  }

  String getSelectedOptionType() {
    if (!optionTypes.contains(_selectedOption.type)) return null;
    return optionTypes[optionTypes.indexOf(_selectedOption.type)];
  }
}

class AppShell extends StatefulWidget {
  final AppState appState;

  AppShell({@required this.appState,});

  @override
  _AppShellState createState() => _AppShellState();

}

class _AppShellState extends State<AppShell> {
  InnerRouterDelegate _routerDelegate;
  ChildBackButtonDispatcher _backButtonDispatcher;

  void initState() {
    super.initState();
    _routerDelegate = InnerRouterDelegate(widget.appState);
  }

  @override
  void didUpdateWidget(covariant AppShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    _routerDelegate.appState = widget.appState;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Defer back button dispatching to the child router
    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher
        .createChildBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    var appState = widget.appState;

    // Claim priority, If there are parallel sub router, you will need
    // to pick which one should take priority;
    _backButtonDispatcher.takePriority();

    return Scaffold(
      appBar: AppBar(),
      body: Router(
        routerDelegate: _routerDelegate,
        backButtonDispatcher: _backButtonDispatcher,
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.settings), label: 'Settings'),
      //   ],
      //   currentIndex: appState.selectedIndex,
      //   onTap: (newIndex) {
      //     appState.selectedIndex = newIndex;
      //   },
      // ),

    );

  }

}

class InnerRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  AppState get appState => _appState;
  AppState _appState;
  set appState(AppState value) {
    if (value == _appState) {
      return;
    }
    _appState = value;
    notifyListeners();
  }

  InnerRouterDelegate(this._appState);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (appState.selectedIndex == 0) ...[
          FadeAnimationPage(
            child: HomePage(),
            key: ValueKey('HomePage'),
            // child: BooksListScreen(
            //   books: appState.books,
            //   onTapped: _handleBookTapped,
            // ),
            // key: ValueKey('BooksListPage'),
          ),
          // if (appState.selectedOption != null)
          //   MaterialPage(
          //     key: ValueKey(appState.selectedOption),
          //     child: BookDetailsScreen(book: appState.selectedBook),
          //   ),
        ] else if(appState.selectedIndex == 1) ...[
          FadeAnimationPage(
            child: ReportPage(),
            key: ValueKey('ReportPage'),
            // child: SettingsScreen(),
            // key: ValueKey('SettingsPage'),
          ),
        ] else if(appState.selectedIndex == 2) ...[
          FadeAnimationPage(
            child: MeasurePage(),
            key: ValueKey('MeasurePage'),
            // child: SettingsScreen(),
            // key: ValueKey('SettingsPage'),
          ),
        ],
      ],
      onPopPage: (route, result) {
        appState.selectedOption = null;
        notifyListeners();
        return route.didPop(result);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath path) async {
    // This is not required for inner router delegate because it does not
    // parse route
    assert(false);
  }

  void _handleBookTapped(SelectedOption book) {
    appState.selectedOption = book;
    notifyListeners();
  }
}
