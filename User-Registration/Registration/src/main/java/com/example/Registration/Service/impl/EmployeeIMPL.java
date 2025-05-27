package com.example.Registration.Service.impl;

import com.example.Registration.Dto.EmployeeDTO;
import com.example.Registration.Entity.Employee;
import com.example.Registration.Repo.EmployeeRepo;
import com.example.Registration.Service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
class EmployeeImpl implements EmployeeService {

    @Autowired
    private EmployeeRepo employeeRepo;

    @Override
    public String addEmployee(EmployeeDTO employeeDTO) {

        Employee employee = new Employee(
                employeeDTO.getEmployeeid(),
                employeeDTO.getEmployeename(),
                employeeDTO.getAddress(),
                employeeDTO.getMobile()
        );
        employeeRepo.save(employee);

        return employee.getEmployeename();
    }
}
