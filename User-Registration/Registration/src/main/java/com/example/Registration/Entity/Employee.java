package com.example.Registration.Entity;

import jakarta.persistence.*;

//import javax.persistence.*;

@Entity
@Table(name="employee")
public class  Employee {

    @Id
    @Column(name="employee_id",length=45)
    @GeneratedValue(strategy = GenerationType.AUTO)
  private int employeeid;

    @Column(name="employee_name",length = 255)
  private String employeename;

    @Column(name="address",length = 255)
  private String address;

    @Column(name="mobile",length = 10)
  private long mobile;

    public Employee(int employeeid,String employeename, String address,long mobile ) {
        this.employeeid = employeeid;
        this.employeename = employeename;
        this.address = address;
        this.mobile = mobile;
    }
    public Employee() {

    }

    public int getEmployeeid() {
        return employeeid;
    }

    public void setEmployeeid(int employeeid) {
        this.employeeid = employeeid;
    }

    public String getEmployeename() {
        return employeename;
    }

    public void setEmployeename(String employeename) {
        this.employeename = employeename;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public long getMobile() {
        return mobile;
    }

    public void setMobile(long mobile) {
        this.mobile = mobile;
    }


    @Override
    public String toString() {
        return "Employee{" +
                "employeeid=" + employeeid +
                ", employeename='" + employeename + '\'' +
                ", address='" + address + '\'' +
                ", mobile=" + mobile +
                '}';
    }
}

