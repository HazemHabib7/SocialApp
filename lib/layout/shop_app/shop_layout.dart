// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:udemy/layout/shop_app/cubit/cubit.dart';
// import 'package:udemy/layout/shop_app/cubit/states.dart';
// import 'package:udemy/modules/shop_app/search/search_screen.dart';
// import 'package:udemy/shared/components/components.dart';
// import 'package:udemy/shared/network/local/cache_helper.dart';
// import 'package:udemy/shared/styles/colors.dart';
// import '../../modules/shop_app/login/shop_login_screen.dart';
//
// class ShopLayout extends StatelessWidget {
//   const ShopLayout({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ShopCubit, ShopStates>(
//     listener: (context, state) {},
//     builder: (context, state) {
//       ShopCubit cubit = ShopCubit.get(context);
//     return Scaffold(
//       appBar: AppBar(
//     title: Text('Salla',style: TextStyle(color: defaultColor),),
//     actions: [
//       IconButton(onPressed: (){
//         navigateTo(context, ShopSearchScreen());
//       }, icon: Icon(Icons.search)),
//     ],
//       ),
//       body: cubit.items[cubit.currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//     items: [
//       BottomNavigationBarItem(
//         icon: Icon(Icons.home),
//         label: 'Home',
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.apps),
//         label: 'Categories',
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.favorite),
//         label: 'Favorites',
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.settings),
//         label: 'Settings',
//       ),
//     ],
//     onTap: (index){
//       cubit.changeBottomNav(index);
//     },
//     currentIndex: cubit.currentIndex,
//       ),
//     );
//     }
//     );
//
//   }
// }
