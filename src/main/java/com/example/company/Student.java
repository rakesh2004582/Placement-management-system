package com.example.company;

public class Student {
    private String name;
    private float tenth;
    private float twelfth;
    private float higherEducation;
    private String contact;

    public Student(String name, float tenth, float twelfth, float higherEducation,String contact) {
        this.name = name;
        this.tenth = tenth;
        this.twelfth = twelfth;
        this.higherEducation = higherEducation;
        this.contact=contact;
    }

    public String getName() { return name; }
    public float getTenth() { return tenth; }
    public float getTwelfth() { return twelfth; }
    public float getHigherEducation() { return higherEducation; }
    public String getContact() {return contact;}
}
