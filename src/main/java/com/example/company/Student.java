package com.example.company;

public class Student {
    private String name;
    private float tenth;
    private float twelfth;
    private float higherEducation;

    public Student(String name, float tenth, float twelfth, float higherEducation) {
        this.name = name;
        this.tenth = tenth;
        this.twelfth = twelfth;
        this.higherEducation = higherEducation;
    }

    public String getName() { return name; }
    public float getTenth() { return tenth; }
    public float getTwelfth() { return twelfth; }
    public float getHigherEducation() { return higherEducation; }
}
