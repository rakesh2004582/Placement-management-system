//package com.example.Student;

//
//import java.io.*;
//import javax.servlet.*;
//import javax.servlet.http.*;
//import java.sql.*;
//import javax.servlet.annotation.MultipartConfig;
//
//@MultipartConfig(
//    fileSizeThreshold = 1024 * 1024 * 1,  // 1 MB
//    maxFileSize = 1024 * 1024 * 5,        // 5 MB
//    maxRequestSize = 1024 * 1024 * 10     // 10 MB
//)
//public class RegisterStudentServlet extends HttpServlet {
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//
//        String jdbcURL = "jdbc:mysql://localhost:3306/placementManagementSystem";
//        String dbUser = "root";
//        String dbPass = "123456";
//
//        // Retrieve form data
//        String name = request.getParameter("name");
//        String email = request.getParameter("email");
//        String contact = request.getParameter("contact");
//        String address = request.getParameter("address");
//        String tenth = request.getParameter("tenth");
//        String twelfth = request.getParameter("twelfth");
//        String degree = request.getParameter("degree");
//        String gradPercent = request.getParameter("gradPercent");
//        String gradYear = request.getParameter("gradYear");
//        String pgdegree = request.getParameter("pgDegree");
//        String skills = request.getParameter("skills");
//        String experience = request.getParameter("experience");
//        String jobTitle = request.getParameter("jobTitle");
//        String password = request.getParameter("password");
//
//        Part resumePart = request.getPart("resume");
//        Part photoPart = request.getPart("photo");
//
//        InputStream resumeInputStream = null;
//
//        // Handle resume
//        if (resumePart != null && resumePart.getSize() > 0) {
//            resumeInputStream = resumePart.getInputStream();
//        } else {
//            response.getWriter().println("<h3>Please upload your resume PDF.</h3>");
//            return;
//        }
//
//        // Handle photo
//        String photoFileName = photoPart.getSubmittedFileName();
//        if (photoFileName == null || photoFileName.isEmpty()) {
//            response.getWriter().println("<h3>Please upload your photo JPG.</h3>");
//            return;
//        }
//
//        // Ensure uploads folder exists
//        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
//        File uploadDir = new File(uploadPath);
//        if (!uploadDir.exists()) {
//            uploadDir.mkdirs();
//        }
//
//        // Save photo to uploads folder
//        String photoSavePath = uploadPath + File.separator + photoFileName;
//        photoPart.write(photoSavePath);
//
//        // Relative path to store in DB
//        String photoDBPath = "uploads/" + photoFileName;
//
//        String[] projectTitles = request.getParameterValues("projectTitle");
//        String[] techUsed = request.getParameterValues("techUsed");
//        String[] projectDescriptions = request.getParameterValues("projectDescription");
//
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//
//            try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass)) {
//                String insertUserSQL = "INSERT INTO student_registration (name, email, contact, address, tenth_percent, twelfth_percent, degree, grad_percent, grad_year, pgdegree, skills, experience, job_title, password, image, resume_pdf) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
//
//                try (PreparedStatement psUser = conn.prepareStatement(insertUserSQL, Statement.RETURN_GENERATED_KEYS)) {
//                    psUser.setString(1, name);
//                    psUser.setString(2, email);
//                    psUser.setString(3, contact);
//                    psUser.setString(4, address);
//                    psUser.setString(5, tenth);
//                    psUser.setString(6, twelfth);
//                    psUser.setString(7, degree);
//                    psUser.setString(8, gradPercent);
//                    psUser.setString(9, gradYear);
//                    psUser.setString(10, pgdegree);
//                    psUser.setString(11, skills);
//                    psUser.setString(12, experience);
//                    psUser.setString(13, jobTitle);
//                    psUser.setString(14, password);
//                    psUser.setString(15, photoDBPath); // path instead of blob
//                    psUser.setBlob(16, resumeInputStream); // resume as blob
//
//                    int rows = psUser.executeUpdate();
//
//                    if (rows > 0) {
//                        try (ResultSet generatedKeys = psUser.getGeneratedKeys()) {
//                            if (generatedKeys.next()) {
//                                int userId = generatedKeys.getInt(1);
//
//                                if (projectTitles != null && techUsed != null && projectDescriptions != null) {
//                                    String insertProjectSQL = "INSERT INTO projects (application_id, project_title, tech_used, project_description) VALUES (?, ?, ?, ?)";
//                                    try (PreparedStatement psProject = conn.prepareStatement(insertProjectSQL)) {
//                                        for (int i = 0; i < projectTitles.length; i++) {
//                                            psProject.setInt(1, userId);
//                                            psProject.setString(2, projectTitles[i]);
//                                            psProject.setString(3, techUsed[i]);
//                                            psProject.setString(4, projectDescriptions[i]);
//                                            psProject.executeUpdate();
//                                        }
//                                    }
//                                }
//
//                                // Redirect to dashboard
//                                response.sendRedirect("StudentDashboard/studentDashboard.jsp");
//                                return;
//                            }
//                        }
//                    } else {
//                        response.getWriter().println("<h3>Failed to register student.</h3>");
//                    }
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.getWriter().println("<h3>Something went wrong. Please try again later.</h3>");
//        }
//    }
//}
////<img src="${pageContext.request.contextPath}/uploads/photo.jpg" width="150"/>





//package com.example.Student;
//
//import java.io.*;
//import javax.servlet.*;
//import javax.servlet.http.*;
//import java.sql.*;
//import javax.servlet.annotation.MultipartConfig;
//
//@MultipartConfig(
//    fileSizeThreshold = 1024 * 1024 * 1,  // 1 MB
//    maxFileSize = 1024 * 1024 * 5,        // 5 MB
//    maxRequestSize = 1024 * 1024 * 10     // 10 MB
//)
//public class RegisterStudentServlet extends HttpServlet {
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//
//        String jdbcURL = "jdbc:mysql://localhost:3306/placementManagementSystem";
//        String dbUser = "root";
//        String dbPass = "123456";
//
//        // Retrieve form data
//        String name = request.getParameter("name");
//        String email = request.getParameter("email");
//        String contact = request.getParameter("contact");
//        String address = request.getParameter("address");
//        String tenth = request.getParameter("tenth");
//        String twelfth = request.getParameter("twelfth");
//        String degree = request.getParameter("degree");
//        String gradPercent = request.getParameter("gradPercent");
//        String gradYear = request.getParameter("gradYear");
//        String pgdegree = request.getParameter("pgDegree");
//        String skills = request.getParameter("skills");
//        String experience = request.getParameter("experience");
//        String jobTitle = request.getParameter("jobTitle");
//        String password = request.getParameter("password");
//
//        Part resumePart = request.getPart("resume");
//        Part photoPart = request.getPart("photo");
//
//        InputStream resumeInputStream = null;
//
//        // Handle resume
//        if (resumePart != null && resumePart.getSize() > 0) {
//            resumeInputStream = resumePart.getInputStream();
//        } else {
//            response.getWriter().println("<h3>Please upload your resume PDF.</h3>");
//            return;
//        }
//
//        // Handle photo
//        if (photoPart == null || photoPart.getSize() == 0) {
//            response.getWriter().println("<h3>Please upload your photo JPG/PNG.</h3>");
//            return;
//        }
//
//        // Create upload path for UserImage folder inside webapp
//        String uploadPath = getServletContext().getRealPath("") + File.separator + "StudentDashboard" + File.separator + "UserImage";
//        File uploadDir = new File(uploadPath);
//        if (!uploadDir.exists()) {
//            uploadDir.mkdirs();
//        }
//
//        // Get original file extension
//        String originalFileName = photoPart.getSubmittedFileName();
//        String extension = "";
//        int i = originalFileName.lastIndexOf('.');
//        if (i > 0) {
//            extension = originalFileName.substring(i);
//        }
//
//        // Set new photo file name as user's mobile number + extension
//        String newPhotoFileName = contact + extension;
//
//        // Save photo to the specified folder
//        String photoSavePath = uploadPath + File.separator + newPhotoFileName;
//        photoPart.write(photoSavePath);
//
//        // Relative path to store in database (used for image display)
//        String photoDBPath = "StudentDashboard/UserImage/" + newPhotoFileName;
//
//        // Retrieve project data if available
//        String[] projectTitles = request.getParameterValues("projectTitle");
//        String[] techUsed = request.getParameterValues("techUsed");
//        String[] projectDescriptions = request.getParameterValues("projectDescription");
//
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//
//            try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass)) {
//                String insertUserSQL = "INSERT INTO student_registration (name, email, contact, address, tenth_percent, twelfth_percent, degree, grad_percent, grad_year, pgdegree, skills, experience, job_title, password, image, resume_pdf) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
//
//                try (PreparedStatement psUser = conn.prepareStatement(insertUserSQL, Statement.RETURN_GENERATED_KEYS)) {
//                    psUser.setString(1, name);
//                    psUser.setString(2, email);
//                    psUser.setString(3, contact);
//                    psUser.setString(4, address);
//                    psUser.setString(5, tenth);
//                    psUser.setString(6, twelfth);
//                    psUser.setString(7, degree);
//                    psUser.setString(8, gradPercent);
//                    psUser.setString(9, gradYear);
//                    psUser.setString(10, pgdegree);
//                    psUser.setString(11, skills);
//                    psUser.setString(12, experience);
//                    psUser.setString(13, jobTitle);
//                    psUser.setString(14, password);
//                    psUser.setString(15, photoDBPath); // save relative path to image
//                    psUser.setBlob(16, resumeInputStream); // save resume as blob
//
//                    int rows = psUser.executeUpdate();
//
//                    if (rows > 0) {
//                        try (ResultSet generatedKeys = psUser.getGeneratedKeys()) {
//                            if (generatedKeys.next()) {
//                                int userId = generatedKeys.getInt(1);
//
//                                if (projectTitles != null && techUsed != null && projectDescriptions != null) {
//                                    String insertProjectSQL = "INSERT INTO projects (application_id, project_title, tech_used, project_description) VALUES (?, ?, ?, ?)";
//                                    try (PreparedStatement psProject = conn.prepareStatement(insertProjectSQL)) {
//                                        for (int idx = 0; idx < projectTitles.length; idx++) {
//                                            psProject.setInt(1, userId);
//                                            psProject.setString(2, projectTitles[idx]);
//                                            psProject.setString(3, techUsed[idx]);
//                                            psProject.setString(4, projectDescriptions[idx]);
//                                            psProject.executeUpdate();
//                                        }
//                                    }
//                                }
//
//                                // Redirect to student dashboard page after successful registration
//                                response.sendRedirect("StudentDashboard/studentDashboard.jsp");
//                                return;
//                            }
//                        }
//                    } else {
//                        response.getWriter().println("<h3>Failed to register student.</h3>");
//                    }
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.getWriter().println("<h3>Something went wrong. Please try again later.</h3>");
//        }
//    }
//}
//




package com.example.Student;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.MultipartConfig;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,  // 1 MB
    maxFileSize = 1024 * 1024 * 5,        // 5 MB
    maxRequestSize = 1024 * 1024 * 10     // 10 MB
)
public class RegisterStudentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String jdbcURL = "jdbc:mysql://localhost:3306/placementManagementSystem";
        String dbUser = "root";
        String dbPass = "123456";

        // Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String address = request.getParameter("address");
        String tenth = request.getParameter("tenth");
        String twelfth = request.getParameter("twelfth");
        String degree = request.getParameter("degree");
        String gradPercent = request.getParameter("gradPercent");
        String gradYear = request.getParameter("gradYear");
        String pgdegree = request.getParameter("pgDegree");
        String skills = request.getParameter("skills");
        String experience = request.getParameter("experience");
        String jobTitle = request.getParameter("jobTitle");
        String password = request.getParameter("password");

        Part resumePart = request.getPart("resume");
        Part photoPart = request.getPart("photo");

        
        // Handle resume
        if (resumePart == null || resumePart.getSize() == 0) {
        	response.getWriter().println("<h3>Please upload your resume PDF.</h3>");
            return;
        } else {
             System.out.println(" resume upload");
        }
        
 
        String resumeUploadPath = "C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps\\Placement-Management-System\\src\\main\\webapp\\media\\UserResume".trim();

        File resumeDir = new File(resumeUploadPath);
        if (!resumeDir.exists()) {
            resumeDir.mkdirs();
        }

        // 2. Save resume file
        String resumeFileName = contact + "_resume.pdf"; // You can also use UUID or timestamp
        String resumeSavePath = resumeUploadPath + File.separator + resumeFileName;
        resumePart.write(resumeSavePath);

        // 3. Store relative path in DB
        String resumeDBPath = "media/UserResume/" + resumeFileName;

        // Handle photo
        if (photoPart == null || photoPart.getSize() == 0) {
            response.getWriter().println("<h3>Please upload your photo JPG/PNG.</h3>");
            return;
        }else {
        	System.out.println(" Image upload ");
        }

        // Image save path
//        String uploadPath = "C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps\\Placement-Management-System\\media\\user-profile".trim();
        String uploadPath= "C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps\\Placement-Management-System\\src\\main\\webapp\\media\\user-profile".trim();
       
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();  // Create folder if not exists
        }

        // Get extension from original file name
        String originalFileName = photoPart.getSubmittedFileName();
//        String originalResumename=resumePart.getSubmittedFileName();
//        String pdfextention = "";
        String extension = "";
        int i = originalFileName.lastIndexOf('.');
        if (i > 0) {
            extension = originalFileName.substring(i).trim();
        }
//        int j=originalResumename.lastIndexOf('.');
//        if(j>0) {
//        	pdfextention=originalResumename.substring(j).trim();
//        }

        // New photo file name using mobile number
        String newPhotoFileName = contact.trim() + extension;
//        String newResumeName=contact.trim()+pdfextention;

        // Save image to specified path
        String photoSavePath = uploadPath + File.separator + newPhotoFileName;
//        String resumeSavePath =uploadPath + File.separator+newResumeName;
        photoPart.write(photoSavePath);
//        resumePart.write(resumeSavePath);
        System.out.println("upload path : "+uploadPath);
        System.out.println("Photo save path : "+photoSavePath);
        System.out.println("Resume path : "+ resumeDBPath);
        System.out.println("Resume Save Path "+resumeSavePath);
        // Save image path in database (for example:  media/user-profile/1234567890.jpg)
        String photoDBPath = "media/user-profile/" + newPhotoFileName;
//        String resumeDBPath ="media/user-profile/"+newResumeName;

        // Retrieve project data
        String[] projectTitles = request.getParameterValues("projectTitle");
        String[] techUsed = request.getParameterValues("techUsed");
        String[] projectDescriptions = request.getParameterValues("projectDescription");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass)) {
                String insertUserSQL = "INSERT INTO student_registration (name, email, contact, address, tenth_percent, twelfth_percent, degree, grad_percent, grad_year, pgdegree, skills, experience, job_title, password, image, resume_pdf) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                try (PreparedStatement psUser = conn.prepareStatement(insertUserSQL, Statement.RETURN_GENERATED_KEYS)) {
                    psUser.setString(1, name);
                    psUser.setString(2, email);
                    psUser.setString(3, contact);
                    psUser.setString(4, address);
                    psUser.setString(5, tenth);
                    psUser.setString(6, twelfth);
                    psUser.setString(7, degree);
                    psUser.setString(8, gradPercent);
                    psUser.setString(9, gradYear);
                    psUser.setString(10, pgdegree);
                    psUser.setString(11, skills);
                    psUser.setString(12, experience);
                    psUser.setString(13, jobTitle);
                    psUser.setString(14, password);
                    psUser.setString(15, photoDBPath); // save image path
                    psUser.setString(16, resumeDBPath);
 // save resume path

                    int rows = psUser.executeUpdate();

                    if (rows > 0) {
                        try (ResultSet generatedKeys = psUser.getGeneratedKeys()) {
                            if (generatedKeys.next()) {
                                int userId = generatedKeys.getInt(1);

                                if (projectTitles != null && techUsed != null && projectDescriptions != null) {
                                    String insertProjectSQL = "INSERT INTO projects (application_id, project_title, tech_used, project_description) VALUES (?, ?, ?, ?)";
                                    try (PreparedStatement psProject = conn.prepareStatement(insertProjectSQL)) {
                                        for (int idx = 0; idx < projectTitles.length; idx++) {
                                            psProject.setInt(1, userId);
                                            psProject.setString(2, projectTitles[idx]);
                                            psProject.setString(3, techUsed[idx]);
                                            psProject.setString(4, projectDescriptions[idx]);
                                            psProject.executeUpdate();
                                        }
                                    }
                                }

                                // Redirect to dashboard on success
                                response.sendRedirect("Student_Login/StudentLogin.jsp");
                                return;
                            }
                        }
                    } else {
                        response.getWriter().println("<h3>Failed to register student.</h3>");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Something went wrong. Please try again later.</h3>");
        }
    }
}

