
import 'package:contacts_app_fl/page_routes/page_route_constant.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../contact_list_screen.dart';
import '../login_screen.dart';


class StorePageRoute {
  static List<GetPage> mainPageRoute = [

    GetPage(name: PageRouteConstant.loginScreen, page: () => LoginScreen()),
    GetPage(name: PageRouteConstant.contact, page: () => ContactListScreen()),





  ];
}

