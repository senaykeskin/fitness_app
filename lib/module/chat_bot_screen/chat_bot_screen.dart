import 'package:flutter/material.dart';
import 'index.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  final BehaviorSubject<List<Map<String, String>>> _messageStream =
      BehaviorSubject<List<Map<String, String>>>.seeded([]);

  final BehaviorSubject<bool> _isBotReady = BehaviorSubject<bool>.seeded(false);

  @override
  void initState() {
    super.initState();

    _addMessage({"sender": "ai", "text": "..."});

    Future.delayed(const Duration(milliseconds: 1500), () {
      _updateLastMessage(
          "Hoş geldiniz, ben dijital asistanınız. Sizin için ne yapabilirim? 😊");
      _isBotReady.add(true);
    });
  }

  void _addMessage(Map<String, String> message) {
    final current = _messageStream.value;
    _messageStream.add([...current, message]);
    _scrollToBottom();
  }

  void _updateLastMessage(String newText) {
    final current = _messageStream.value;
    if (current.isNotEmpty) {
      final updated = [...current];
      updated.removeLast();
      updated.add({"sender": "ai", "text": newText});
      _messageStream.add(updated);
      _scrollToBottom();
    }
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    _isBotReady.add(false);

    _addMessage({"sender": "user", "text": text});
    _addMessage({"sender": "ai", "text": "..."});

    _controller.clear();
    _focusNode.unfocus();

    Future.delayed(const Duration(milliseconds: 1500), () {
      _updateLastMessage("Henüz bir servise bağlı değilim 😓");

      _isBotReady.add(true);
    });
  }

  void _sendPredefinedQuestion(String question) {
    final answer = botAnswerList[question] ?? "Yanıt bulunamadı.";

    _isBotReady.add(false);

    _addMessage({"sender": "user", "text": question});
    _addMessage({"sender": "ai", "text": "..."});

    Future.delayed(const Duration(milliseconds: 1500), () {
      _updateLastMessage(answer);

      _isBotReady.add(true);
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _messageStream.close();
    _isBotReady.close();
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final predefinedQuestions = botAnswerList.keys.toList();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: customAppBar(context, "Yapay Zeka Asistanı"),
        body: Padding(
          padding: horizontal10 + top10,
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<Map<String, String>>>(
                  stream: _messageStream.stream,
                  builder: (context, snapshot) {
                    final messages = snapshot.data ?? [];
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) =>
                          messageContainer(context, messages[index]),
                    );
                  },
                ),
              ),
              StreamBuilder<bool>(
                stream: _isBotReady.stream,
                builder: (context, snapshot) {
                  final isReady = snapshot.data ?? false;

                  return SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: predefinedQuestions.length,
                      itemBuilder: (context, index) {
                        final question = predefinedQuestions[index];
                        return Container(
                          margin: vertical5 + horizontal5,
                          child: ElevatedButton(
                            onPressed: isReady
                                ? () => _sendPredefinedQuestion(question)
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isReady
                                  ? GlobalConfig.primaryColor
                                  : Colors.grey.shade200,
                              foregroundColor: Colors.black87,
                              elevation: 2,
                              padding: horizontal10,
                              shape: RoundedRectangleBorder(
                                borderRadius: border25,
                              ),
                            ),
                            child: Text(
                              question,
                              style: kAxiformaRegular17.copyWith(
                                  fontSize: 13, color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: bottom5,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: kAxiformaRegular17.copyWith(fontSize: 14),
                        controller: _controller,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          hintStyle: kAxiformaRegular17.copyWith(fontSize: 14),
                          hintText: "Mesajınızı yazın...",
                          border: OutlineInputBorder(
                            borderRadius: border10,
                          ),
                        ),
                        onSubmitted: _sendMessage,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: GlobalConfig.primaryColor,
                      ),
                      onPressed: () => _sendMessage(_controller.text),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
