<%@ page import="java.sql.*, java.util.*" %>
<%
    String company = (String) request.getAttribute("company");
    out.println("Company received: " + company);
    if (company == null) {
        out.println("Company name is null!");
        return;
    }

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/placementmanagementsystem", "root", "123456");
    PreparedStatement ps = con.prepareStatement("SELECT * FROM selectedstudent WHERE companyname = ?");
    ps.setString(1, company);
    ResultSet rs = ps.executeQuery();
%>


<html>
<head>
    <title>Selected Students</title>
</head>
<body>
    <h2>Selected Students for Company: <%= company %></h2>
    <table border="1">
        <tr>
            <th>Name</th>
            <th>Contact</th>
        </tr>
        <%
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("mob") %></td>
        </tr>
        <%
            }
            con.close();
        %>
    </table>
</body>
</html>
