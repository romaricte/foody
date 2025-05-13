import 'package:flutter/material.dart';
import 'package:myfoody/helpers/services/auth_services.dart';
import 'package:myfoody/views/auth/forgot_password_screen.dart';
import 'package:myfoody/views/auth/login_screen.dart';
import 'package:myfoody/views/auth/register_account_screen.dart';
import 'package:myfoody/views/ui/cart_screen.dart';
import 'package:myfoody/views/home_screen.dart';
import 'package:myfoody/views/ui/customer/edit_customer_screen.dart';
import 'package:myfoody/views/ui/food/add_food_screen.dart';
import 'package:myfoody/views/ui/food/food_detail_screen.dart';
import 'package:myfoody/views/ui/food/food_edit_screen.dart';
import 'package:myfoody/views/ui/order_screen.dart';
import 'package:myfoody/views/ui/food/food_list_screen.dart';
import 'package:myfoody/views/ui/foods_screen.dart';
import 'package:myfoody/views/ui/restaurants/add_restaurant_screen.dart';
import 'package:myfoody/views/ui/restaurants/edit_restaurant_screen.dart';
import 'package:myfoody/views/ui/restaurants/restaurant_list_screen.dart';
import 'package:myfoody/views/ui/restaurants/restaurant_detail_screen.dart';
import 'package:myfoody/views/ui/chat_screen.dart';
import 'package:myfoody/views/ui/customer/add_customer_screen.dart';
import 'package:myfoody/views/ui/customer/customer_detail_screen.dart';
import 'package:myfoody/views/ui/customer/customer_list_screen.dart';
import 'package:myfoody/views/ui/dashboard_screen.dart';
import 'package:myfoody/views/ui/order/order_detail_screen.dart';
import 'package:myfoody/views/ui/order/order_list_screen.dart';
import 'package:myfoody/views/ui/seller/add_seller_screen.dart';
import 'package:myfoody/views/ui/seller/seller_detail_screen.dart';
import 'package:myfoody/views/ui/seller/seller_edit_screen.dart';
import 'package:myfoody/views/ui/seller/seller_list_screen.dart';
import 'package:myfoody/views/ui/setting_screen.dart';
import 'package:myfoody/views/ui/wallet_screen.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return AuthService.isLoggedIn
        ? null
        : const RouteSettings(name: '/auth/login');
  }
}

getPageRoute() {
  var routes = [
    GetPage(
        name: '/',
        page: () => const HomeScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/home',
        page: () => const HomeScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/dashboard',
        page: () => const DashboardScreen(),
        middlewares: [AuthMiddleware()]),

    ///*************AUTH*************///
    GetPage(name: '/auth/login', page: () => const LoginScreen()),
    GetPage(
        name: '/auth/register_account',
        page: () => const RegisterAccountScreen()),
    GetPage(
        name: '/auth/forgot_password',
        page: () => const ForgotPasswordScreen()),

    ///*************PAGES*************///

    ///Chat
    GetPage(
        name: '/chat',
        page: () => const ChatScreen(),
        middlewares: [AuthMiddleware()]),

    /// Orders
    GetPage(
        name: '/admin/orders',
        page: () => const OrderListScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin/orders/detail',
        page: () => const OrderDetailScreen(),
        middlewares: [AuthMiddleware()]),

    /// Customers
    GetPage(
        name: '/admin/customers',
        page: () => const CustomerListScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin/customers/detail',
        page: () => const CustomerDetailScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin/customers/create',
        page: () => const AddCustomerScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin/customers/edit',
        page: () => const EditCustomerScreen(),
        middlewares: [AuthMiddleware()]),

    /// Seller
    GetPage(
        name: '/admin/sellers',
        page: () => const SellerListScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin/sellers/detail',
        page: () => const SellerDetailScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin/sellers/create',
        page: () => const AddSellerScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin/sellers/edit',
        page: () => const SellerEditScreen(),
        middlewares: [AuthMiddleware()]),

    /// Restaurants
    GetPage(
        name: '/admin/restaurants',
        page: () => const RestaurantsListScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin/restaurants/detail',
        page: () => const RestaurantDetailScreen(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/admin/restaurants/create',
        page: () => const AddRestaurantScreen(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: '/admin/restaurants/edit',
        page: () => const EditRestaurantScreen(),
        middlewares: [AuthMiddleware()]),

    /// Cart

    GetPage(
        name: '/cart',
        page: () => const CartScreen(),
        middlewares: [AuthMiddleware()]),

    /// Food
    GetPage(
        name: '/admin/food',
        page: () => const FoodListScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin/food/detail',
        page: () => const FoodDetailScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin/food/create',
        page: () => const AddFoodScreen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: '/admin/food/edit',
        page: () => const FoodEditScreen(),
        middlewares: [AuthMiddleware()]),

    /// Foods
    GetPage(
        name: '/foods',
        page: () => const FoodsScreen(),
        middlewares: [AuthMiddleware()]),

    /// Order
    GetPage(
        name: '/orders',
        page: () => const OrderScreen(),
        middlewares: [AuthMiddleware()]),

    /// Wallet
    GetPage(
        name: '/admin/wallet',
        page: () => const WalletScreen(),
        middlewares: [AuthMiddleware()]),

    /// Setting
    GetPage(
        name: '/admin/setting',
        page: () => const SettingScreen(),
        middlewares: [AuthMiddleware()]),
  ];
  return routes
      .map((e) => GetPage(
          name: e.name,
          page: e.page,
          middlewares: e.middlewares,
          transition: Transition.noTransition))
      .toList();
}
