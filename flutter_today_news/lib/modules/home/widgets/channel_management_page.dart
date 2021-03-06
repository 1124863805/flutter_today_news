import 'package:flutter/material.dart';
import 'dart:math';

import 'channel_listview_item.dart';

class ChannelManagementPage extends StatelessWidget {
  /// 频道
  List<String> titles = [
    "推荐","关注","推荐","热点",
    "视频","深圳","问答","娱乐",
    "图片","科技","懂车帝","体育",
    "直播","财经","军事","国际",
    "健康","正能量","幸福里",
    "新时代","NBA"];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff2f2f2),
      padding: EdgeInsets.only(bottom: 10.0),
      child: ListView.builder(
          itemCount: 2,
          itemBuilder: (BuildContext context,int index){
            if (index.isOdd){// 基数
              int idx = index ~/ 2;
              return _createListViewItem(context, idx);
            }else{
              int idx = index ~/ 2;
              return _createSectionHeader(idx);
            }
          }),
    );
  }

  /// 创建列表
  Widget _createListViewItem(BuildContext context,int index){
    List<String> titles = this.titles;
    return ChannelDidsplayView(titles);
  }

  /// 分组标题
  Widget _createSectionHeader(int index){
    return  Container(
      height: 30.0,
      padding: EdgeInsets.only(left: 15.0,top: 6.0,bottom: 6.0),
      alignment: Alignment.centerLeft,
      color: Color(0xfff2f2f2),
      child: Row(
        children: <Widget>[
          Text("我的频道",style: TextStyle(
              color: Color(0xff666666),
              fontSize: 14.0
          ),)
        ],
      ),
    );
  }


  Widget _createGirdView(BuildContext context){

    double lines = 1.0;
    double kColCount = 4;
    if(titles.length != 4){
      lines = ((titles.length + 2) ~/ 3).toDouble();
      kColCount = 3;
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double margin = 2.0;
    double itemWidth = (screenWidth - (kColCount + 1) * margin)/kColCount;
    double itemH = itemWidth * 2/5;
    return Container(
      height: itemH * lines + ((lines == 1 ? 1 : (lines))) * margin,
      padding: EdgeInsets.only(left: margin,right: margin,top: margin),
      color: Color(0xfff2f2f2),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),//去除gridView本身的滚动
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (titles.length == 4) ? 4 : 3,
            mainAxisSpacing: lines == 1 ? 0.0 : margin,
            crossAxisSpacing: margin,
            childAspectRatio: 5/2
        ),
        itemBuilder: _createGridViewItem,
        itemCount: titles.length,
      ),
    );
  }

  Widget _createGridViewItem(BuildContext context,int index){
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0)
        ),
        alignment: Alignment.center,
        child: Text(titles[index]),
      ),
    );
  }

  /// 获取随机颜色
  Color _getRandomColor() {
    return Color.fromARGB(
        255,
        Random.secure().nextInt(255),
        Random.secure().nextInt(255),
        Random.secure().nextInt(255));
  }
}
