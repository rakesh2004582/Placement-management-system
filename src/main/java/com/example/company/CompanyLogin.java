 
package com.example.company;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CompanyLogin extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("POST method called for CompanyLogin");

        String company = request.getParameter("company");
        String password = request.getParameter("password");
System.out.println("Company Name: "+company);

System.out.println("Pass : "+password);

        try {
            System.out.println("Before loading JDBC driver");
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("JDBC driver loaded");

            System.out.println("Before DB connection");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/placementManagementSystem", "root", "123456");
            System.out.println("Connected to DB");

            PreparedStatement ps = con.prepareStatement("SELECT * FROM company_register WHERE companyname=? AND password=?");
            ps.setString(1, company);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                System.out.println("Company credentials matched");

                float tenth = rs.getFloat("tenthpercentage");
                float twelfth = rs.getFloat("twelfthpercentage");
                float higher = rs.getFloat("highereducation_percent");

                HttpSession session = request.getSession();
                session.setAttribute("company", company);

                PreparedStatement ps2 = con.prepareStatement(
                    "SELECT name, tenth_percent, twelfth_percent, grad_percent FROM student_registration WHERE tenth_percent >= ? AND twelfth_percent >= ? AND grad_percent >= ?");
                ps2.setFloat(1, tenth);
                ps2.setFloat(2, twelfth);
                ps2.setFloat(3, higher);
                ResultSet eligibleRs = ps2.executeQuery();

                List<Student> eligibleStudents = new ArrayList<>();
                System.out.println("Fetching eligible students");

                while (eligibleRs.next()) {
                    String name = eligibleRs.getString("name");
                    float t = eligibleRs.getFloat("tenth_percent");
                    float tw = eligibleRs.getFloat("twelfth_percent");
                    float h = eligibleRs.getFloat("grad_percent");

                    Student student = new Student(name, t, tw, h);
                    eligibleStudents.add(student);
                }

                System.out.println("Eligible students fetched: " + eligibleStudents.size());

                request.setAttribute("eligibleStudents", eligibleStudents);
                  request.setAttribute("CompanyName", company);// set company name for showing on the company dash board
                RequestDispatcher rd = request.getRequestDispatcher("/Company/company_dashboard.jsp");
                rd.forward(request, response);

                eligibleRs.close();
                ps2.close();
                rs.close();
                ps.close();
                con.close();

            } else {
                System.out.println("Invalid company credentials");
                System.out.println("Context Path: " + request.getContextPath());

                response.sendRedirect(request.getContextPath() + "/Company/companyLogin.jsp?error=invalid");
            }

        } catch (Exception e) {
            System.out.println("Exception occurred: " + e.getMessage());
            e.printStackTrace();
//            response.sendRedirect("/Company/companyLogin.jsp?error=server");
            System.out.println("Context Path: " + request.getContextPath());

            response.sendRedirect(request.getContextPath() + "/Company/companyLogin.jsp?error=server");

        }
    }
}

