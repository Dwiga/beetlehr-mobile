import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

import '../../../component.dart';

class DropdownInput extends StatefulWidget {
  final String? hintText, errorText;
  final List<String> data;
  final String? initialValue;
  final ValueChanged<String> onChange;
  final String? label;
  final bool? isRequired;
  final bool? withSearchBar;
  final bool? readOnly;

  const DropdownInput(
      {Key? key,
      this.hintText,
      this.errorText,
      required this.onChange,
      this.label,
      this.isRequired,
      required this.data,
      this.initialValue,
      this.withSearchBar,
      this.readOnly = false})
      : super(key: key);

  @override
  _DropdownInputState createState() => _DropdownInputState();
}

class _DropdownInputState extends State<DropdownInput> {
  final TextEditingController controller = TextEditingController();
  String? _currentData;

  @override
  void initState() {
    if (widget.initialValue != null) {
      _currentData = widget.initialValue;
      if (widget.data.contains(widget.initialValue)) {
        controller.text = widget.initialValue!;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RegularTextInput(
      isRequired: widget.isRequired,
      controller: controller,
      hintText: widget.hintText,
      errorText: widget.errorText,
      onChange: widget.onChange,
      readOnly: true,
      suffix:
          !(widget.readOnly ?? false) ? const Icon(Icons.expand_more) : null,
      onTap: !(widget.readOnly ?? false) ? _onChange : null,
      label: widget.label,
    );
  }

  void _onChange() async {
    final _callBackData = await Navigator.of(context).push(CupertinoPageRoute(
      builder: (_) => _SelectDropdownItem(
        data: widget.data,
        initialValue: _currentData,
        title: widget.label ?? '',
        withSearchBar: widget.withSearchBar,
      ),
    ));

    if (_callBackData != null && widget.data.contains(_callBackData)) {
      controller.text = _callBackData.toString();
      widget.onChange(_callBackData.toString());
      setState(() {
        _currentData = _callBackData;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _SelectDropdownItem extends StatefulWidget {
  final String? initialValue;
  final List<String> data;
  final String title;
  final bool? withSearchBar;

  const _SelectDropdownItem(
      {Key? key,
      this.initialValue,
      required this.data,
      required this.title,
      this.withSearchBar = false})
      : super(key: key);

  @override
  __SelectDropdownItemState createState() => __SelectDropdownItemState();
}

class __SelectDropdownItemState extends State<_SelectDropdownItem> {
  String? _currentValue;
  final TextEditingController _searchController = TextEditingController();
  String? _query;

  @override
  void initState() {
    if (widget.initialValue != null) {
      _currentValue = widget.initialValue;
    }
    _searchController.addListener(() {
      setState(() {
        _query = _searchController.text;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        widget.withSearchBar ?? false ? _buildSearchBar() : const SizedBox(),
        Expanded(
          child: _searchController.text.isEmpty
              ? _buildList(widget.data)
              : _buildListSearch(),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(Dimens.dp16),
      child: SearchTextInput(
        controller: _searchController,
      ),
    );
  }

  Widget _buildList(List<String> data) {
    return ListView.separated(
        physics:  const BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(
              data[index],
              style: const  TextStyle(fontWeight: FontWeight.normal),
            ),
            trailing: _currentValue == data[index]
                ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                : const  SizedBox(),
            onTap: () => _setCurrentData(data[index]),
          );
        },
        separatorBuilder: (_, __) {
          return  const Divider(height: 1);
        },
        itemCount: data.length);
  }

  Widget _buildListSearch() {
    var _searchResult = <String>[];
    for (var i = 0; i < widget.data.length; i++) {
      var item = widget.data[i];

      if (item.toLowerCase().contains((_query ?? '').toLowerCase())) {
        _searchResult.add(item);
      }
    }

    return _buildList(_searchResult);
  }

  void _setCurrentData(String data) {
    setState(() {
      _currentValue = data;
      _onNavigateBack();
    });
  }

  void _onNavigateBack() {
    Navigator.of(context).pop(_currentValue);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
