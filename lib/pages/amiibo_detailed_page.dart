import 'package:amiibo_guide/model/amiibo_response.dio.dart';
import 'package:amiibo_guide/model/amiibo_detailed_response.dio.dart' as amiibo_detailed;
import 'package:amiibo_guide/provider/amiibo_detailed_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';
import 'package:logger/logger.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

showDetailedPage(BuildContext context, Amiibo amiibo) {
  Navigator.of(context).push(CupertinoPageRoute(
    builder: (context) => ChangeNotifierProvider(
        create: (_) => AmiiboDetailedProvider(amiibo.head, amiibo.tail), child: AmiiboDetailedPage(amiibo)),
  ));
}

class AmiiboDetailedPage extends StatefulWidget {
  final Amiibo amiibo;
  const AmiiboDetailedPage(this.amiibo, {Key? key}) : super(key: key);

  @override
  _AmiiboDetailedPageState createState() => _AmiiboDetailedPageState();
}

class _AmiiboDetailedPageState extends State<AmiiboDetailedPage> {
  late final AmiiboDetailedProvider _provider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.amiibo.name}"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        brightness: Brightness.dark,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: LikeButton(
                isLiked: false,
                likeBuilder: (isLiked) => Icon(Icons.star, size: 30, color: isLiked ? Colors.yellow : Colors.black26)),
          )
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h, left: 5.w, right: 5.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // color: Colors.red,
                  width: 125.w,
                  height: 180.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Hero(
                      tag: "${widget.amiibo.head}${widget.amiibo.tail}",
                      child: CachedNetworkImage(
                        imageUrl: widget.amiibo.image ?? "",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Container(
                    height: 185.h,
                    width: 1.w,
                    color: Colors.blue.shade100,
                  ),
                ),
                SizedBox(
                  height: 185.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildDes(),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Selector<AmiiboDetailedProvider, amiibo_detailed.Amiibo?>(
              selector: (_, provider) => provider.amiibo,
              builder: (_, amiiboUsage, __) {
                if (amiiboUsage == null) return LinearProgressIndicator();
                var list = [];
                if (amiiboUsage.gamesSwitch!.length != 0) {
                  list.add(ExpansionTile(
                    title: Text("Switch"),
                    children: amiiboUsage.gamesSwitch!.map((e) => _buildUsage(e)).toList(),
                    initiallyExpanded: false,
                  ));
                }
                if (amiiboUsage.gamesWiiU!.length != 0) {
                  list.add(ExpansionTile(
                    title: Text("WiiU"),
                    children: amiiboUsage.gamesWiiU!.map((e) => _buildUsage(e)).toList(),
                    initiallyExpanded: false,
                  ));
                }
                if (amiiboUsage.games3DS!.length != 0) {
                  list.add(ExpansionTile(
                    title: Text("3DS"),
                    children: amiiboUsage.games3DS!.map((e) => _buildUsage(e)).toList(),
                    initiallyExpanded: false,
                  ));
                }
                return Column(children: List.unmodifiable(list));
              }),
        ],
      ),
    );
  }

  List<Widget> _buildDes() {
    var list = [];
    list.add(_buildText("Character: ${widget.amiibo.character}"));
    list.add(_buildText("Serie: ${widget.amiibo.amiiboSeries}"));
    list.add(_buildText("Game: ${widget.amiibo.gameSeries}"));
    list.add(_buildText("Type: ${widget.amiibo.type}"));
    if (widget.amiibo.release?.au != "") list.add(_buildText("🇦🇺   ${widget.amiibo.release?.au}"));
    if (widget.amiibo.release?.eu != "") list.add(_buildText("🇬🇧   ${widget.amiibo.release?.eu}"));
    if (widget.amiibo.release?.jp != "") list.add(_buildText("🇯🇵   ${widget.amiibo.release?.jp}"));
    if (widget.amiibo.release?.na != "") list.add(_buildText("🇺🇸   ${widget.amiibo.release?.na}"));

    return List.unmodifiable(list);
  }

  Widget _buildText(String text) {
    return Text(text, maxLines: 1, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500));
  }

  Widget _buildUsage(amiibo_detailed.Games3DS usage) {
    var list = [];
    list.add(Text("${usage.gameName}", style: TextStyle(fontSize: 17.sp)));
    list.addAll(usage.amiiboUsage!
        .map((e) => Text(e.Usage!, style: TextStyle(fontSize: 14.sp, color: Colors.black26)))
        .toList());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: Container(
        width: 355.w,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: List.unmodifiable(list)),
      ),
    );
  }
}
