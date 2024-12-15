import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpConnector {
  final String baseUrl = 'http://localhost:6969/students';


  Future<Map<String, dynamic>> getStudentByRegNo(String regNo) async {
    final url = Uri.parse('$baseUrl/Student/$regNo');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to fetch student. HTTP Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching student: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllStudents() async {
    final url = Uri.parse('$baseUrl/Student/all');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        throw Exception('Failed to fetch all students. HTTP Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching all students: $e');
    }
  }

  Future<Map<String, dynamic>> createStudent(Map<String, dynamic> studentData) async {
    final url = Uri.parse('$baseUrl/create');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(studentData),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to create student. HTTP Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating student: $e');
    }
  }

  Future<String> deleteStudent(String regNo) async {
    final url = Uri.parse('$baseUrl/delete/$regNo');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to delete student. HTTP Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting student: $e');
    }
  }

  Future<Map<String, dynamic>> updateStudent(String regNo, Map<String, dynamic> studentData) async {
    final url = Uri.parse('$baseUrl/Student/update/$regNo');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(studentData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to update student. HTTP Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating student: $e');
    }
  }

  Future<Map<String, dynamic>> addSubjectToStudent(String regNo, Map<String, dynamic> subjectData) async {
    final url = Uri.parse('$baseUrl/Student/$regNo/addSubject');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(subjectData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to add subject to student. HTTP Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding subject to student: $e');
    }
  }

  Future<Map<String, dynamic>> updateSubjectDetails(String regNo, String subjectCode, Map<String, dynamic> subjectData) async {
    final url = Uri.parse('$baseUrl/Student/$regNo/Subject/$subjectCode');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(subjectData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to update subject. HTTP Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating subject: $e');
    }
  }

  Future<Map<String, dynamic>> addClassToSubject(String regNo, String subjectCode, String classDate, Map<String, dynamic> attendHrData) async {
    final url = Uri.parse('$baseUrl/add-class/$regNo/$subjectCode/$classDate');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(attendHrData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to add class to subject. HTTP Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding class to subject: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchStudentSubjects(String regNo) async {
    final url = Uri.parse('$baseUrl/Student/$regNo/subjects');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        throw Exception('Failed to fetch student subjects. HTTP Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching student subjects: $e');
    }
  }

  Future<bool> validatePassword(String regno, Map<String, dynamic> student) async {
    final url = Uri.parse('$baseUrl/Student/validateLogin/$regno');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(student),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (e) {
      print('Error validating password: $e');
      return false;
    }
  }

  Future<String> deleteSubject(String regNo, String code) async{
    final url = Uri.parse('$baseUrl/delete/$regNo/subject/$code');

    try{

      final response = await http.delete(url);
      if(response.statusCode == 200){
        return response.body;
      }
      else {
        throw Exception('Failed to delete subject. HTTP Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting subject: $e');
    }

  }

  Future<bool> deleteClass(String regNo, String code, String date) async{
    final url = Uri.parse('$baseUrl/Student/$regNo/subject/$code/class/$date');
    try{
      final response = await http.delete(url);
      if(response.statusCode == 200){
        return true;
      }
      else{
        return false;
      }
    }
    catch(e){
      throw Exception("Dubug:$e");
    }
  }

  Future<Map<String, dynamic>> getSubjectByCode(String regno, String subCode) async {
    final url = Uri.parse('$baseUrl/Student/$regno/subject/$subCode');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        // If the server does not return a 200 OK response, throw an error
        throw Exception('Failed to load subject data');
      }
    } catch (e) {
      // Handle any exceptions
      throw Exception('Error: $e');
    }
  }
}
