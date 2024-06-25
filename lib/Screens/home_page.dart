import 'package:expansion_panel_list/data/panel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isOuterExpanded = false;
  int _currentlyExpandedPanelIndex = -1;
  final List<Item> _data = generateItems(5);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expansion Panel List Demo'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: _buildOuterPanel(),
          ),
        ));
  }

  Widget _buildOuterPanel() {
    return ExpansionPanelList(
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _isOuterExpanded = isExpanded;
          if (!isExpanded) {
            _currentlyExpandedPanelIndex = -1;
          }
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                'Outer Panel',
                style: TextStyle(
                  fontSize: 20.0, // Set the font size
                  fontWeight: FontWeight.bold, // Set the font weight
                ),
              ),
            );
          },
          body: _isOuterExpanded ? _buildInnerPanel() : Container(),
          isExpanded: _isOuterExpanded,
          canTapOnHeader: true,
        ),
      ],
    );
  }

  Widget _buildInnerPanel() {
    return ExpansionPanelList(
      expandedHeaderPadding: EdgeInsets.zero,
      materialGapSize: 0,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          //_data[index].isExpanded = isExpanded;
          _currentlyExpandedPanelIndex = isExpanded ? index : -1;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        int itemIndex = _data.indexOf(item);
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle:
                  const Text('To delete this panel, tap the trash can icon'),
              trailing: const Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: _currentlyExpandedPanelIndex == itemIndex,
          canTapOnHeader: true,
        );
      }).toList(),
    );
  }
}
