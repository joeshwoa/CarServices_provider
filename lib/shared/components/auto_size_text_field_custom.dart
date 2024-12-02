import 'dart:math' as math;
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AutoSizeTextFieldCustom extends StatefulWidget {
  static const double _defaultFontSize = 14.0;
  static const int noMaxLength = -1;
  final Key? textFieldKey;
  final TextSpan? textSpan;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final double minFontSize;
  final double maxFontSize;
  final double stepGranularity;
  final List<double>? presetFontSizes;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool wrapWords;
  final Widget? overflowReplacement;
  final int? maxLines;
  final String? semanticsLabel;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final TextSelectionControls? selectionControls;
  final TextCapitalization textCapitalization;
  final TextAlignVertical? textAlignVertical;
  final Iterable<String>? autofillHints;
  final bool autofocus;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType smartDashesType;
  final SmartQuotesType smartQuotesType;
  final bool enableSuggestions;
  final int? minLines;
  final bool expands;
  final bool readOnly;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  static Widget _defaultContextMenuBuilder(BuildContext context, EditableTextState editableTextState) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }
  final bool? showCursor;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final DragStartBehavior dragStartBehavior;
  final GestureTapCallback? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final bool fullwidth;
  final double? minWidth;
  final FormFieldValidator? validator;
  final AutovalidateMode? autovalidateMode;

  const AutoSizeTextFieldCustom({
    Key? key,
    this.fullwidth = true,
    this.textFieldKey,
    this.style,
    this.strutStyle,
    this.minFontSize = 12,
    this.maxFontSize = double.infinity,
    this.stepGranularity = 1,
    this.presetFontSizes,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.locale,
    this.wrapWords = true,
    this.overflowReplacement,
    this.semanticsLabel,
    this.controller,
    this.focusNode,
    this.decoration = const InputDecoration(),
    TextInputType? keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.textAlignVertical,
    this.autofillHints,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines,
    this.expands = false,
    this.readOnly = false,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.showCursor,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.validator,
    this.autovalidateMode,
    this.inputFormatters,
    this.enabled,
    this.cursorHeight,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.onTap,
    this.onTapOutside,
    this.buildCounter,
    this.scrollPhysics,
    this.scrollController,
    this.minLines,
    this.minWidth,
    this.selectionControls,
  })  : textSpan = null,
        smartDashesType = smartDashesType ?? (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
        smartQuotesType = smartQuotesType ?? (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
        assert(minLines == null || minLines > 0),
        assert((minWidth == null && fullwidth == true) || fullwidth == false),
        assert(!obscureText || maxLines == 1, 'Obscured fields cannot be multiline.'),
        assert(maxLength == null || maxLength == TextField.noMaxLength || maxLength > 0),
        keyboardType = keyboardType ?? (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        super(key: key);

  String get data => controller!.text;
  bool get selectionEnabled => enableInteractiveSelection;

  @override
  _AutoSizeTextFieldCustomState createState() => _AutoSizeTextFieldCustomState();
}

class _AutoSizeTextFieldCustomState extends State<AutoSizeTextFieldCustom> {
  late double _textSpanWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      var defaultTextStyle = DefaultTextStyle.of(context);

      var style = widget.style;
      if (widget.style == null || widget.style!.inherit) {
        style = defaultTextStyle.style.merge(widget.style);
      }
      if (style!.fontSize == null) {
        style = style.copyWith(fontSize: AutoSizeTextFieldCustom._defaultFontSize);
      }

      var maxLines = widget.maxLines ?? defaultTextStyle.maxLines;
      _sanityCheck();

      var result = _calculateFontSize(size, style, maxLines);
      var fontSize = result[0] as double;
      var textFits = result[1] as bool;

      Widget textField;
      textField = _buildTextField(fontSize, style, maxLines);
      if (widget.overflowReplacement != null && !textFits) {
        return widget.overflowReplacement!;
      } else {
        return textField;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    widget.controller!.addListener(() {
      if (this.mounted) {
        this.setState(() {});
      }
    });
  }

  Widget _buildTextField(double fontSize, TextStyle style, int? maxLines) {
    return SizedBox(
      width: widget.fullwidth ? double.infinity : math.max(fontSize, _textSpanWidth),
      child: TextFormField(
        key: widget.textFieldKey,
        autocorrect: widget.autocorrect,
        autofillHints: widget.autofillHints,
        autofocus: widget.autofocus,
        buildCounter: widget.buildCounter,
        contextMenuBuilder: widget.contextMenuBuilder,
        controller: widget.controller,
        cursorColor: widget.cursorColor,
        cursorRadius: widget.cursorRadius,
        cursorWidth: widget.cursorWidth,
        cursorHeight: widget.cursorHeight,
        decoration: widget.decoration,
        dragStartBehavior: widget.dragStartBehavior,
        enabled: widget.enabled,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        enableSuggestions: widget.enableSuggestions,
        expands: widget.expands,
        focusNode: widget.focusNode,
        inputFormatters: widget.inputFormatters,
        keyboardAppearance: widget.keyboardAppearance,
        keyboardType: widget.keyboardType,
        maxLength: widget.maxLength,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        obscureText: widget.obscureText,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
        onFieldSubmitted: widget.onFieldSubmitted,
        validator: widget.validator,
        autovalidateMode: widget.autovalidateMode,
        onTap: widget.onTap,
        onTapOutside: widget.onTapOutside,
        readOnly: widget.readOnly,
        scrollController: widget.scrollController,
        scrollPadding: widget.scrollPadding,
        scrollPhysics: widget.scrollPhysics,
        selectionHeightStyle: widget.selectionHeightStyle,
        selectionWidthStyle: widget.selectionWidthStyle,
        showCursor: widget.showCursor,
        smartDashesType: widget.smartDashesType,
        smartQuotesType: widget.smartQuotesType,
        strutStyle: widget.strutStyle,
        style: style.copyWith(fontSize: fontSize),
        textAlign: widget.textAlign,
        textAlignVertical: widget.textAlignVertical,
        textCapitalization: widget.textCapitalization,
        textDirection: widget.textDirection,
        textInputAction: widget.textInputAction,
        selectionControls: widget.selectionControls,
      ),
    );
  }

  List _calculateFontSize(
      BoxConstraints size, TextStyle? style, int? maxLines) {
    var span = TextSpan(
      style: widget.textSpan?.style ?? style,
      text: widget.textSpan?.text ?? widget.data,
      children: widget.textSpan?.children,
      recognizer: widget.textSpan?.recognizer,
    );

    var userScale = MediaQuery.textScaleFactorOf(context);

    int left;
    int right;

    var presetFontSizes = widget.presetFontSizes?.reversed.toList();
    if (presetFontSizes == null) {
      num defaultFontSize = style!.fontSize!.clamp(widget.minFontSize, widget.maxFontSize);
      var defaultScale = defaultFontSize * userScale / style.fontSize!;
      if (_checkTextFits(span, defaultScale, maxLines, size)) {
        return [defaultFontSize * userScale, true];
      }

      left = (widget.minFontSize / widget.stepGranularity).floor();
      right = (defaultFontSize / widget.stepGranularity).ceil();
    } else {
      left = 0;
      right = presetFontSizes.length - 1;
    }

    var lastValueFits = false;
    while (left <= right) {
      var mid = (left + (right - left) / 2).toInt();
      double scale;
      if (presetFontSizes == null) {
        scale = mid * userScale * widget.stepGranularity / style!.fontSize!;
      } else {
        scale = presetFontSizes[mid] * userScale / style!.fontSize!;
      }

      if (_checkTextFits(span, scale, maxLines, size)) {
        left = mid + 1;
        lastValueFits = true;
      } else {
        right = mid - 1;
        if (maxLines == null) left = right - 1;
      }
    }

    if (!lastValueFits) {
      right += 1;
    }

    double fontSize;
    if (presetFontSizes == null) {
      fontSize = right * userScale * widget.stepGranularity;
    } else {
      fontSize = presetFontSizes[right] * userScale;
    }

    return [fontSize, lastValueFits];
  }

  bool _checkTextFits(TextSpan text, double scale, int? maxLines, BoxConstraints constraints) {
    double constraintWidth = constraints.maxWidth;
    double constraintHeight = constraints.maxHeight;
    if (widget.decoration.contentPadding != null) {
      constraintWidth -= widget.decoration.contentPadding!.horizontal;
      constraintHeight -= widget.decoration.contentPadding!.vertical;
    }

    if (!widget.wrapWords) {
      List<String?> words = text.toPlainText().split(RegExp('\\s+'));

      // Adds prefix and suffix text
      if (widget.decoration.prefixText != null) words.add(widget.decoration.prefixText);
      if (widget.decoration.suffixText != null) words.add(widget.decoration.suffixText);

      var wordWrapTp = TextPainter(
        text: TextSpan(
          style: text.style,
          text: words.join('\n'),
        ),
        textAlign: widget.textAlign,
        textDirection: widget.textDirection ?? TextDirection.ltr,
        textScaleFactor: scale,
        maxLines: words.length,
        locale: widget.locale,
        strutStyle: widget.strutStyle,
      );

      wordWrapTp.layout(maxWidth: constraintWidth);
      double _width = (widget.decoration.contentPadding != null) ? wordWrapTp.width + widget.decoration.contentPadding!.horizontal : wordWrapTp.width;
      _textSpanWidth = math.max(_width, widget.minWidth ?? 0);

      if (wordWrapTp.didExceedMaxLines || wordWrapTp.width > constraints.maxWidth) {
        return false;
      }
    }

    String word = text.toPlainText();

    if (word.length > 0) {
      // replace all \n with 'space with \n' to prevent dropping last character to new line
      var textContents = text.text ?? '';
      word = textContents.replaceAll('\n', ' \n');
      // \n is 10, <space> is 32
      if (textContents.codeUnitAt(textContents.length - 1) != 10 && textContents.codeUnitAt(textContents.length - 1) != 32) {
        word += ' ';
      }
    }

    // Adds prefix and suffix text
    word += widget.decoration.prefixText ?? '';
    word += widget.decoration.suffixText ?? '';

    var tp = TextPainter(
      text: TextSpan(
        text: word,
        recognizer: text.recognizer,
        children: text.children,
        semanticsLabel: text.semanticsLabel,
        style: text.style,
      ),
      textAlign: widget.textAlign,
      textDirection: widget.textDirection ?? TextDirection.ltr,
      textScaleFactor: scale,
      maxLines: maxLines,
      locale: widget.locale,
      strutStyle: widget.strutStyle,
    );

    tp.layout(maxWidth: constraintWidth);
    double _width = (widget.decoration.contentPadding != null) ? tp.width + widget.decoration.contentPadding!.horizontal : tp.width;

    double _height = (widget.decoration.contentPadding != null) ? tp.height + widget.decoration.contentPadding!.vertical : tp.height;

    _textSpanWidth = math.max(_width, widget.minWidth ?? 0);

    if (maxLines == null) {
      if (_height >= constraintHeight) {
        return false;
      } else {
        return true;
      }
    } else {
      if (_width >= constraintWidth) {
        return false;
      } else {
        return true;
      }
    }
  }

  void _sanityCheck() {
    assert(widget.key == null || widget.key != widget.textFieldKey, 'Key and textKey cannot be the same.');

    if (widget.presetFontSizes == null) {
      assert(widget.stepGranularity >= 0.1,
      'StepGranularity has to be greater than or equal to 0.1. It is not a good idea to resize the font with a higher accuracy.');
      assert(widget.minFontSize >= 0, 'MinFontSize has to be greater than or equal to 0.');
      assert(widget.maxFontSize > 0, 'MaxFontSize has to be greater than 0.');
      assert(widget.minFontSize <= widget.maxFontSize, 'MinFontSize has to be smaller or equal than maxFontSize.');
      assert(widget.minFontSize / widget.stepGranularity % 1 == 0, 'MinFontSize has to be multiples of stepGranularity.');
      if (widget.maxFontSize != double.infinity) {
        assert(widget.maxFontSize / widget.stepGranularity % 1 == 0, 'MaxFontSize has to be multiples of stepGranularity.');
      }
    } else {
      assert(widget.presetFontSizes!.isNotEmpty, 'PresetFontSizes has to be nonempty.');
    }
  }
}
