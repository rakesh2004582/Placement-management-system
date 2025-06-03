<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>

<%
    String CompanyName = (String) request.getAttribute("company");
    if (CompanyName == null) {
        CompanyName = request.getParameter("company");
    }

    List<Map<String, String>> students = new ArrayList<>();

    if (CompanyName != null && !CompanyName.trim().isEmpty()) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/placementmanagementsystem", "root", "123456");

            PreparedStatement ps = con.prepareStatement(
                "SELECT name, mob, lpa FROM finalplacedstudents WHERE companyname = ? ORDER BY lpa DESC");
            ps.setString(1, CompanyName);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, String> student = new HashMap<>();
                student.put("name", rs.getString("name"));
                student.put("mob", rs.getString("mob"));
                student.put("lpa", String.valueOf(rs.getDouble("lpa")));
                students.add(student);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p style='color:red;'>Company name is missing!</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= CompanyName %> - Final Placement Results</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #e0f7fa, #ffffff);
            margin: 0;
            padding: 0;
        }

        .header {
            background-color: #00695c;
            color: white;
            padding: 30px 0;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .header h1 {
            margin: 0;
            font-size: 36px;
            letter-spacing: 1px;
        }

        .container {
            padding: 40px;
            max-width: 900px;
            margin: auto;
            background-color: #ffffffcc;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
            margin-top: 40px;
            margin-bottom: 100px; /* Space for footer */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #004d40;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f1f8e9;
        }

        .no-data {
            text-align: center;
            font-size: 18px;
            padding: 20px;
            color: #d32f2f;
        }

        .highlight {
            color: #004d40;
            font-weight: bold;
        }

        .congrats {
            font-size: 20px;
            text-align: center;
            margin-top: 20px;
            color: #2e7d32;
        }

        footer {
            position: fixed;
            bottom: 0;
            width: 100%;
            background-color: #004d40;
            color: white;
            text-align: center;
            padding: 15px 10px;
            font-size: 16px;
        }

        footer a {
            color: #ffeb3b;
            text-decoration: none;
            font-weight: bold;
            margin-left: 10px;
        }

        footer a:hover {
            text-decoration: underline;
        }

        .footer-note {
            margin-top: 5px;
            font-size: 14px;
            color: #b2dfdb;
        }
    </style>
</head>
<body>

    <div class="header">
        <h1>Welcome <%= CompanyName %> 👋</h1>
    </div>

    <div class="container">
        <h2 style="text-align:center;">Students Selected by <span class="highlight"><%= CompanyName %></span></h2>

        <%
            if (students.size() > 0) {
        %>
        <table>
            <tr>
                <th>Sr.No</th>
                <th>Name</th>
                <th>Mobile</th>
                <th>LPA (₹ in Lakhs)</th>
            </tr>
            <%
                int index = 1;
                for (Map<String, String> student : students) {
            %>
            <tr>
                <td><%= index++ %></td>
                <td><%= student.get("name") %></td>
                <td><%= student.get("mob") %></td>
                <td><%= student.get("lpa") %></td>
            </tr>
            <%
                }
            %>
        </table>

        <p class="congrats">We wish all selected students a bright future ahead! 🚀</p>
        <%
            } else {
        %>
        <p class="no-data">No students were selected by <strong><%= CompanyName %></strong>.</p>
        <%
            }
        %>
    </div>

    <footer>
        Thank you for visiting! | <a href="index.html">Home</a>
        <div class="footer-note">Created by Rakesh Kumar Shakya</div>
    </footer>

</body>
</html>
