package com.example.Registration.Dto;

//import javax.validation.constraints.NotBlank;
//import javax.validation.constraints.NotNull;
//import javax.validation.constraints.Size;

//import jakarta.persistence.Column;
//import jakarta.persistence.GeneratedValue;
//import jakarta.persistence.GenerationType;
//import jakarta.persistence.Id;

public class EmployeeDTO {
    private int employeeid;
    private String employeename;
    private String address;
    private long mobile;

    public EmployeeDTO(int employeeid, String employeename, String address,long mobile) {
        this.employeeid = employeeid;
        this.employeename = employeename;
        this.address = address;
        this.mobile = mobile;
    }

    public EmployeeDTO() {
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
        return "EmployeeDTO{" +
                "employeeid=" + employeeid +
                ", employeename='" + employeename + '\'' +
                ", address='" + address + '\'' +
                ", mobile=" + mobile +
                '}';
    }
}
