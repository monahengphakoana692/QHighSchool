/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.qacha.model;

public class Grade {
private int gradeId;
private int studentId;
private int subjectId;
private String subjectName; // from joined subject table or assumed name
private double gradeValue;
private String term;
private String academicYear;


public int getGradeId() { return gradeId; }
public void setGradeId(int gradeId) { this.gradeId = gradeId; }

public int getStudentId() { return studentId; }
public void setStudentId(int studentId) { this.studentId = studentId; }

public int getSubjectId() { return subjectId; }
public void setSubjectId(int subjectId) { this.subjectId = subjectId; }

public String getSubjectName() { return subjectName; }
public void setSubjectName(String subjectName) { this.subjectName = subjectName; }

public double getGradeValue() { return gradeValue; }
public void setGradeValue(double gradeValue) { this.gradeValue = gradeValue; }

public String getTerm() { return term; }
public void setTerm(String term) { this.term = term; }

public String getAcademicYear() { return academicYear; }
public void setAcademicYear(String academicYear) { this.academicYear = academicYear; }
}