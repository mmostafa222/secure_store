import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:secure_store/core/utils/AppColors.dart';
import 'package:secure_store/core/utils/textstyle.dart';
import 'package:secure_store/feature/home/home/product_list.dart';
import 'package:secure_store/feature/presentation/model/view/view_model/category_model.dart';
import 'package:secure_store/feature/screens/search/SearchHomeView.dart';
import 'package:secure_store/feature/screens/search/presentaition/search_view.dart';
import 'package:svg_flutter/svg.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => homePageState();
}

class homePageState extends State<homePage> {
  final TextEditingController _productTitle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              TextFormField(
                textInputAction: TextInputAction.search,
                controller: _productTitle,
                decoration: InputDecoration(
                  hintStyle: getTitleStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.white),
                  filled: true,
                  hintText: 'search ',
                  suffixIcon: Container(
                    decoration: BoxDecoration(
                      color: appcolors.primerycolor.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: IconButton(
                      iconSize: 20,
                      splashRadius: 20,
                      color: Colors.white,
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        setState(
                          () {
                            _productTitle.text.isEmpty
                                ? Container()
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchView(
                                        searchKey: _productTitle.text,
                                      ),
                                    ),
                                  );
                          },
                        );
                      },
                    ),
                  ),
                ),
                style: getbodyStyle(),
                onFieldSubmitted: (String value) {
                  setState(
                    () {
                      _productTitle.text.isEmpty
                          ? Container()
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchHomeView(
                                  searchKey: _productTitle.text,
                                ),
                              ),
                            );
                    },
                  );
                },
              ),
              ButtonsTabBar(
                height: 120,
                splashColor: Colors.white,

                buttonMargin: const EdgeInsets.all(15),
                // Customize the appearance and behavior of the tab bar
                backgroundColor: Colors.white,
                borderWidth: 1,
                borderColor: Colors.white,
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                unselectedBorderColor: Colors.white,
                unselectedBackgroundColor: Colors.white,
                unselectedLabelStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                // Add your tabs here
                tabs: [
                  Tab(
                    icon: SvgPicture.asset('assets/icon car.svg'),
                    child: const Text('car'),
                  ),
                  Tab(
                    icon: SvgPicture.asset('assets/icon building.svg'),
                    child: const Text('Properety'),
                  ),
                  Tab(
                    icon: SvgPicture.asset('assets/icon mobile.svg'),
                    child: const Text('Mobile'),
                  ),
                  Tab(
                    icon: SvgPicture.asset('assets/icon bike.svg'),
                    child: const Text('Bike'),
                  ),
                ],
              ),
              Expanded(
                  child: TabBarView(
                children: [
                  productList(category: Cate[0].products),
                  productList(
                    category: Cate[1].products,
                  ),
                  productList(category: Cate[2].products),
                  productList(category: Cate[3].products),
                  // Icon(Icons.favorite),
                  // Icon(Icons.add),
                  // Icon(Icons.person_2_rounded),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
