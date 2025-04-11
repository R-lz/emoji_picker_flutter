import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

/// A widget that represents an individual clickable emoji cell.
/// Can have a long pressed listener [onSkinToneDialogRequested] that
/// provides necessary data to show a skin tone popup.
class EmojiCell extends StatelessWidget {
  /// Constructor for manually setting all properties
  const EmojiCell({
    super.key,
    required this.emoji,
    required this.emojiSize,
    required this.emojiBoxSize,
    this.categoryEmoji,
    required this.buttonMode,
    required this.enableSkinTones,
    required this.textStyle,
    required this.skinToneIndicatorColor,
    this.onSkinToneDialogRequested,
    required this.onEmojiSelected,
  });

  /// Constructor that can retrieve as much information as possible from
  /// [Config]
  EmojiCell.fromConfig(
      {super.key,
      required this.emoji,
      required this.emojiSize,
      required this.emojiBoxSize,
      this.categoryEmoji,
      required this.onEmojiSelected,
      this.onSkinToneDialogRequested,
      required Config config})
      : buttonMode = config.emojiViewConfig.buttonMode,
        enableSkinTones = config.skinToneConfig.enabled,
        textStyle = config.emojiTextStyle,
        skinToneIndicatorColor = config.skinToneConfig.indicatorColor;

  /// Emoji to display as the cell content
  final Emoji emoji;

  /// Font size for the emoji
  final double emojiSize;

  /// Hitbox of emoji cell
  final double emojiBoxSize;

  /// Optinonal category that will be passed through to callbacks
  final CategoryEmoji? categoryEmoji;

  /// Visual tap feedback, see [ButtonMode] for options
  final ButtonMode buttonMode;

  /// Whether to show skin popup indicator if emoji supports skin colors
  final bool enableSkinTones;

  /// Custom text style to use on emoji
  final TextStyle? textStyle;

  /// Color for skin color indicator triangle
  final Color skinToneIndicatorColor;

  /// Callback triggered on long press. Will be called regardless
  /// whether [enableSkinTones] is set or not and for any emoji to
  /// give a way for the caller to dismiss any existing overlays.
  final OnSkinToneDialogRequested? onSkinToneDialogRequested;

  /// Callback for a single tap on the cell.
  final OnEmojiSelected onEmojiSelected;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      padding: const EdgeInsets.all(0),
      width: emojiBoxSize,
      height: emojiBoxSize,
      child: Center(
        child: Stack(
          children: [
            Center(
              child: _buildEmojiWidget(),
            ),
            if (emoji.hasSkinTone && enableSkinTones)
              Positioned(
                right: 0,
                bottom: 0,
                child: CustomPaint(
                  size: const Size(6, 6),
                  painter: _TrianglePainter(skinToneIndicatorColor),
                ),
              ),
          ],
        ),
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkResponse(
        excludeFromSemantics: true,
        highlightShape: BoxShape.rectangle,
        onTap: () => onEmojiSelected(categoryEmoji?.category, emoji),
        onLongPress: onSkinToneDialogRequested == null
            ? null
            : () {
                final renderBox = context.findRenderObject() as RenderBox;
                final emojiBoxPosition = renderBox.localToGlobal(Offset.zero);
                onSkinToneDialogRequested!(
                  emojiBoxPosition,
                  emoji,
                  emojiSize,
                  categoryEmoji,
                );
              },
        child: child,
      ),
    );
  }

  Widget _buildEmojiWidget() {
    final effectiveSize = emojiSize > 0 ? emojiSize : 28.0;

    if (emoji.imageUrl == null || emoji.imageUrl!.isEmpty) {
      return _buildFallbackText(effectiveSize);
    }

    final url = emoji.imageUrl!;
    if (_isNetworkUrl(url)) {
      return _buildNetworkImage(url, effectiveSize);
    } else if (_isAssetUrl(url)) {
      return _buildAssetImage(url, effectiveSize);
    }

    return _buildFallbackText(effectiveSize);
  }

  bool _isNetworkUrl(String url) {
    return url.startsWith('https://') || url.startsWith('http://');
  }

  bool _isAssetUrl(String url) {
    return url.startsWith('asset://') || !url.contains('://');
  }

  Widget _buildNetworkImage(String url, double size) {
    return Image.network(
      url,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return _buildFallbackText(size);
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          width: size,
          height: size,
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 1.4,
            ),
          ),
        );
      },
    );
  }

  Widget _buildAssetImage(String url, double size) {
    final assetPath =
        url.startsWith('asset://') ? url.replaceFirst('asset://', '') : url;
    return Image.asset(
      assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return _buildFallbackText(size);
      },
    );
  }

  Widget _buildFallbackText(double size) {
    final effectiveStyle =
        textStyle?.copyWith(fontSize: size) ?? TextStyle(fontSize: size);
    return Text(
      emoji.emoji.isNotEmpty ? emoji.emoji : '🙂',
      style: effectiveStyle,
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_TrianglePainter oldDelegate) =>
      color != oldDelegate.color;
}
