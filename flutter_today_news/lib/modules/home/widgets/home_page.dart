
import 'package:flutter/material.dart';
import 'package:flutter_today_news/consts/theme_model.dart';
import 'package:flutter_today_news/modules/home/api/HomeApi.dart';
import 'package:flutter_today_news/modules/home/model/home_nav_entity.dart';
import 'package:flutter_today_news/modules/home/view_model/home_view_model.dart';
import 'package:flutter_today_news/modules/home/widgets/wenda_page.dart';
import 'home_focus_page.dart';
import 'home_location_news_page.dart';
import 'home_recoment_page.dart';
import 'home_video_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin{

  List<String> _tabs = [];
  /// tabBarController
  TabController _tabController;
  /// 推荐
  HomeRecomendPage homePage;
  /// 热点
  HomeFocusPage focusPage;
  /// 视频
  HomeVideosPage videoPage;
  /// 深圳
  HomeLocationNewsPage locationNewsPage;
  /// 问答页
  HomeWendaPage wendaPage;
  /// 列表页
  List<Widget> tabPages;

  /// 根据标题或者索引去获取对应的widget
  int currentTabIndex = 0;

  /// 数据请求的viewModel
  HomeViewModel _viewModel;

  /// 请求回来的导航数据源
  List<HomeNavDataData> data;

  @override
  void initState() {
    super.initState();
    debugPrint("🤣 开始初始化>>>>");
    ///1.0准备网络请求工具
    _viewModel = HomeViewModel();
    _viewModel.prepareNetWorkTool();
    tabPages = new List();
    _viewModel.requestNavCategoryApiData((response){
      List<HomeNavDataData> data = response;
      this.data = data;
      this.data.forEach((model){
        debugPrint("😀name:${model.name}");
      });
      setState(() {
        this._tabs = this.data.map((model)=>model.name).toList();
        debugPrint("this._tabs:${this._tabs}");
        _tabController = TabController(length: _tabs.length, vsync: this);
      });
    }, (error){
      debugPrint("😂error:${error}");
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  /// 初始化tab
  Widget _initChannelTitle(){
    double addWidth = 40.0;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      width: screenWidth,
      child: Row(
        children: <Widget>[
          Container(
            width: (screenWidth - addWidth),
            color: Colors.white,
            child:
            TabBar(
                controller: _tabController,
                indicatorColor: tabSelColor,
                labelColor: tabSelColor,
                unselectedLabelColor: tabNormalColor,
                isScrollable: true,
                tabs: _tabs.map((item) => Tab(
                  text: item,
                )).toList()
            ),
          ),
          Container(
            width: addWidth,
            alignment: Alignment.center,
            child: GestureDetector(
              child: Icon(Icons.add),
              onTap: (){
                debugPrint("首页加号被点击了");
              },
            ),
          )
        ],
      ),
    );
  }

  /// 初始化内容列表
  Widget _initChannelList(){
    return TabBarView(
        controller: _tabController,
        children: this._tabs.map((tab){
          return HomeRecomendPage();
        }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _tabs.length == 0 ? Center(
      child: CircularProgressIndicator(),
    ) : DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
            appBar: AppBar(
              title: Text("首页"),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(48),
                child: Material(
                  color: Colors.white,
                  child: _initChannelTitle(),
                ),
              )
            ),
            body: _initChannelList()
        )
    );
  }

  @override
  bool get wantKeepAlive => true;
}

