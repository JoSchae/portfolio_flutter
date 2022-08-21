// To parse this JSON data, do
//
//     final projects = projectsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Projects projectsFromJson(String str) => Projects.fromJson(json.decode(str));

String projectsToJson(Projects data) => json.encode(data.toJson());

class Projects {
  Projects({
    required this.projects,
  });

  List<Project> projects;

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
        projects: List<Project>.from(
            json["projects"].map((x) => Project.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "projects": List<dynamic>.from(projects.map((x) => x.toJson())),
      };
}

class Project {
  Project({
    required this.projectTitle,
    required this.skills,
    required this.description,
    required this.company,
    required this.roles,
  });

  String projectTitle;
  List<Skill> skills;
  String description;
  String company;
  List<String> roles;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        projectTitle: json["projectTitle"],
        skills: List<Skill>.from(json["skills"].map((x) => Skill.fromJson(x))),
        description: json["description"],
        company: json["company"],
        roles: List<String>.from(json["roles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "projectTitle": projectTitle,
        "skills": List<dynamic>.from(skills.map((x) => x.toJson())),
        "description": description,
        "company": company,
        "roles": List<dynamic>.from(roles.map((x) => x)),
      };
}

class Skill {
  Skill({
    required this.name,
    required this.proficiency,
    required this.experience,
  });

  String name;
  String proficiency;
  int experience;

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        name: json["name"],
        proficiency: json["proficiency"],
        experience: json["experience"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "proficiency": proficiency,
        "experience": experience,
      };
}
