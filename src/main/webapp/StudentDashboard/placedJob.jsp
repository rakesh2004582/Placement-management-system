<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
    // 🔹 Step 1: Session से student का नाम और mobile number प्राप्त करें
    String studentName = (String) session.getAttribute("studentName");
    String studentMob = (String) session.getAttribute("studentMob");

    // 🔹 अगर session में data नहीं है तो login पेज पर redirect कर दो
    if (studentName == null || studentMob == null) {
        response.sendRedirect("Company/companyLogin.jsp");
        return;
    }

    // 🔹 JDBC objects declare करें
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // 🔹 Placement वाली companies को store करने के लिए list बनाएं
    List<Map<String, String>> selectedCompanies = new ArrayList<>();

    try {
        // 🔹 Step 2: Database से connect करें
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/placementmanagementsystem", "root", "123456");

        // 🔹 Step 3: Query लिखें जो student के placement की details निकाले
        String sql = "SELECT f.companyname, c.location, f.lpa " +
                     "FROM finalplacedstudents f " +
                     "JOIN company_register c ON f.companyname = c.companyname " +
                     "WHERE f.name = ? AND f.mob = ?"; // 🔸 केवल उस student की details निकले जिसकी name और mobile match करे

        // 🔹 Step 4: Query को prepare करें और parameters सेट करें
        ps = conn.prepareStatement(sql);
        ps.setString(1, studentName);  // पहला parameter – name
        ps.setString(2, studentMob);   // दूसरा parameter – mob

        // 🔹 Step 5: Query को execute करें
        rs = ps.executeQuery();

        // 🔹 Step 6: Result को list में डालें
        while (rs.next()) {
            Map<String, String> data = new HashMap<>();
            data.put("company", rs.getString("companyname")); // company name
            data.put("location", rs.getString("location"));   // location
            data.put("lpa", rs.getString("lpa"));             // package
            selectedCompanies.add(data);
        }
        

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        // 🔹 Step 7: Database resources बंद करें
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
<%
    session.setAttribute("studentName", studentName);
    session.setAttribute("studentMob", studentMob);
%>

<!-- 🔹 Step 8: HTML Page Start -->
<html>
<head>
    <title>Selected Companies</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eef2f3;
            padding: 30px;
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .header h2 {
            color: #2c3e50;
        }

        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 0 10px #ccc;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ccc;
            text-align: center;
        }

        th {
            background-color: #3498db;
            color: white;
        }

        tr:hover {
            background-color: #f2f2f2;
        }

        .no-data {
            text-align: center;
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>

<!-- 🔹 Header Section -->
<div class="header">
    <h2><%= studentName %> - Final Placement Details</h2>
</div>

<!-- 🔹 Step 9: अगर student का कोई placement नहीं है -->
<%
    if (selectedCompanies.isEmpty()) {
%>
    <p class="no-data">आप अभी तक किसी भी कंपनी में placed नहीं हुए हैं।</p>
<%
    } else {
%>
 <form action="<%=request.getContextPath()%>/StudentPlacementServlet" method="post">

    <table>
        <tr>
            <th>Select</th>
            <th>Company Name</th>
            <th>Location</th>
            <th>Package (LPA)</th>
        </tr>
        <%
            for (Map<String, String> row : selectedCompanies) {
                String value = row.get("company") + "|" + row.get("location") + "|" + row.get("lpa");
        %>
        <tr>
            <td><input type="radio" name="selectedCompany" value="<%= value %>" required></td>
            <td><%= row.get("company") %></td>
            <td><%= row.get("location") %></td>
            <td><%= row.get("lpa") %> LPA</td>
        </tr>
        <%
            }
        %>
    </table>
    <br>
    <div style="text-align:center;">
        <button type="submit">Submit</button>
    </div>
</form>
 <%
    }
%>

</body>
</html>
