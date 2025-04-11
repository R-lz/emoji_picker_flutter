import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'utils/custom_emoji_loader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Emoji Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;
  List<CategoryEmoji>? _emojiSet;
  bool _isLoadingEmojis = true;

  @override
  void initState() {
    super.initState();
    _loadEmojis();
  }

  Future<void> _loadEmojis() async {
    final emojis = await CustomEmojiLoader.loadFromAsset('assets/emoji.json');
    if (mounted) {
      setState(() {
        _emojiSet = emojis;
        _isLoadingEmojis = false;
      });
    }
  }

  List<CategoryEmoji> _getEmojiSet(Locale? locale) {
    if (_emojiSet == null || _emojiSet!.isEmpty) {
      return [
        CategoryEmoji(Category.SMILEYS, [
          Emoji('smile', '😊'),
          Emoji('wink', '😉'),
        ])
      ];
    }
    return _emojiSet!;
  }

  Widget _buildEmojiImage(BuildContext context, Emoji emoji) {
    if (emoji.imageUrl != null && emoji.imageUrl!.startsWith('asset://')) {
      final assetPath = emoji.imageUrl!.replaceFirst('asset://', '');
      return Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        child: Image.asset(
          assetPath,
          width: 32,
          height: 32,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Text('🙂', style: TextStyle(fontSize: 24));
          },
        ),
      );
    }
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      child: Text(emoji.emoji, style: const TextStyle(fontSize: 24)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Emoji Example'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Type a message',
                ),
                maxLines: null,
              ),
            ),
          ),
          if (emojiShowing)
            SizedBox(
              height: 456,
              child: _isLoadingEmojis
                  ? const SizedBox(
                      height: 456,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : EmojiPicker(
                      onEmojiSelected: (category, emoji) {
                        _onEmojiSelected(emoji);
                      },
                      config: Config(
                        height: 456,
                        emojiSet: _getEmojiSet,
                        checkPlatformCompatibility: false,
                        emojiViewConfig: const EmojiViewConfig(
                          columns: 5,
                          emojiSizeMax: 42.0,
                          verticalSpacing: 0,
                          horizontalSpacing: 0,
                          backgroundColor: Color(0xFFF2F2F2),
                        ),
                        categoryViewConfig: const CategoryViewConfig(
                          initCategory: Category.SMILEYS,
                          indicatorColor: Colors.blue,
                          iconColor: Colors.grey,
                          iconColorSelected: Colors.blue,
                          backspaceColor: Colors.blue,
                          backgroundColor: Color(0xFFF2F2F2),
                        ),
                        skinToneConfig: const SkinToneConfig(
                          enabled: false,
                          dialogBackgroundColor: Colors.white,
                          indicatorColor: Colors.grey,
                        ),
                        searchViewConfig: const SearchViewConfig(),
                      ),
                    ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            emojiShowing = !emojiShowing;
          });
        },
        child: Icon(
          emojiShowing ? Icons.keyboard : Icons.emoji_emotions,
        ),
      ),
    );
  }

  void _onEmojiSelected(Emoji emoji) {
    if (emoji.imageUrl != null) {
      _controller.text += '[custom_emoji:${emoji.name}]';
    } else {
      _controller.text += emoji.emoji;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
