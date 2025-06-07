package com.example.Student;
import javax.servlet.ServletException;
 
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

//@WebServlet("/StudentPlacementServlet")
public class StudentPlacementServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Session से student info लो
        HttpSession session = request.getSession();
        String studentName = (String) session.getAttribute("studentName");
        String studentMob = (String) session.getAttribute("studentMob");

        // Radio से company data लो (format: name|location|package)
        String selectedCompany = request.getParameter("selectedCompany");

        if (studentName == null || studentMob == null || selectedCompany == null || selectedCompany.trim().isEmpty()) {
            response.sendRedirect("StudentDashboard/studentDashboard.jsp?error=MissingInput");
            return;
        }

        String[] parts = selectedCompany.split("\\|");
        if (parts.length != 3) {
            response.sendRedirect("StudentDashboard/studentDashboard.jsp?error=InvalidSelection");
            return;
        }

        String companyName = parts[0].trim();
        String location = parts[1].trim();
        String pkg = parts[2].trim();

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/placementmanagementsystem", "root", "123456");

            // Check if student already placed in this company
            String checkSql = "SELECT * FROM placed_students_in_company WHERE studentname=? AND mobilenumber=? AND companyname=?";
            ps = conn.prepareStatement(checkSql);
            ps.setString(1, studentName);
            ps.setString(2, studentMob);
            ps.setString(3, companyName);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Already exists → UPDATE
                ps.close();
                String updateSql = "UPDATE placed_students_in_company SET location=?, package=? WHERE studentname=? AND mobilenumber=? AND companyname=?";
                ps = conn.prepareStatement(updateSql);
                ps.setString(1, location);
                ps.setString(2, pkg);
                ps.setString(3, studentName);
                ps.setString(4, studentMob);
                ps.setString(5, companyName);
                ps.executeUpdate();
            } else {
                // Not exists → INSERT
                ps.close();
                String insertSql = "INSERT INTO placed_students_in_company (studentname, mobilenumber, companyname, location, package) VALUES (?, ?, ?, ?, ?)";
                ps = conn.prepareStatement(insertSql);
                ps.setString(1, studentName);
                ps.setString(2, studentMob);
                ps.setString(3, companyName);
                ps.setString(4, location);
                ps.setString(5, pkg);
                ps.executeUpdate();
            }

            response.sendRedirect("StudentDashboard/studentDashboard.jsp?status=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("StudentDashboard/studentDashboard.jsp?error=db");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
