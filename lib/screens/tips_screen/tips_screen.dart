// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({super.key});

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  int? _selectedTipIndex;

  final List<Map<String, dynamic>> _tips = [
    {
      'title': 'Why You Should Regularly Update Your Passwords',
      'duration': '~5 minutes of reading',
      'content': [
        'Changing your passwords every few months significantly reduces the chances of unauthorized access to your accounts.',
        'Cybercriminals often rely on users reusing the same passwords across different services.',
        'By updating regularly and using unique, strong combinations, you protect your identity and sensitive data.',
      ],
      'url': 'https://www.cisa.gov/news-events/news/password-tips',
    },
    {
      'title': 'How Two-Factor Authentication Keeps You Safer',
      'duration': '~5 minutes of reading',
      'content': [
        'Two-Factor Authentication (2FA) adds a second step to the login process—like a code sent to your phone or email.',
        'Even if someone gets your password, they can’t access your account without that second code.',
        'It\'s one of the simplest and most effective tools for increasing your account security.',
      ],
      'url':
          'https://www.ncsc.gov.uk/guidance/setting-two-factor-authentication-2fa',
    },
    {
      'title': 'Spotting Phishing: What to Watch For',
      'duration': '~5 minutes of reading',
      'content': [
        'Phishing emails are designed to trick you into clicking malicious links or sharing personal information.',
        'Look for signs like poor grammar, unfamiliar sender addresses, and urgent demands.',
        'If anything feels off—don’t click.',
      ],
      'url':
          'https://consumer.ftc.gov/articles/how-recognize-and-avoid-phishing-scams',
    },
    {
      'title': 'Use a Password Manager',
      'duration': '~3 minutes of reading',
      'content': [
        'Password managers generate and store strong, unique passwords for each account.',
        'You only need to remember one master password.',
      ],
      'url':
          'https://www.consumerreports.org/digital-security/password-managers-a5424341464/',
    },
    {
      'title': 'Keep Your Software Up to Date',
      'duration': '~4 minutes of reading',
      'content': [
        'Outdated software may contain security vulnerabilities.',
        'Enable automatic updates to keep your system protected.',
      ],
      'url': 'https://us-cert.cisa.gov/ncas/tips/ST04-006',
    },
    {
      'title': 'Avoid Public Wi-Fi for Sensitive Transactions',
      'duration': '~4 minutes of reading',
      'content': [
        'Public Wi-Fi networks are often insecure.',
        'Avoid logging into banking or email accounts unless you use a VPN.',
      ],
      'url':
          'https://www.consumer.ftc.gov/articles/how-safely-use-public-wi-fi-networks',
    },
    {
      'title': 'Don’t Overshare on Social Media',
      'duration': '~3 minutes of reading',
      'content': [
        'Hackers can use personal info (like your pet’s name or birthday) to guess your passwords or answer security questions.',
      ],
      'url':
          'https://staysafeonline.org/blog/how-to-stay-safe-on-social-media/',
    },
    {
      'title': 'Recognize Secure Websites',
      'duration': '~2 minutes of reading',
      'content': [
        'Before entering sensitive info, check for HTTPS in the URL and a padlock icon.',
        'This ensures the site uses encryption.',
      ],
      'url':
          'https://www.kaspersky.com/resource-center/preemptive-safety/what-is-a-secure-website',
    },
    {
      'title': 'Back Up Your Data Regularly',
      'duration': '~3 minutes of reading',
      'content': [
        'Use cloud or offline backups to protect important files in case of ransomware or device failure.',
      ],
      'url': 'https://www.cisa.gov/news-events/news/back-your-data',
    },
    {
      'title': 'Be Cautious With Email Attachments',
      'duration': '~3 minutes of reading',
      'content': [
        'Do not open unexpected attachments, even from known contacts.',
        'Verify before clicking.',
      ],
      'url':
          'https://www.ncsc.gov.uk/guidance/email-security-and-anti-spoofing',
    },
    {
      'title': 'Check App Permissions on Mobile Devices',
      'duration': '~4 minutes of reading',
      'content': [
        'Some apps request access to contacts, microphone, or location unnecessarily.',
        'Review and limit permissions regularly.',
      ],
      'url': 'https://www.kaspersky.com/blog/app-permissions-guide/27033/',
    },
    {
      'title': 'Log Out on Shared Devices',
      'duration': '~2 minutes of reading',
      'content': [
        'Always sign out of accounts on shared or public computers to prevent unauthorized access.',
      ],
      'url':
          'https://www.digitaltrends.com/computing/how-to-sign-out-of-your-google-account/',
    },
    {
      'title': 'Enable Find My Device Features',
      'duration': '~3 minutes of reading',
      'content': [
        'Turn on location and remote lock features for your phone or laptop.',
        'Helps recover the device or wipe it remotely if lost or stolen.',
      ],
      'url': 'https://support.google.com/android/answer/6160491?hl=en',
    },
  ];

  void _shareTip(String title, String url) {
    Share.share('$title\n$url');
  }

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.only(top: 190),
          child:
              _selectedTipIndex == null
                  ? ListView.builder(
                    itemCount: _tips.length,
                    padding: const EdgeInsets.only(bottom: 160),
                    itemBuilder: (context, index) {
                      final tip = _tips[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF101A30),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    tip['title'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Icon(
                                  Icons.verified,
                                  size: 16,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              tip['duration'],
                              style: const TextStyle(color: Colors.white60),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFF6A00),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed:
                                        () => setState(
                                          () => _selectedTipIndex = index,
                                        ),
                                    child: const Text(
                                      'Read now',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Colors.white24,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed:
                                        () =>
                                            _shareTip(tip['title'], tip['url']),
                                    child: const Text(
                                      'Share',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                  : _buildDetailView(_tips[_selectedTipIndex!]),
        ),
      ),
    );
  }

  Widget _buildDetailView(Map<String, dynamic> tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        padding: const EdgeInsets.only(bottom: 120),
        children: [
          GestureDetector(
            onTap: () => setState(() => _selectedTipIndex = null),
            child: Align(
              alignment: Alignment.centerLeft,
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  tip['title'],
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.verified, size: 16, color: Colors.blue),
            ],
          ),
          const SizedBox(height: 12),
          Text(tip['duration'], style: const TextStyle(color: Colors.white60)),
          const SizedBox(height: 20),
          ...tip['content'].map<Widget>(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                t,
                style: const TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(FontAwesomeIcons.link, color: Colors.black),
                  label: const Text(
                    'Source',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BBFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => _openUrl(tip['url']),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _shareTip(tip['title'], tip['url']),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Share',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
