import 'package:flutter/material.dart';
import 'package:ukm_members_app/models/student.dart';
import 'package:ukm_members_app/screens/students/update_student_screen.dart';

class StudentItem extends StatelessWidget {
  const StudentItem({
    super.key,
    required this.studentData,
  });

  final Student studentData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => UpdateStudentScreen(studentUpdate: studentData))
          );
        },
        child: Container(
          height: 107,
          margin: const EdgeInsets.all(10),
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
                left: 10,
                right: 10,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        studentData.nim,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        studentData.name,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        studentData.formattedDate,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        studentData.adress,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white),
                      ),
                    ],
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
