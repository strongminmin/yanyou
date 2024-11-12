import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yanyou/api/Resource.dart';
import 'package:yanyou/components/Micro/FindResource/ResourceItem.dart';
import 'package:yanyou/models/ResourceModel.dart';
import 'package:yanyou/models/UserModel.dart';
import 'package:yanyou/provider/UserProvider.dart';

class FindResource extends StatefulWidget {
  _FindResourceState createState() => _FindResourceState();
}

class _FindResourceState extends State<FindResource>
    with TickerProviderStateMixin {
  TabController _tabController;
  Map<String, List<Resource>> resourceModel;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 0, vsync: this);
    fetchRequest();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  Future<void> fetchRequest() async {
    try {
      UserModel userModel = Provider.of<UserProvider>(
        context,
        listen: false,
      ).userInfo;
      var result = await getResourceList(userId: userModel.userId);
      if (result['noerr'] == 0) {
        setState(() {
          resourceModel = ResourceModel.fromJson(result['data']).resourceModel;
          _tabController = TabController(
            length: resourceModel.keys.length,
            vsync: this,
          );
        });
      }
    } catch (err) {
      print(err);
    }
  }

  TabController createTabController(num len) {
    if (_tabController == null) {
      _tabController = TabController(initialIndex: 0, length: len, vsync: this);
    }
    return _tabController;
  }

  @override
  Widget build(BuildContext context) {
    List<String> keys = [];
    if (resourceModel != null) {
      keys = resourceModel.keys.toList();
      createTabController(keys.length);
    }
    return resourceModel == null
        ? Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('找资料'),
              centerTitle: true,
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: keys.map((key) {
                  return Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      key,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: keys.map(
                (key) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: ListView.builder(
                        itemCount: resourceModel[key].length,
                        itemBuilder: (context, index) {
                          return ResourceItem(
                            resourceModel: resourceModel[key][index],
                          );
                        }),
                  );
                },
              ).toList(),
            ),
          );
  }
}
