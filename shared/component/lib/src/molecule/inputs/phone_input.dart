import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preferences/preferences.dart';
import 'package:settings/settings.dart';

import '../../../component.dart';

class PhoneTextInput extends StatefulWidget {
  final TextStyle? style;
  final ValueChanged<String>? onChange;
  final FocusNode? focusNode;
  final TextInputAction? inputAction;
  final ValueChanged<String>? onSubmit;
  final bool? readOnly;
  final String? hintText;
  final String? errorText;
  final Widget? suffix;
  final String? label;
  final String? initialValue;
  final bool? isRequired;

  const PhoneTextInput({
    Key? key,
    this.style,
    this.onChange,
    this.focusNode,
    this.inputAction,
    this.onSubmit,
    this.readOnly,
    this.hintText,
    this.errorText,
    this.suffix,
    this.label,
    this.initialValue,
    this.isRequired,
  }) : super(key: key);

  @override
  _PhoneTextInputState createState() => _PhoneTextInputState();
}

class _PhoneTextInputState extends State<PhoneTextInput> {
  Country _currentCountry = CountryData.supportedCountry.first;
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    _initializeFormatPhone();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant PhoneTextInput oldWidget) {
    if (oldWidget.initialValue != widget.initialValue) {
      if ((widget.initialValue ?? '').isEmpty) {
        _phoneController.text = '';
      }
      _initializeFormatPhone();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _initializeFormatPhone() {
    var _isFoundCountry = false;
    if (widget.initialValue != null && (widget.initialValue ?? '').isNotEmpty) {
      for (var item in CountryData.supportedCountry) {
        var _currentCountryCode = item.dialCode;
        var _initialValue =
            '+${(widget.initialValue ?? '').replaceAll('+', '')}';
        if (_initialValue.contains(_currentCountryCode)) {
          var _phoneValue = _initialValue.replaceFirst(item.dialCode, '');
          if (mounted) _phoneController.text = _phoneValue.replaceAll('+', '');
          _currentCountry = item;
          if (((_currentCountry.dialCode) + _phoneController.text) !=
              widget.initialValue) {
            _onChange();
            _isFoundCountry = true;
          }
          break;
        }
      }
      if (!_isFoundCountry) {
        _phoneController.text =
            int.tryParse(widget.initialValue ?? '').toString();
        _onChange();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RegularTextInput(
      label: widget.label,
      style: widget.style,
      onChange: (_) => _onChange(),
      prefixIcon: _buildPrefix(),
      focusNode: widget.focusNode,
      inputAction: widget.inputAction ?? TextInputAction.done,
      inputType: TextInputType.phone,
      onSubmit: widget.onSubmit,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      readOnly: widget.readOnly ?? false,
      controller: _phoneController,
      hintText: widget.hintText,
      suffix: widget.suffix,
      errorText: widget.errorText,
      isRequired: widget.isRequired,
    );
  }

  Widget _buildPrefix() {
    return Padding(
      padding: const EdgeInsets.only(right: Dimens.dp12),
      child: InkWell(
        onTap: (widget.readOnly == true) ? null : _showPickCountry,
        child: Container(
            width: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(Dimens.dp8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SubTitle2Text(_currentCountry.dialCode,
                    style: const TextStyle(color: Colors.white)),
                const Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            )),
      ),
    );
  }

  void _onChange() {
    if (widget.onChange != null) {
      var _tempChange = int.tryParse(_phoneController.text);
      widget.onChange?.call((_currentCountry.dialCode).replaceFirst('+', '') +
          (_tempChange ?? '').toString());
    }
  }

  void _showPickCountry() {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => _CountryList(
          onChange: (value) {
            setState(() {
              _currentCountry = value;
            });
            _onChange();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}

class _CountryList extends StatefulWidget {
  final ValueChanged<Country> onChange;

  const _CountryList({Key? key, required this.onChange}) : super(key: key);

  @override
  __CountryListState createState() => __CountryListState();
}

class __CountryListState extends State<_CountryList> {
  final TextEditingController _controller = TextEditingController();
  final List<Country> _searchData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Country Code'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          tooltip: 'Close',
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: Dimens.dp16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.dp16),
            child: RegularTextInput(
              controller: _controller,
              hintText: 'Search Country or Dial Code',
              onChange: (value) => _onSearch(),
            ),
          ),
          const SizedBox(height: Dimens.dp16),
          (_controller.text.isEmpty)
              ? _buildListCountry(CountryData.supportedCountry)
              : _buildListCountry(_searchData),
        ],
      ),
    );
  }

  Widget _buildListCountry(List<Country> data) {
    return Expanded(
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, i) {
              return ListTile(
                onTap: () {
                  widget.onChange(data[i]);
                  Navigator.of(context).pop();
                },
                leading: Image.asset(
                  data[i].flag,
                  width: Dimens.dp24,
                  height: Dimens.dp24,
                ),
                title: Text(data[i].name),
                trailing: Text(data[i].dialCode),
              );
            },
            separatorBuilder: (_, __) {
              return const Divider(height: 1);
            },
            itemCount: data.length));
  }

  void _onSearch() {
    _searchData.clear();
    for (var item in CountryData.supportedCountry) {
      if (item.name.toLowerCase().contains(_controller.text.toLowerCase()) ||
          item.dialCode.contains(_controller.text)) {
        _searchData.add(item);
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
