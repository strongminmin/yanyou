import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BannerSwiper extends StatelessWidget {
  final List<String> bannersUrl;
  BannerSwiper({Key key, this.bannersUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    num screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: 200,
      padding: EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Swiper(
          itemCount: bannersUrl.length,
          autoplay: true,
          pagination: SwiperPagination(),
          itemBuilder: (BuildContext context, int index) {
            return CachedNetworkImage(
              width: screenWidth,
              height: 200,
              imageUrl: bannersUrl[index],
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
