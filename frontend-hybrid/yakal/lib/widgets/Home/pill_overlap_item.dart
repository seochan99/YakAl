import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yakal/models/Home/pill_todo_children.dart';
import 'package:yakal/utilities/style/color_styles.dart';

class PillOverlapParentItem extends StatelessWidget {
  final String atcCode;
  final List<PillTodoChildren> pillTodoChildrenList;
  const PillOverlapParentItem({
    Key? key,
    required this.atcCode,
    required this.pillTodoChildrenList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
            child: Text(
              atcCode,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorStyles.black,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pillTodoChildrenList.length,
            itemBuilder: (BuildContext context, int index) {
              return _PillOverlapChildren(
                pillTodoChildren: pillTodoChildrenList[index],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PillOverlapChildren extends StatelessWidget {
  final PillTodoChildren pillTodoChildren;
  const _PillOverlapChildren({
    Key? key,
    required this.pillTodoChildren,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox.fromSize(size: const Size(5, 20)),
        ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: pillTodoChildren.base64Image.isEmpty
                ? SvgPicture.asset(
                    'assets/icons/icon-check-on-36.svg',
                    width: 80,
                    height: 40,
                  )
                : Container(
                    width: 80,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: CachedMemoryImage(
                      uniqueKey: 'app://image/dose/${pillTodoChildren.kdCode}',
                      base64: pillTodoChildren.base64Image,
                      placeholder: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )),
        SizedBox.fromSize(size: const Size(10, 10)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pillTodoChildren.name.length > 16
                  ? '${pillTodoChildren.name.substring(0, 11)}...'
                  : pillTodoChildren.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                // 글자 수 제한(16글자)
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              pillTodoChildren.effect,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff8d8d8d),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
