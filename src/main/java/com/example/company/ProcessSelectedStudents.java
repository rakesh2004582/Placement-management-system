package com.example.company;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.sql.*;

public class ProcessSelectedStudents extends HttpServlet {

    List<String> selectedList = new ArrayList<>();
    List<String> deletedList = new ArrayList<>();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("Process student called");

        String[] selected = request.getParameterValues("selectedStudents");
        String[] deleted = request.getParameterValues("deletedStudents");
        String submit = request.getParameter("submitAction");
        String company = request.getParameter("companyname");

        // Add selected students to list
        if (selected != null) {
            selectedList.addAll(Arrays.asList(selected));
        }

        // Add deleted students to list
        if (deleted != null) {
            deletedList.addAll(Arrays.asList(deleted));
        }

        if ("submitAll".equals(submit)) {
            Connection con = null;
            PreparedStatement ps = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/placementmanagementsystem", "root", "123456");

                System.out.println("Database connection established.");
                System.out.println("Number of selected students: " + selectedList.size());

                for (String s : selectedList) {
                    String[] parts = s.split("\\|");
                    String name = parts[0];
                    String contact = parts[1];

                    // Check for duplicate
                    PreparedStatement checkStmt = con.prepareStatement(
                        "SELECT COUNT(*) FROM selectedstudent WHERE name = ? AND mob = ? AND companyname = ?");
                    checkStmt.setString(1, name);
                    checkStmt.setString(2, contact);
                    checkStmt.setString(3, company);

                    ResultSet rs = checkStmt.executeQuery();
                    rs.next();
                    int count = rs.getInt(1);
                    rs.close();
                    checkStmt.close();

                    if (count == 0) {
                        // Insert only if not duplicate
                        ps = con.prepareStatement(
                            "INSERT INTO selectedstudent (name, mob, companyname) VALUES (?, ?, ?)");
                        ps.setString(1, name);
                        ps.setString(2, contact);
                        ps.setString(3, company);
                        ps.executeUpdate();
                        ps.close();
                        System.out.println("Inserted student: " + name + " - " + contact);
                    } else {
                        System.out.println("Duplicate found, skipping: " + name + " - " + contact);
                    }
                }

                // Clear lists after processing
                selectedList.clear();
                deletedList.clear();

                // Forward to selected.jsp with company name
                request.setAttribute("company", company);
                RequestDispatcher rd = request.getRequestDispatcher("selected.jsp");
                rd.forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Error: " + e.getMessage());
            } finally {
                try {
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
        }
    }
}



//
//
//package com.example.company;
//
//import javax.servlet.*;
//import javax.servlet.http.*;
//import java.io.*;
//import java.util.*;
//import java.sql.*;
//
//public class ProcessSelection extends HttpServlet {
//    private static final List<String> selectedList = new ArrayList<>();
//    private static final List<String> deletedList = new ArrayList<>();
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//        throws ServletException, IOException {
//
//        String selected = request.getParameter("select");
//        String deleted = request.getParameter("delete");
//        String submit = request.getParameter("submitAction");
//        String company = request.getParameter("company");
//
//        if (selected != null) {
//            selectedList.add(selected);
//        }
//
//        if (deleted != null) {
//            deletedList.add(deleted);
//        }
//
//        if ("submitAll".equals(submit)) {
//            try {
//                Class.forName("com.mysql.cj.jdbc.Driver");
//                Connection con = DriverManager.getConnection(
//                        "jdbc:mysql://localhost:3306/yourdb", "root", "123456");
//
//                for (String s : selectedList) {
//                    String[] parts = s.split("\\|");
//                    String name = parts[0];
//                    String contact = parts[1];
//
//                    PreparedStatement ps = con.prepareStatement(
//                        "INSERT INTO selectedstudent (name, mob, companyname) VALUES (?, ?, ?)");
//                    ps.setString(1, name);
//                    ps.setString(2, contact);
//                    ps.setString(3, company);
//                    ps.executeUpdate();
//                }
//
//                for (String d : deletedList) {
//                    String[] parts = d.split("\\|");
//                    String name = parts[0];
//                    String contact = parts[1];
//
//                    PreparedStatement ps = con.prepareStatement(
//                        "DELETE FROM eligible_students WHERE name = ? AND contact = ? AND company = ?");
//                    ps.setString(1, name);
//                    ps.setString(2, contact);
//                    ps.setString(3, company);
//                    ps.executeUpdate();
//                }
//
//                con.close();
//                selectedList.clear();
//                deletedList.clear();
//
//                // forward to selected students page
//                request.setAttribute("company", company);
//                RequestDispatcher rd = request.getRequestDispatcher("selected.jsp");
//                rd.forward(request, response);
//
//            } catch (Exception e) {
//                e.printStackTrace();
//                response.getWriter().println("Error: " + e.getMessage());
//            }
//        }
//    }
//}
//
