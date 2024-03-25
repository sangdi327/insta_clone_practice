import 'package:flutter/material.dart';
import 'package:insta_clone/components/image_data.dart';
import 'package:insta_clone/controller/bottom_nav_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  Widget tabMenuOne(String menu) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        menu,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    );
  }

  PreferredSizeWidget tabMenu() {
    return PreferredSize(
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      child: Container(
        height: AppBar().preferredSize.height,
        width: Size.infinite.width,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xffe4e4e4),
            ),
          ),
        ),
        child: TabBar(
          controller: tabController,
          indicatorColor: Colors.black,
          tabs: [
            tabMenuOne('Hits'),
            tabMenuOne('Ids'),
            tabMenuOne('Audio'),
            tabMenuOne('Tag'),
            tabMenuOne('Place'),
          ],
        ),
      ),
    );
  }

  Widget body() {
    return TabBarView(
      controller: tabController,
      children: const [
        Center(
          child: Text('page1'),
        ),
        Center(
          child: Text('page2'),
        ),
        Center(
          child: Text('page3'),
        ),
        Center(
          child: Text('page4'),
        ),
        Center(
          child: Text('page5'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        leading: GestureDetector(
          onTap: BottomNavController.to.willPopAction,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(IconsPath.backBtnIcon),
          ),
        ),
        title: Container(
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xffefefef),
          ),
          child: const TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'search',
              contentPadding: EdgeInsets.only(left: 15, top: 7, bottom: 7),
              isDense: true,
            ),
          ),
        ),
        bottom: tabMenu(),
      ),
      body: body(),
    );
  }
}
