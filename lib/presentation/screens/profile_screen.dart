import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habix/presentation/UIModels/userProfileUI.dart';
import 'package:habix/presentation/providers/profile_screen.dart';
import 'package:habix/presentation/providers/user_profile.dart';
import 'package:habix/presentation/screens/user_profile.dart';
import 'package:habix/utilities/enums.dart';
import 'package:habix/utilities/extensions.dart';
import 'package:habix/utilities/shimmer_animation.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late Map<String, dynamic> _params;
  late UserProfileUIModel _userProfileUI;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _params = ref.watch(profileScreenNotifier);
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfileScreen'),
        actions: [TextButton(onPressed: () 
        {
          
          
    ref.read(userProfileScreenNotifier.notifier).changeGender(_params['profile']?.gender ?? Gender.MALE);
    ref.read(userProfileScreenNotifier.notifier).changeDOB(_params['profile']?.dob ?? DateTime.now());

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserProfile(userProfileUIModel: _params['profile'] as UserProfileUIModel,)),
          );
          
        }, child: Text('Edit'))],
      ),
      body: _params['loading']
          ? ShimmerAnimation.listPlaceholder()
          : LayoutBuilder(
              builder: (context, constraints) {
                _userProfileUI = _params['profile'] as UserProfileUIModel;

                return _portrait(); // _ProfilescreenWidth>maxProfileScreenSizeInPortraitMode?_landscape():_portrait();
              },
            ),
    );
  }

  Widget _landscape() {
    return _portrait();
  }

  Widget _portrait() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.lightBlue,
                    const Color.fromARGB(255, 0, 4, 244),
                  ],
                ),
              ),
              child: Text(
                '${_userProfileUI.firstName} ${_userProfileUI.lastName}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 100,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Colors.lightGreen,
                            const Color.fromARGB(255, 194, 228, 0),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Age',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _userProfileUI.age.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 100,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Colors.red,
                            const Color.fromARGB(255, 245, 153, 153),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'DOB',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${_userProfileUI.dob.day} ${_userProfileUI.dob.month.monthInAlphabets} ${_userProfileUI.dob.year}',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 100,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Colors.deepPurple, Colors.purpleAccent],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Weight',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${_userProfileUI.weight} kg',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 100,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [Colors.teal, Colors.tealAccent],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Height',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${_userProfileUI.height} cm',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                                height: 100,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.brown, Colors.brown.withValues(alpha: 0.3)],
                  ),
                                ),
                                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Gender',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _userProfileUI.gender.name.capitalize,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                                ),
                              ),
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
