<%-- 
    Document   : PosterList
    Created on : 8 Jan 2024, 11:21:59 pm
    Author     : afrin
--%>
<%@page import="java.io.InputStream"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.DAO.BabysitterDAO" %>
<%@page import="java.util.Base64"%>
<%@ page import="com.Model.Babysitter" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Babysitter Profile</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

            body {
                margin: 0;
                box-sizing: border-box;
                font-family: "Poppins";
                background-color:  black;
            }



            /* CSS for header */
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: black;

            }

            .logo {
                font-size: 25px;
                color: white;
                text-decoration: none;
                margin-left: 30px;
            }

            .logout {
                font-size: 20px;
                color:white;
                text-decoration: none;
                margin-top: 5px;
                margin-right: 30px;
            }

            .intro {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                width: 100%;
                min-height: 850px;
                background-color: #8BABB2;
                background: linear-gradient(to bottom, rgba(0, 0, 0, 0.6) 0%, rgba(0, 0, 0, 0.9) 60%), url('https://i.pinimg.com/564x/3a/d6/79/3ad6794a32b8d30a683457d6d434e8dd.jpg');
                background-position: center;
                background-repeat: repeat;
            }


            .container {
                max-width: 2000px;
                margin: 0 auto;
                background-color: #8BABB2;
                font-family: "Poppins";
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
            }

            .nav-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .nav-item {
                list-style-type: none;
                display: inline-block;
                margin-right: 20px;
            }

            .nav-link {
                color: white;
                text-decoration: none;
                font-size: 18px;
                font-weight: 600;
            }
            
            .nav-link:hover {
                color: lightgrey;
                transition: background-color 0.3s ease;
            }

            .content {
                max-width: 1000px;
                max-height: 800px;
                margin: 50px ; /* Change the margin to center vertically and horizontally */
                font-size: 20px;
                padding: 20px;
                background-color: white;
                box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                display: flex; /* Set it as a flex container */
                flex-direction: column; /* Stack children vertically */
                justify-content: center; /* Center vertically */
                align-items: center; /* Center horizontally */
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th, td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #f2f2f2;
            }
            .clkbtn {
                height: 60px;
                width: 200px; /* Increased width for a bigger button */
                border-radius: 30px;
                color: green; /* Added text color to white */
                font-size: 22px;
                border: none;
                cursor: pointer;
            }

            p.data-item {
                color:black;
            }

            .profile-picture {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                margin-right: 20px;
                align-items: center;
                justify-content: center; /* Horizontally center the content */

            }

            .details {
                max-width: 600px; /* Adjust as needed */
            }

            button-content {
                display: flex;
            }

            .update-button {
                background-color: green;
                color: white;
                padding: 10px 20px;
                border-radius: 5px;
                text-decoration: none;
                transition: background-color 0.3s ease;
                justify-content: center;
            }

            .update-button:hover {
                background-color: darkgreen;
            }

        </style>
    </head>
    <body>
        <header>
               <header style="display: flex; justify-content: space-between; align-items: center; background-color: black;">
                <a href="BabysitterHomepage.jsp" class="logo">BRMS</a>
                <div class="centered-text" style="color: white; flex-grow: 1; text-align: center;">Babysitter</div>
                <a href="BabysitterSignIn.jsp" class="logout">
                    <img src="Images/logout_icon.png" alt="Logout Icon" style="width:20px; height:20px; vertical-align:middle; margin-right: 5px;">
                    LogOut
                </a>
            </header>
            <div class="container">
                <nav class="nav-bar">
                    <ul>
                        <li class="nav-item"><a class="nav-link" href="BabysitterDash.jsp">Homepage</a></li>
                        <li class="nav-item"><a class="nav-link" href="BabysitterHomepage.jsp">Profile</a></li>
                        <li class="nav-item"><a class="nav-link" href="JobHistory.jsp">Job History</a></li>
                        <li class="nav-item"><a class="nav-link" href="ApplyJob.jsp">Find Job</a></li>
                        </ul>
                </nav>
            </div>

        </header>
        <div class="intro">
            <div class="content">
                <h1>Profile Details</h1>

                <br> 
                <%
                    String jdbcUrl = "jdbc:mysql://localhost:3306/babysitter";
                    String dbUser = "root";
                    String dbPassword = "admin";
                    Integer babyID = (Integer) session.getAttribute("babyID");

                    if (babyID != null) {
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                            PreparedStatement ps = con.prepareStatement("SELECT * FROM babysitter WHERE babyID = ?");
                            ps.setInt(1, babyID);
                            ResultSet rs = ps.executeQuery();

                            if (rs.next()) {
                                String babyName = rs.getString("babyName");
                                String babyUser = rs.getString("babyUser");
                                String babyPass = rs.getString("babyPass");
                                String babyPhone = rs.getString("babyPhone");
                                String babyEmail = rs.getString("babyEmail");
                                InputStream babyPPStream = rs.getBinaryStream("babyPP");
                                String babyPPBase64 = "";

                                if (babyPPStream != null) {
                                    // Convert InputStream to Base64
                                    byte[] babyPPBytes = babyPPStream.readAllBytes();
                                    babyPPBase64 = Base64.getEncoder().encodeToString(babyPPBytes);
                                }
                %>
                <img src="data:image/jpeg;base64, <%= babyPPBase64%>" alt="Profile Picture" class="profile-picture">
                <br>
                <table class="profile-details">
                    <tr>
                        <td class="data-item-label">User ID:</td>
                        <td><%= babyID.toString()%></td>
                    </tr>
                    <tr>
                        <td class="data-item-label">Full Name:</td>
                        <td><%= babyName%></td>
                    </tr>
                    <tr>
                        <td class="data-item-label">Username:</td>
                        <td><%= babyUser%></td>
                    </tr>
                    <tr>
                        <td class="data-item-label">Phone Number:</td>
                        <td><%= babyPhone%></td>
                    </tr>
                    
                </table>
                <br><a href="BabysitterServlet?action=predit&babyID=<%= babyID%>" class="update-button">Update</a>

            </div>



        </div>

        <%
                    } else {
                        out.println("No data found.");
                    }

                    rs.close();
                    ps.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("Database connection error: " + e.getMessage());
                }
            } else {
                // If the session doesn't exist or customerID is not set, redirect to the login page
                response.sendRedirect("BabysitterSignIn.jsp");
            }
        %>
    </body>
</html>
