//package com.example.Student;
//
//import java.io.*;
//import javax.servlet.*;
//import javax.servlet.http.*;
//import java.sql.*;
//
//public class StudentLoginServlet extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        response.setContentType("text/html");
//
//        String email = request.getParameter("email");
//        String password = request.getParameter("password");
//System.out.println("Email : "+email);
//System.out.println("Password : "+password);
//        // Validate inputs
//        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
//            request.setAttribute("errorMessage", "Please fill in both email and password.");
//            RequestDispatcher rd = request.getRequestDispatcher("/Student_Login/StudentLogin.jsp");
//            rd.forward(request, response);
//            System.out.println(" inside the null part : ");
//            System.out.println("email : "+email+" password : "+password);
//            return;
//        }
//
//        String url = "jdbc:mysql://localhost:3306/placementManagementSystem";
//        String dbUser = "root";
//        String dbPassword = "123456";
//
//        try {
//            System.out.println("inside the try block");
//            Class.forName("com.mysql.cj.jdbc.Driver");
//            Connection con = DriverManager.getConnection(url, dbUser, dbPassword);
//
//            String sql = "SELECT * FROM student_registration WHERE email = ? AND password = ?";
//            PreparedStatement pst = con.prepareStatement(sql);
//            pst.setString(1, email);
//            pst.setString(2, password);
//
//            ResultSet rs = pst.executeQuery();
//
////            if (rs.next()) {
////                // Login successful, redirect to dashboard
////                System.out.println("inside the dashboard redirect");
////                response.sendRedirect(request.getContextPath() + "/StudentDashboard/studentDashboard.jsp");
////            } 
//            if (rs.next()) {
//            // Login successful, redirect to dashboard
//            System.out.println("Login successful");
//            String targetPath = request.getContextPath() + "/StudentDashboard/studentDashboard.jsp";
//            System.out.println("Redirecting to: " + targetPath);
//            response.sendRedirect(targetPath);
//            
//            HttpSession session = request.getSession();
//            session.setAttribute("studentEmail", email);
//            response.sendRedirect(request.getContextPath() + "/StudentDashboard/studentDashboard.jsp");
//        }
//            else {
//                // Login failed, show alert by forwarding with errorMessage attribute
//                System.out.println("inside the login faild");
//                request.setAttribute("errorMessage", "Invalid email or password.");
//                RequestDispatcher rd = request.getRequestDispatcher("/Student_Login/StudentLogin.jsp");
//                rd.forward(request, response);
//            }
//
//            con.close();
//        } catch (Exception e) {
//            System.out.println("inside the catch block");
//            e.printStackTrace();
//            request.setAttribute("errorMessage", "Server error: " + e.getMessage());
//            RequestDispatcher rd = request.getRequestDispatcher("/Student_Login/StudentLogin.jsp");
//            rd.forward(request, response);
//        }
//    }
//}






package com.example.Student;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class StudentLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        System.out.println("Email : "+email);
        System.out.println("Password : "+password);

        // Validate inputs
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in both email and password.");
            RequestDispatcher rd = request.getRequestDispatcher("/Student_Login/StudentLogin.jsp");
            rd.forward(request, response);
            return;  // Important to stop further processing
        }

        String url = "jdbc:mysql://localhost:3306/placementManagementSystem";
        String dbUser = "root";
        String dbPassword = "123456";

        try {
            System.out.println("inside the try block");
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, dbUser, dbPassword);

            String sql = "SELECT * FROM student_registration WHERE email = ? AND password = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, email);
            pst.setString(2, password);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                // Login successful
                System.out.println("Login successful");

                // Set session attribute BEFORE redirect
                HttpSession session = request.getSession();
                session.setAttribute("studentEmail", email);

                String targetPath = request.getContextPath() + "/StudentDashboard/studentDashboard.jsp";
                System.out.println("Redirecting to: " + targetPath);
                response.sendRedirect(targetPath);

                rs.close();
                pst.close();
                con.close();

                return;  // Stop further processing after redirect
            } else {
                // Login failed
                System.out.println("inside the login failed");
                request.setAttribute("errorMessage", "Invalid email or password.");
                RequestDispatcher rd = request.getRequestDispatcher("/Student_Login/StudentLogin.jsp");
                rd.forward(request, response);
                rs.close();
                pst.close();
                con.close();
                return;
            }

        } catch (Exception e) {
            System.out.println("inside the catch block");
            e.printStackTrace();
            request.setAttribute("errorMessage", "Server error: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/Student_Login/StudentLogin.jsp");
            rd.forward(request, response);
            return;
        }
    }
}

