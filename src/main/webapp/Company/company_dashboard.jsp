<%@ page import="java.util.List" %>
<%@ page import="com.example.company.Student" %>
<%@ page isELIgnored="false" %>

<%
    List<Student> students = (List<Student>) request.getAttribute("eligibleStudents");
%>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
            word-wrap: break-word;
        }

        th {
            background-color: #f2f2f2;
        }

        .select-btn, .delete-btn {
            padding: 6px 12px;
            border: none;
            cursor: pointer;
            margin-right: 5px;
            border-radius: 4px;
        }

        .selected {
            background-color: blue;
            color: white;
        }

        .deleted {
            background-color: red;
            color: white;
        }

        /* Responsive design */
        @media screen and (max-width: 768px) {
            table, thead, tbody, th, td, tr {
                display: block;
                width: 100%;
            }

            tr {
                margin-bottom: 15px;
                border-bottom: 2px solid #ccc;
            }

            th {
                display: none;
            }

            td {
                text-align: right;
                padding-left: 50%;
                position: relative;
            }

            td::before {
                content: attr(data-label);
                position: absolute;
                left: 10px;
                width: 45%;
                padding-right: 10px;
                font-weight: bold;
                text-align: left;
            }
        }
        button{
        border-radius:8px;
        }
        h1{
        margin:auto;
        text-align:center;
        }
    </style>

    <script>
        function toggleButtons(rowIndex, type) {
            var selectBtn = document.getElementById("select-" + rowIndex);
            var deleteBtn = document.getElementById("delete-" + rowIndex);

            if (type === 'select') {
                selectBtn.classList.add("selected");
                deleteBtn.classList.remove("deleted");
            } else if (type === 'delete') {
                deleteBtn.classList.add("deleted");
                selectBtn.classList.remove("selected");
            }
        }
    </script>
</head>
<body>
<%
    String CompanyName = (String) request.getAttribute("CompanyName");
System.out.println("Company name in dashboard file : "+CompanyName);
%>

<h1>
<%= CompanyName %>
</h1>
<%-- <h1>${CompanyName}</h1> --%>
<table>
    <thead>
    <tr>
        <th>Name</th>
        <th>10th %</th>
        <th>12th %</th>
        <th>Higher Education %</th>
        <th>Select/Delete</th>
    </tr>
    </thead>

    <tbody>
    <%
        if (students != null && !students.isEmpty()) {
            int index = 0;
            for (Student s : students) {
    %>
    <tr>
        <td data-label="Name"><%= s.getName() %></td>
        <td data-label="10th %"><%= s.getTenth() %></td>
        <td data-label="12th %"><%= s.getTwelfth() %></td>
        <td data-label="Higher Education %"><%= s.getHigherEducation() %></td>
        <td data-label="Select/Delete">
            <button class="select-btn" id="select-<%= index %>" onclick="toggleButtons(<%= index %>, 'select')">Select</button>
            <button class="delete-btn" id="delete-<%= index %>" onclick="toggleButtons(<%= index %>, 'delete')">Delete</button>
        </td>
    </tr>
    <%
                index++;
            }
        } else {
    %>
    <tr><td colspan="5" style="text-align:center;">No eligible students found.</td></tr>
    <%
        }
    %>
    </tbody>
</table>

</body>
</html>


<%--  
 <%@ page import="java.util.List" %>
<%@ page import="com.example.company.Student" %>
<%@ page import="com.example.company.Student" %>
<%
    List<Student> students = (List<Student>) request.getAttribute("eligibleStudents");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Eligible Students</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background: #f7f9fc;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            animation: fadeIn 1s ease-in-out;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #007BFF;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #e6f7ff;
            transition: 0.3s;
        }

        .action-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        .select-btn {
            background-color: #28a745;
            color: white;
        }

        .delete-btn {
            background-color: #dc3545;
            color: white;
        }

        @keyframes fadeIn {
            from {opacity: 0;}
            to {opacity: 1;}
        }

        @media (max-width: 768px) {
            table, th, td {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

<h2>Eligible Students</h2>

<table>
    <tr>
        <th>Name</th>
        <th>10th %</th>
        <th>12th %</th>
        <th>Higher Education %</th>
        <th>Action</th>
    </tr>

    <%
    if (students != null && !students.isEmpty()) {
        for (Student s : students) {
    %>
    <tr>
        <td><%= s.getName() %></td>
        <td><%= s.getTenth() %></td>
        <td><%= s.getTwelfth() %></td>
        <td><%= s.getHigherEducation() %></td>
        <td>
            <!-- Select Form -->
            <form action="SelectStudentServlet" method="post" style="display:inline;">
                <input type="hidden" name="studentId" value="<%= s.getId() %>">
                <button type="submit" class="action-btn select-btn">Select</button>
            </form>

            <!-- Delete Form -->
            <form action="DeleteStudentServlet" method="post" style="display:inline;">
                <input type="hidden" name="studentId" value="<%= s.getId() %>">
                <button type="submit" class="action-btn delete-btn">Delete</button>
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="5">No eligible students found.</td></tr>
    <%
    }
    %>
</table>

</body>
</html>
  --%>