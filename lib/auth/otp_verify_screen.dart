import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Screens/dashboard_screen.dart';
import '../utils/AppColors.dart';

class OtpVerifyScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerifyScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  _OtpVerifyScreenState createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen>
    with SingleTickerProviderStateMixin {
  final List<TextEditingController> _controllers =
  List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isResending = false;
  int _resendTimer = 30;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
        _startResendTimer();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onOtpDigitChanged(int index, String value) {
    if (value.length == 1) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        // Verify OTP here
        final otp = _controllers.map((c) => c.text).join();
        print('Complete OTP: $otp');
      }
    }
  }

  Widget _buildOtpDigitField(
      BuildContext context, int index, double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.13,
      height: screenWidth * 0.13,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: screenWidth * 0.06,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          counterText: '',
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) => _onOtpDigitChanged(index, value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final isKeyboardOpen = mediaQuery.viewInsets.bottom > 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.06,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!isKeyboardOpen) ...[
                        SizedBox(height: screenHeight * 0.02),
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Container(
                            height: screenHeight * 0.15,
                            width: screenHeight * 0.15,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primary.withOpacity(0.8),
                                  AppColors.secondary,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.lock_outline_rounded,
                              size: screenWidth * 0.12,
                              color: AppColors.textLight,
                            ),
                          ),
                        ),
                      ],
                      SizedBox(height: screenHeight * 0.04),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          'OTP Verification',
                          style: TextStyle(
                            color: AppColors.headingPrimary,
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'Enter the verification code we sent to',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        widget.phoneNumber,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          4,
                              (index) => _buildOtpDigitField(
                            context,
                            index,
                            screenWidth,
                            screenHeight,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      ElevatedButton(
                        onPressed: () {
                          final otp = _controllers.map((c) => c.text).join();
                          if (otp.length == 4) {
                            // Handle verification here
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const DashboardScreen()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.12,
                            vertical: screenHeight * 0.015,
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          'Verify',
                          style: TextStyle(
                            color: AppColors.textLight,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive the code? ",
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                          _resendTimer > 0
                              ? Text(
                            'Resend in ${_resendTimer}s',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                              : TextButton(
                            onPressed: _isResending
                                ? null
                                : () {
                              setState(() {
                                _isResending = true;
                                _resendTimer = 30;
                              });
                              // Handle resend logic here
                              Future.delayed(
                                const Duration(seconds: 2),
                                    () {
                                  if (mounted) {
                                    setState(() {
                                      _isResending = false;
                                    });
                                    _startResendTimer();
                                  }
                                },
                              );
                            },
                            child: Text(
                              'Resend',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}