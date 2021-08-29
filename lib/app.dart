import 'package:amiibo_guide/pages/home_page.dart';
import 'package:amiibo_guide/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fps_monitor/widget/custom_widget_inspector.dart';
import 'package:provider/provider.dart';

GlobalKey<NavigatorState> globalKey = GlobalKey();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback((t) => overlayState = globalKey.currentState!.overlay!);
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => HomeProvider(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: globalKey,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: CustomWidgetInspector(child: HomePage()),
        ),
      ),
    );
  }
}
