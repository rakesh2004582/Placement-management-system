


package com.example.company;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import javax.servlet.annotation.WebServlet;
import java.util.*;
@WebServlet("/FinalStudent")
public class FinalStudent extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String company = request.getParameter("company");
        request.setAttribute("company", company);
        System.out.println("final Student at + "+company);
        if (company == null || company.trim().isEmpty()) {
            request.setAttribute("message", "Company name is missing.");
            request.getRequestDispatcher("selected.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/placementmanagementsystem", "root", "123456");

            if ("select".equalsIgnoreCase(action)) {
                // Insert selected students into finalplacedstudents with LPA

                String[] selectedStudents = request.getParameterValues("selectedStudents");
                if (selectedStudents == null || selectedStudents.length == 0) {
                    request.setAttribute("message", "No students selected.");
                    request.setAttribute("company", company);
                    request.getRequestDispatcher("selected.jsp").forward(request, response);
                    con.close();
                    return;
                }

                List<String> duplicateList = new ArrayList<>();

                for (String data : selectedStudents) {
                    String[] parts = data.split("::");
                    if (parts.length < 2) continue;

                    String name = parts[0].trim();
                    String mob = parts[1].trim();

                    // Get LPA from form input: lpa_<name>_<mob>
                    String lpaParam = "lpa_" + name + "_" + mob;
                    String lpaStr = request.getParameter(lpaParam);
                    double lpa = 0.0;
                    try {
                        lpa = Double.parseDouble(lpaStr);
                    } catch (NumberFormatException e) {
                        lpa = 0.0;
                    }

                    // Check for duplicate in finalplacedstudents
                    PreparedStatement checkStmt = con.prepareStatement(
                        "SELECT COUNT(*) FROM finalplacedstudents WHERE name = ? AND mob = ? AND companyname = ?"
                    );
                    checkStmt.setString(1, name);
                    checkStmt.setString(2, mob);
                    checkStmt.setString(3, company);

                    ResultSet rs = checkStmt.executeQuery();
                    rs.next();
                    int count = rs.getInt(1);
                    rs.close();
                    checkStmt.close();

                    if (count > 0) {
                        duplicateList.add(name + " (Mob: " + mob + ")");
                        continue;
                    }

                    // Insert into finalplacedstudents
                    PreparedStatement insertStmt = con.prepareStatement(
                        "INSERT INTO finalplacedstudents (name, mob, companyname, lpa) VALUES (?, ?, ?, ?)"
                    );
                    insertStmt.setString(1, name);
                    insertStmt.setString(2, mob);
                    insertStmt.setString(3, company);
                    insertStmt.setDouble(4, lpa);

                    insertStmt.executeUpdate();
                    insertStmt.close();
                }

                con.close();
                if (duplicateList.isEmpty()) {
                	request.setAttribute("company", company);
                	System.out.println("Selected Student is "+company+"done");
                    // Redirect to final placed students list page
                    response.sendRedirect("companyfinalstudent.jsp?company=" + company);
                } else {
                    request.setAttribute("message", "These students already exist: " + String.join(", ", duplicateList));
                    request.setAttribute("company", company);
                    request.getRequestDispatcher("selected.jsp").forward(request, response);
                }
                return;

            } else if ("delete".equalsIgnoreCase(action)) {
                // Delete selected students from selectedstudent table

                String[] selectedStudents = request.getParameterValues("selectedStudents");
                if (selectedStudents == null || selectedStudents.length == 0) {
                    request.setAttribute("message", "No students selected for deletion.");
                    request.setAttribute("company", company);
                    request.getRequestDispatcher("selected.jsp").forward(request, response);
                    con.close();
                    return;
                }

                PreparedStatement deleteStmt = con.prepareStatement(
                    "DELETE FROM selectedstudent WHERE name = ? AND mob = ? AND companyname = ?"
                );

                for (String data : selectedStudents) {
                    String[] parts = data.split("::");
                    if (parts.length < 2) continue;

                    String name = parts[0].trim();
                    String mob = parts[1].trim();

                    deleteStmt.setString(1, name);
                    deleteStmt.setString(2, mob);
                    deleteStmt.setString(3, company);

                    deleteStmt.executeUpdate();
                }
                deleteStmt.close();
                con.close();

                request.setAttribute("message", "Selected students deleted successfully.");
                request.setAttribute("company", company);
                request.getRequestDispatcher("selected.jsp").forward(request, response);
            } else {
                // Unknown action
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unknown action: " + action);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("company", company);
            request.getRequestDispatcher("selected.jsp").forward(request, response);
        }
    }
}

//
//import java.io.IOException;
//import java.sql.*;
//import java.util.ArrayList;
//import java.util.List;
//
//import javax.servlet.RequestDispatcher;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//
//@WebServlet("/FinalStudent")
//public class FinalStudent extends HttpServlet {
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String[] selectedStudents = request.getParameterValues("selectedStudents");
//        String action = request.getParameter("action");
//        String company = request.getParameter("company");
//
//        response.setContentType("text/html");
//        java.io.PrintWriter out = response.getWriter();
//
//        if (selectedStudents == null || selectedStudents.length == 0) {
//            request.setAttribute("message", "No students selected!");
//            request.setAttribute("company", company);
//            RequestDispatcher rd = request.getRequestDispatcher("selected.jsp");
//            rd.forward(request, response);
//            return;
//        }
//
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//            Connection con = DriverManager.getConnection(
//                "jdbc:mysql://localhost:3306/placementmanagementsystem", "root", "123456"
//            );
//
//            List<String> duplicateList = new ArrayList<>();
//
//            if ("delete".equalsIgnoreCase(action)) {
//                for (String data : selectedStudents) {
//                    String[] parts = data.split("::");
//                    String name = parts[0].trim();
//                    String mob = parts[1].trim();
//
//                    PreparedStatement ps = con.prepareStatement(
//                        "DELETE FROM selectedstudent WHERE name = ? AND mob = ? AND companyname = ?"
//                    );
//                    ps.setString(1, name);
//                    ps.setString(2, mob);
//                    ps.setString(3, company);
//                    ps.executeUpdate();
//                    ps.close();
//                }
//
//                request.setAttribute("message", "Selected students deleted successfully!");
//            }
//
//            else if ("select".equalsIgnoreCase(action)) {
//                for (String data : selectedStudents) {
//                    String[] parts = data.split("::");
//                    String name = parts[0].trim();
//                    String mob = parts[1].trim();
//
//                    // Check for duplicate in finalstudent
//                    PreparedStatement checkStmt = con.prepareStatement(
//                        "SELECT COUNT(*) FROM finalstudent WHERE name = ? AND mob = ? AND companyname = ?"
//                    );
//                    checkStmt.setString(1, name);
//                    checkStmt.setString(2, mob);
//                    checkStmt.setString(3, company);
//
//                    ResultSet rs = checkStmt.executeQuery();
//                    rs.next();
//                    int count = rs.getInt(1);
//                    rs.close();
//                    checkStmt.close();
//
//                    if (count > 0) {
//                        duplicateList.add(name + " (Mob: " + mob + ")");
//                        continue;
//                    }
//
//                    // Insert into finalstudent
//                    PreparedStatement insertStmt = con.prepareStatement(
//                        "INSERT INTO finalstudent (name, mob, companyname) VALUES (?, ?, ?)"
//                    );
//                    insertStmt.setString(1, name);
//                    insertStmt.setString(2, mob);
//                    insertStmt.setString(3, company);
//                    insertStmt.executeUpdate();
//                    insertStmt.close();
//                }
//
//                if (duplicateList.isEmpty()) {
//                    request.setAttribute("message", "All selected students added successfully!");
//                } else {
//                    request.setAttribute("message", "Some students already exist: " + String.join(", ", duplicateList));
//                }
//            }
//
//            con.close();
//
//            request.setAttribute("company", company);
//            RequestDispatcher rd = request.getRequestDispatcher("selected.jsp");
//            rd.forward(request, response);
//
//        } catch (Exception e) {
//            e.printStackTrace(out);
//        }
//    }
//}
