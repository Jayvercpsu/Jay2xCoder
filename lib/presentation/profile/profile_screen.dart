import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jay2xcoder/presentation/shared/widgets/dev_background.dart';
import 'package:jay2xcoder/presentation/shared/widgets/reference_kit.dart';
import 'package:jay2xcoder/presentation/shared/widgets/stagger_reveal.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    final String name = _nameController.text.trim();
    final String message = _messageController.text.trim();

    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your feedback.')),
      );
      return;
    }

    final Uri uri = Uri(
      scheme: 'mailto',
      path: 'jayver.cpsu@gmail.com',
      queryParameters: <String, String>{
        'subject': 'Jay2xCoder Feedback from ${name.isEmpty ? "User" : name}',
        'body': 'Name: ${name.isEmpty ? "N/A" : name}\n\nMessage:\n$message',
      },
    );

    setState(() {
      _submitting = true;
    });

    final bool opened = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _submitting = false;
    });

    if (!opened) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open email app. Please try again.'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Opening Gmail/Email app...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Stack(
      children: <Widget>[
        const DevBackground(),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const ReferenceTopTitle(title: 'About Jay2xCoder'),
                const SizedBox(height: 18),
                StaggerReveal(
                  index: 0,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 560),
                      child: ReferenceCard(
                        child: Column(
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/illustrations/splash_programming.svg',
                              height: 110,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'About Jay2xCoder',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: ReferencePalette.onSurface(context),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Jay2xCoder helps students learn coding step-by-step.',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: ReferencePalette.onMuted(context),
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: ReferencePalette.surfaceSoft(context),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: ReferencePalette.cardBorder(context),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Send us feedback',
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      color: ReferencePalette.onSurface(
                                        context,
                                      ),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: _nameController,
                                    decoration: const InputDecoration(
                                      hintText: 'Your name',
                                      isDense: true,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: _messageController,
                                    minLines: 4,
                                    maxLines: 6,
                                    decoration: const InputDecoration(
                                      hintText: 'Write your feedback here...',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ReferencePrimaryButton(
                                    label: _submitting
                                        ? 'Submitting...'
                                        : 'Submit via Gmail',
                                    onPressed: _submitting
                                        ? null
                                        : _submitFeedback,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Powered by Jayver Algadipe',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: ReferencePalette.onMuted(context),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
