import 'package:amiibo_guide/common/mytoast.dart';
import 'package:amiibo_guide/model/amiibo_response.dio.dart';
import 'package:amiibo_guide/provider/home_provider.dart';
import 'package:amiibo_guide/widget/amiibo_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keframe/frame_separate_widget.dart';
import 'package:keframe/size_cache_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:like_button/like_button.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? _lastPop;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_lastPop == null || DateTime.now().difference(_lastPop!) > Duration(seconds: 2)) {
          showToast("再按一次退出");
          _lastPop = DateTime.now();
          return false;
        }
        Fluttertoast.cancel();
        _lastPop = DateTime.now();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("All Amiibos"),
          centerTitle: true,
          brightness: Brightness.dark,
        ),
        body: SizeCacheWidget(
          estimateCount: 8 * 2,
          child: Selector<HomeProvider, List<Amiibo>?>(
            selector: (_, provider) => provider.list,
            shouldRebuild: (pre, next) => pre != next,
            builder: (_, list, __) {
              if (list == null) return Center(child: CircularProgressIndicator());
              return WaterfallFlow.builder(
                cacheExtent: 700,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 13.w,
                  mainAxisSpacing: 10.h,
                ),
                itemBuilder: (_, index) {
                  var amiibo = list[index];
                  return FrameSeparateWidget(
                      placeHolder: Container(
                        height: 300.h,
                        width: 165.w,
                      ),
                      child: AmiiboCard(amiibo));
                },
                itemCount: list.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
