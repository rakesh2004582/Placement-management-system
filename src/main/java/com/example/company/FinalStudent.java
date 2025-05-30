package com.example.company;
import java.io.IOException;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/FinalStudent")
public class FinalStudent extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] selectedStudents = request.getParameterValues("selectedStudents");
        String action = request.getParameter("action");
        String company = request.getParameter("company");
        
        request.setAttribute("company", company);
        
        response.setContentType("text/html");
        java.io.PrintWriter out = response.getWriter();

        if (selectedStudents == null || selectedStudents.length == 0) {
            out.println("<h3 style='color:red;'>No students selected!</h3>");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/placementmanagementsystem", "root", "123456"
            );

            for (String data : selectedStudents) {
                String[] parts = data.split("::");
                String name = parts[0].trim();
                String mob = parts[1].trim();

                if ("delete".equalsIgnoreCase(action)) {
                    PreparedStatement ps = con.prepareStatement(
                        "DELETE FROM selectedstudent WHERE name = ? AND mob = ? AND companyname = ?"
                    );
                    ps.setString(1, name);
                    ps.setString(2, mob);
                    ps.setString(3, company);
                    ps.executeUpdate();
                    
                    RequestDispatcher rd = request.getRequestDispatcher("selected.jsp");
                    rd.forward(request, response);
                } else if ("select".equalsIgnoreCase(action)) {
                    PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO finalstudent (name, mob, companyname) VALUES (?, ?, ?)"
                    );
                    ps.setString(1, name);
                    ps.setString(2, mob);
                    ps.setString(3, company);
                    ps.executeUpdate();
                }
            }

            con.close();
            out.println("<h3 style='color:green;'>Operation '" + action + "' completed successfully!</h3>");
        } catch (Exception e) {
            e.printStackTrace(out);
        }
    }
}
