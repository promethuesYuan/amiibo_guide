import 'package:amiibo_guide/model/amiibo_response.dio.dart';
import 'package:amiibo_guide/pages/amiibo_detailed_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:like_button/like_button.dart';

class AmiiboCard extends StatelessWidget {
  final Amiibo amiibo;
  const AmiiboCard(this.amiibo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Fluttertoast.cancel();
        return showDetailedPage(context, amiibo);
      },
      child: SizedBox(
        width: 165.w,
        child: Card(
          elevation: 2,
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  color: Colors.black26,
                ),
                constraints: BoxConstraints(minHeight: 100.h),
                width: 165.w,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Hero(
                  tag: "${amiibo.head}${amiibo.tail}",
                  child: CachedNetworkImage(
                    imageUrl: amiibo.image ?? "",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                child: Text(
                  amiibo.name ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
              Container(
                height: 25.h,
                padding: EdgeInsets.only(left: 10.w, bottom: 3.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 120.w),
                      child: Text(
                        amiibo.amiiboSeries ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: TextStyle(fontSize: 12.sp, color: Colors.black26),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    LikeButton(
                      isLiked: false,
                      likeBuilder: (isLiked) => Icon(Icons.star, color: isLiked ? Colors.yellow : Colors.black26),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
