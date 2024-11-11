import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() {
  runApp(const MaterialApp(
    home: PasswordGenerator(),
    debugShowCheckedModeBanner: false,  
  ));
}

class PasswordGenerator extends StatefulWidget {
  const PasswordGenerator({super.key});

  @override
  State<PasswordGenerator> createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  String generatedPassword = 'sZBosL13JMEj';
  double passwordLength = 12;
  bool includeUppercase = true;
  bool includeLowercase = true;
  bool includeNumbers = true;
  bool includeSymbols = false;

  void generatePassword() {
    const String uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String lowercase = 'abcdefghijklmnopqrstuvwxyz';
    const String numbers = '0123456789';
    const String symbols = '!@#\$%^&*()_+-=[]{}|;:,.<>?';

    String chars = '';
    if (includeUppercase) chars += uppercase;
    if (includeLowercase) chars += lowercase;
    if (includeNumbers) chars += numbers;
    if (includeSymbols) chars += symbols;


    if (chars.isEmpty) {
      chars = lowercase;
      setState(() => includeLowercase = true);
    }

    Random rnd = Random.secure();
    String result = '';
    for (int i = 0; i < passwordLength.round(); i++) {
      result += chars[rnd.nextInt(chars.length)];
    }

    setState(() {
      generatedPassword = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2A2A3F), Color(0xFF1F1F2E)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Generate password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          generatedPassword,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy, color: Colors.purple),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: generatedPassword));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Password copied!')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Character Length',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      passwordLength.round().toString(),
                      style: const TextStyle(
                        color: Colors.purple,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: passwordLength,
                  min: 12,
                  max: 32,
                  divisions: 20,
                  activeColor: Colors.purple,
                  inactiveColor: Colors.purple.withOpacity(0.2),
                  onChanged: (value) {
                    setState(() {
                      passwordLength = value;
                      generatePassword();  
                    });
                  },
                ),
                const SizedBox(height: 20),
                buildSwitch('Include uppercase letters', includeUppercase, (value) {
                  setState(() {
                    includeUppercase = value;
                    generatePassword();  
                  });
                }),
                buildSwitch('Include lowercase letters', includeLowercase, (value) {
                  setState(() {
                    includeLowercase = value;
                    generatePassword();  
                  });
                }),
                buildSwitch('Include numbers', includeNumbers, (value) {
                  setState(() {
                    includeNumbers = value;
                    generatePassword();  
                  });
                }),
                buildSwitch('Include symbols', includeSymbols, (value) {
                  setState(() {
                    includeSymbols = value;
                    generatePassword();  
                  });
                }),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: generatePassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Generate Password',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSwitch(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.purple,
            activeTrackColor: Colors.purple.withOpacity(0.5),
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
