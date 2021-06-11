// @dart=2.9
import 'package:flutter/material.dart';
import 'package:shopend/app/common/utils/size_config.dart';
import 'package:shopend/app/domain/model/_models.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key key,
    this.product,
  }) : super(key: key);

  final Producto product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238, context: context),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: 'image' + widget.product.nombre,
              child: Image.network(widget.product.imagen),
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20, context: context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildSmallProductPreview(),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview() {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(seconds: 2),
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(48, context: context),
        width: getProportionateScreenWidth(48, context: context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
        ),
        child: Image.network(widget.product.imagen),
      ),
    );
  }
}
