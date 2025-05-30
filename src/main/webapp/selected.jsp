<%-- <%@ page import="java.sql.*, java.util.*" %>
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
            <th>Select / Delete</th>
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
 --%>
 
 
 <%@ page import="java.sql.*, java.util.*" %>
<%
    String company = (String) request.getAttribute("company");
    if (company == null) {
        out.println("<h3 style='color:red;'>Company name is null!</h3>");
        return;
    }

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/placementmanagementsystem", "root", "123456");
    PreparedStatement ps = con.prepareStatement("SELECT * FROM selectedstudent WHERE companyname = ?");
    ps.setString(1, company);
    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Selected Students</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 80%;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 20px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #3498db;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .action-btn {
            margin: 20px;
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            font-size: 16px;
        }

        .btn-select {
            background-color: #2ecc71;
            color: white;
        }

        .btn-delete {
            background-color: #e74c3c;
            color: white;
        }

        .btn:hover {
            opacity: 0.9;
        }

        .checkbox {
            transform: scale(1.2);
        }

        #selectAll {
            cursor: pointer;
        }
    </style>
</head>
<body>

<h2>Selected Students for Company: <%= company %></h2>

<form action="FinalStudent" method="post">
    <input type="hidden" name="company" value="<%= company %>">
    <table>
        <tr>
            <th><input type="checkbox" id="selectAll" onclick="toggleAll(this)"> All</th>
            <th>Name</th>
            <th>Contact</th>
        </tr>

        <%
            while (rs.next()) {
                String name = rs.getString("name");
                String mob = rs.getString("mob");
        %>
        <tr>
           <%--  <td><input type="checkbox" name="selectedStudents" value="<%= name %> :: <%=mob %>" class="checkbox"></td> --%>
           <td>
  <input type="checkbox" name="selectedStudents" value="<%= name %>::<%= mob %>" class="checkbox">
</td>
           
            <td><%= name %></td>
            <td><%= mob %></td>
        </tr>
        <%
            }
            con.close();
        %>
    </table>

    <div class="action-btn">
        <button type="submit" name="action" value="select" class="btn btn-select">Select</button>
        <button type="submit" name="action" value="delete" class="btn btn-delete" onclick="return confirm('Are you sure you want to delete selected students?')">Delete</button>
    </div>
</form>

<script>
    function toggleAll(source) {
        const checkboxes = document.querySelectorAll('.checkbox');
        for (let i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = source.checked;
        }
    }
</script>

</body>
</html>
 