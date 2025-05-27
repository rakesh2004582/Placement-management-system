package com.example.Registration.EmployeeController;

import com.example.Registration.Dto.EmployeeDTO;
import com.example.Registration.Service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;



@RestController
@CrossOrigin
@RequestMapping("api/employee")
public class EmployeeController {

        @Autowired
        private EmployeeService employeeService;

        @PostMapping(path = "/save")
        public String saveEmployee (@RequestBody EmployeeDTO employeeDTO){

            String id = employeeService.addEmployee(employeeDTO);
            return id;
        }

    }

