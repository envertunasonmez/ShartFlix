import '../services/profile_service.dart';
import '../models/user_profile_response_model.dart';

class ProfileRepository {
  final ProfileService _profileService;

  ProfileRepository(this._profileService);

  Future<UserProfileResponseModel> getProfile() async {
    try {
      return await _profileService.getProfile();
    } catch (e) {
      throw Exception('Failed to get profile: $e');
    }
  }

  Future<UserProfileResponseModel> updateProfile(Map<String, dynamic> data) async {
    try {
      return await _profileService.updateProfile(data);
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}