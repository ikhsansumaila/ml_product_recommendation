import 'package:flutter/material.dart';
import 'package:ml_product_recommendation/models/product/product_model.dart';
import 'package:ml_product_recommendation/modules/product_list/sliver_list/product_item/favorite_button.dart';
import 'package:ml_product_recommendation/utils/size.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    final bodyWidth = sizeConfig.screenWidth;
    final bodyHeight = sizeConfig.screenHeight;
    return SizedBox(
      width: bodyWidth * 0.40,
      height: bodyHeight * 0.34,
      child: LayoutBuilder(
        builder: (_, constraints) {
          return InkWell(
            onTap: () => {},
            // () => Navigator.pushNamed(
            //     context, ProductDetailView.routeName,
            //     arguments: product.id),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(bodyWidth * 0.03)),
                        child: Hero(
                          tag: widget.product.id,
                          child: Image.network(
                            widget.product.images,
                            width: constraints.maxWidth * 1.00,
                            height: constraints.maxHeight * 0.71,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: constraints.maxWidth / 1.32,
                        top: constraints.maxHeight / 1.59,
                        child: FavoriteButton(
                          parentWidth: constraints.maxWidth,
                          parentHeight: constraints.maxHeight,
                          product: widget.product,
                          isFavorite: widget.product.favorite,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.02,
                ),
                Row(
                  children: [
                    ...List.generate(
                      5,
                      (index) => const Icon(
                        Icons.star_border_rounded,
                        color: Color(0xFF9B9B9B),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.02,
                ),
                Text(
                  widget.product.brand as String,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF9B9B9B),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.02,
                ),
                Text(
                  widget.product.title,
                  maxLines: 1,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 16,
                    color: Color(0xFF222222),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.01,
                ),
                Text(
                  '${widget.product.price}\$',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF222222),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
