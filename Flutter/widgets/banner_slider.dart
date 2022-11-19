import 'package:flutter/material.dart';

class BannerView2 extends StatelessWidget {
  const BannerView2({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 250,
          child: PageView(
            children: const [
              BannerImage(
                bannerName: 'assets/banner1.webp',
              ),
              BannerImage(
                bannerName: 'assets/banner2.webp',
              ),
              BannerImage(
                bannerName: 'assets/banner3.webp',
              ),
              BannerImage(
                bannerName: 'assets/banner4.webp',
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 20,
          child: Text(
            "1/4",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class BannerImage extends StatelessWidget {
  const BannerImage({super.key, required this.bannerName});
  final String bannerName;

  getImgWidth(context) {
    return MediaQuery.of(context).size.width - 20;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        child: ClipPath(
          clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          child: Container(
            width: getImgWidth(context),
            child: Image.asset(bannerName, fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }
}
