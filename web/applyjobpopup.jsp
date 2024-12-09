<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            // Retrieve job details from request parameters
            String bookingID = request.getParameter("bookingID");
            String babyID = request.getParameter("babyID");
            String applyStatus = request.getParameter("applyStatus");

            // Database connection details
            String jdbcUrl = "jdbc:mysql://localhost:3306/babysitter";
            String dbUser = "root";
            String dbPassword = "admin";

            Connection conn = null;
            PreparedStatement stmt = null;

            try {
                // Establish database connection
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                // Insert into appliedJobs table
                String query = "INSERT INTO appliedjob(bookingID, babyID, applicationDate, applyStatus) VALUES (?, ?, ?, ?)";
                stmt = conn.prepareStatement(query);
                stmt.setString(1, bookingID);
                stmt.setString(2, babyID);
                stmt.setTimestamp(3, new Timestamp(new Date().getTime()));
                stmt.setString(4,  applyStatus);
                stmt.executeUpdate();

                // If everything is successful, redirect to applyjobpopup.jsp
                response.sendRedirect("JobHistory.jsp");
            } catch (Exception e) {
                // If any exception occurs, send failure response and display alert message
                e.printStackTrace();
            } finally {
                // Close resources
                try {
                    if (stmt != null) {
                        stmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>

        <script>
            
        function alertMessage(message, color) {
                var alertBox = document.createElement('div');
                alertBox.textContent = message;
                alertBox.style.color = color;
                alertBox.style.textAlign = 'center';
                alertBox.style.marginTop = '10px';
                document.querySelector('.popup-content').appendChild(alertBox);
                setTimeout(function () {
                    alertBox.remove();
                }, 3000); // Remove alert after 3 seconds
            }
        </script>
    </body>
</html>
