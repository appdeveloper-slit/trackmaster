import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimension.dart';
import '../utils/staticmethods.dart';

class viewImage extends StatefulWidget {
  final img;

  const viewImage({super.key, this.img});

  @override
  State<viewImage> createState() => _viewImageState();
}

class _viewImageState extends State<viewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            STM().back2Previous(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: Dim().d32,
          ),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: widget.img.toString().contains('https')
                  ? Image.network(widget.img)
                  : Image.file(widget.img),
            ),
          ),
        ],
      ),
    );
  }
}
