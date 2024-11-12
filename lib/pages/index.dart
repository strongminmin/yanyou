import 'package:flutter/material.dart';
import 'package:yanyou/routes/bottomBar.dart';

class Index extends StatefulWidget {
  final String title;
  Index({Key key, this.title}) : super(key: key);
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  PageController _pageController;
  int _pageIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController?.dispose();
  }

  void _onBottomNavigationBarTap(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  void _onPageChangeHandler(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: indexBottomBar.map((bar) {
          return BottomNavigationBarItem(
            icon: Icon(bar['icon']),
            title: Text(bar['text']),
          );
        }).toList(),
        currentIndex: _pageIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.blue,
        onTap: _onBottomNavigationBarTap,
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: _onPageChangeHandler,
        itemCount: indexBottomBar.length,
        itemBuilder: (context, index) {
          return indexBottomBar[index]['page'];
        },
      ),
    );
  }
}
