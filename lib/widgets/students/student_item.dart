import 'package:flutter/material.dart';

class StudentItem extends StatelessWidget {
  const StudentItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        height: 107,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 73, 94, 202),
            borderRadius: BorderRadius.circular(18)),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              child: ClipPath(
                clipper: ClipHalfOvalLeftSide(),
                child: Container(
                  height: 200,
                  width: 280,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 47, 104, 215),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: ClipPath(
                clipper: ClipOvalRightSide(),
                child: Container(
                  width: 235,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 47, 104, 215),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Nim",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Nama",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Tanggal Lahir",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Alamat",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClipHalfOvalLeftSide extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    Path path = Path();

    path.lineTo(width * 0.75, 0);
    path.quadraticBezierTo(
      width / 1.6,
      height * 0.75,
      width * 0.3,
      height,
    );
    path.lineTo(0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ClipOvalRightSide extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    Path path = Path();

    path.lineTo(0, height / 0.5);
    path.quadraticBezierTo(
      width * 0.6,
      height * -0.5,
      width * 2,
      height,
    );
    path.lineTo(0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
