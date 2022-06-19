import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';

class _AZItem extends ISuspensionBean {
  final String title;
  final String tag;

  _AZItem({
    required this.title,
    required this.tag,
  });

  @override
  String getSuspensionTag() => tag;
}

class AlphabetScrollPage extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String> onClickedItem;

  const AlphabetScrollPage({
    Key? key,
    required this.items,
    required this.onClickedItem,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AlphabetScrollPage();
}

class _AlphabetScrollPage extends State<AlphabetScrollPage> {
  List<_AZItem> items = [];

  @override
  void initState() {
    super.initState();

    initList(widget.items);
  }

  void initList(List<String> items) {
    this.items = items
        .map((item) => _AZItem(title: item, tag: item[0].toUpperCase()))
        .toList();

    SuspensionUtil.sortListBySuspensionTag(this.items);
    SuspensionUtil.setShowSuspensionStatus(this.items);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) => AzListView(
        padding: EdgeInsets.all(16.0),
        data: items,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _buildListItem(item);
        },
        indexBarMargin: EdgeInsets.all(10),
        indexHintBuilder: (context, hint) => Container(
          alignment: Alignment.center,
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.deepPurpleAccent, shape: BoxShape.circle),
          child:
              Text(hint, style: TextStyle(color: Colors.white, fontSize: 30)),
        ),
        indexBarOptions: IndexBarOptions(
            needRebuild: true,
            indexHintAlignment: Alignment.centerRight,
            indexHintOffset: Offset(-20, 0),
            selectItemDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.deepPurpleAccent,
            ),
            selectTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
            )),
      );

  Widget _buildListItem(_AZItem item) {
    final tag = item.getSuspensionTag();
    final offstage = !item.isShowSuspension;

    return Column(
      children: [
        Offstage(offstage: offstage, child: buildHeader(tag)),
        Container(
          decoration: BoxDecoration(
            color: Colors.indigo[50],
            //border: Border.all(color: Colors.grey)
          ),
          margin: EdgeInsets.only(right: 32),
          child: ListTile(
            title: Text(item.title),
            onTap: () => widget.onClickedItem(item.title),
          ),
        ),
      ],
    );
  }

  Widget buildHeader(String tag) => Container(
        decoration: BoxDecoration(
            color: Colors.deepPurpleAccent[100],
            borderRadius: BorderRadius.all(Radius.circular(20))),
        height: 40,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(right: 32),
        padding: EdgeInsets.only(left: 16),
        //color: Colors.deepPurpleAccent[100],
        child: Text('$tag',
            softWrap: false,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      );
}
