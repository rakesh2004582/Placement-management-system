package com.example.company;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

 
 
public class CompanyReg extends HttpServlet {
	 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 response.getWriter().println("<h3>Please submit the form using POST method.</h3>");
	}

	 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		 
		 // make conection from Database 
		 String jdbcUrl="jdbc:mysql://localhost:3306/placementManagementSystem";
		 String user="root";
		 String pass="123456";
		 
		 // get the value from the form 
		 String companyName=request.getParameter("cname");
		 String tengthParsentage=request.getParameter("tength");
		 String twelfthParsentage=request.getParameter("twelfth");
		 String education=request.getParameter("heducation");
		 String educationpersentage=request.getParameter("hpersentage");
		 String cpass=request.getParameter("cpass");
		 
		 // sent these data in database
		 
		 try {
			 Class.forName("com.mysql.cj.jdbc.Driver");
			try (Connection conn = DriverManager.getConnection(jdbcUrl, user, pass)){
				String insertCompanySql ="INSERT INTO company_register (companyname,tenthpercentage,twelfthpercentage,highereducation_name,highereducation_percent,password) VALUES(?,?,?,?,?,?)";
				try(PreparedStatement psUser = conn.prepareStatement(insertCompanySql, Statement.RETURN_GENERATED_KEYS)){
					   psUser.setString(1,companyName);
					   psUser.setString(2,tengthParsentage);
					   psUser.setString(3, twelfthParsentage);
					   psUser.setString(4, education);
					   psUser.setString(5, educationpersentage);
					   psUser.setString(6, cpass);
					   
					   int rows = psUser.executeUpdate();
					   
					   if(rows>0) {
						   //response.getWriter().println("<h2>company registeration succsessfuly done</h2>");
						   response.sendRedirect("Company/companyLogin.jsp");
						   return;
					   }else {
						   response.getWriter().println("<h3>Company Registration failed</h3>");
					   }
				}
			}
			 
		 }catch(Exception e) {
			 e.printStackTrace();
			 response.getWriter().println("<h1>Something went wrong .....</h1>");
		 }
	}

}
