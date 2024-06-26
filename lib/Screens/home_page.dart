import 'package:expansion_panel_list/data/panel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  OuterItem _outerPanel = OuterItem(headerValue: "Outer Panel", innerItems: []);
  int _currentlyExpandedInnerPanelIndex = -1;
  final List<Item> _data = generateItems(5);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expansion Panel List Demo'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: _buildOuterPanel(_outerPanel),
          ),
        ));
  }

  Widget _buildOuterPanel(OuterItem outerItem) {
    return ExpansionPanelList(
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          outerItem.isExpanded = isExpanded;          
          if (!isExpanded) {
            _currentlyExpandedInnerPanelIndex = -1;
          }
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                outerItem.headerValue,
                style: TextStyle(
                  fontSize: 20.0, // Set the font size
                  fontWeight: FontWeight.bold, // Set the font weight
                ),
              ),
            );
          },
          body: outerItem.isExpanded ? _buildInnerPanel() : Container(),
          isExpanded: outerItem.isExpanded,
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
          _currentlyExpandedInnerPanelIndex = isExpanded ? index : -1;
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
          isExpanded: _currentlyExpandedInnerPanelIndex == itemIndex,
          canTapOnHeader: true,
        );
      }).toList(),
    );
  }
}
