<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String studentName = (String) session.getAttribute("studentName");
    String studentMob = (String) session.getAttribute("studentMob");

    if (studentName == null || studentMob == null) {
        response.sendRedirect("StudentLogin.jsp");
        return;
    }

    List<Map<String, String>> passedCompanies = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/placementManagementSystem", "root", "123456");

        PreparedStatement ps = con.prepareStatement("SELECT companyname FROM SelectedStudent WHERE name = ? AND mob = ?");
        ps.setString(1, studentName);
        ps.setString(2, studentMob);
        ResultSet rs = ps.executeQuery();

        List<String> companyNames = new ArrayList<>();
        while (rs.next()) {
            companyNames.add(rs.getString("companyname"));
        }

        rs.close();
        ps.close();

        for (String cname : companyNames) {
            PreparedStatement cps = con.prepareStatement("SELECT companyname, location FROM company_register WHERE companyname = ?");
            cps.setString(1, cname);
            ResultSet crs = cps.executeQuery();

            if (crs.next()) {
                Map<String, String> data = new HashMap<>();
                data.put("name", crs.getString("companyname"));
                data.put("location", crs.getString("location"));
                passedCompanies.add(data);
            }

            crs.close();
            cps.close();
        }

        con.close();

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Passed Companies</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(to right, #e0f7fa, #fff);
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 900px;
            margin: 30px auto;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            padding: 20px;
        }

       h1 {
            text-align: center;
            color: #004d40;
            margin-bottom: 20px;
        } 

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 8px;
            overflow: hidden;
        }

        thead {
            background-color: #004d40;
            color: white;
        }

        th, td {
            padding: 14px;
            text-align: center;
        }

        tbody tr:nth-child(even) {
            background-color: #f1f1f1;
        }

        tbody tr:hover {
            background-color: #e0f2f1;
        }

        @media (max-width: 600px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }

            thead {
                display: none;
            }

            tr {
                margin-bottom: 15px;
                background-color: #f9f9f9;
                border: 1px solid #ddd;
                border-radius: 10px;
                padding: 10px;
            }

            td {
                text-align: left;
                padding: 10px;
                position: relative;
            }

            td::before {
                content: attr(data-label);
                font-weight: bold;
                display: block;
                color: #004d40;
                margin-bottom: 5px;
            }
        }
        p{
        text-align:center;
        }
    </style>
</head>
<body>

<div class="container">
<h1>WelCome <%=studentName %></h1>
    <p>you have passed in <%=passedCompanies.size() %> Companies</p>

    <table>
        <thead>
            <tr>
                <th>Company Name</th>
                <th>Location</th>
            </tr>
        </thead>
        <tbody>
        <% for (Map<String, String> row : passedCompanies) { %>
            <tr>
                <td data-label="Company Name"><%= row.get("name") %></td>
                <td data-label="Location"><%= row.get("location") %></td>
            </tr>
        <% } %>
        </tbody>
    </table>
</div>

</body>
</html>
