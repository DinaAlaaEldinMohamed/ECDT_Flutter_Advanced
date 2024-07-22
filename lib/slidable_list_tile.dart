import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableListTile extends StatefulWidget {
  const SlidableListTile({super.key});

  @override
  State<SlidableListTile> createState() => _SlidableListTileState();
}

class _SlidableListTileState extends State<SlidableListTile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Column(children: [
          Slidable(
              startActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: doNothing,
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: doNothing,
                    backgroundColor: Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.share,
                    label: 'Share',
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: doNothing,
                    backgroundColor: Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                  SlidableAction(
                    onPressed: doNothing,
                    backgroundColor: Color(0xFF4B6584),
                    foregroundColor: Colors.white,
                    icon: Icons.info,
                    label: 'Info',
                  ),
                ],
              ),
              child: ListTile(
                title: const Text('Item 1'),
                subtitle: const Text('this is the item 1'),
                leading: const CircleAvatar(
                  radius: 50,
                  child: Text('IT'),
                ),
                trailing: const Text('05'),
                onTap: () {},
              )),
        ]));
  }

  void doNothing(BuildContext context) {}
}
