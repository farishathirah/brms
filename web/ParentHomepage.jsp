<%-- 
    Document   : ParentList
    Created on : 8 Jan 2024, 11:21:59 pm
    Author     : afrin
--%>
<%@page import="java.io.InputStream"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.DAO.ParentDAO" %>
<%@ page import="com.Model.Parent" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Parent Profile - BRMS</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

            body {
                margin: 0;
                box-sizing: border-box;
                font-family: "Poppins";
                background-color: black;
            }

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
                color: white;
                text-decoration: none;
                margin-top: 5px;
                margin-right: 30px;
            }

            .intro {
                display: flex;
                flex-direction: column;
                align-items: center;
                padding-top: 50px;
                width: 100%;
                min-height: 850px;
                background-color: #8BABB2;
                background: linear-gradient(to bottom, rgba(0, 0, 0, 0.9) 0%, rgba(0, 0, 1, 0.7) 60%), url('https://i.pinimg.com/564x/1e/92/64/1e9264f19c477b18787847fc6307ae84.jpg');
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
                margin: 50px auto;
                padding: 20px;
                background-color: rgba(255, 255, 255); /* white background with 80% opacity */
                box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }
            .nav-right {
                margin-left: auto;
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
                <a href="ParentHomepage.jsp" class="logo">BRMS</a>
                <div class="centered-text" style="color: white; flex-grow: 1; text-align: center;">Parent</div>
                <a href="ParentSignIn.jsp" class="logout">
                    <img src="Images/logout_icon.png" alt="Logout Icon" style="width:20px; height:20px; vertical-align:middle; margin-right: 5px;">
                    LogOut
                </a>
            </header>

            <div class="container">
                <nav class="nav-bar">
                    <ul>
                        <li class="nav-item"><a class="nav-link" href="ParentDash.jsp">Dashboard</a></li>
                        <li class="nav-item"><a class="nav-link" href="ParentHomepage.jsp">Profile</a></li>
                        <li class="nav-item"><a class="nav-link" href="BookingForm.jsp">Create Booking</a></li>
                        <li class="nav-item"><a class="nav-link" href="http://localhost:8080/BabysitterProject/BookingServlet?action=tlist">Booking Posted</a></li>
                        <li class="nav-item"><a class="nav-link" href="BookingInfo.jsp">Booking Applications</a></li>
                    </ul>
                </nav>
            </div>

        </header>
        <%@page import="java.util.Base64"%>
        <div class="intro">
            <div class="content">
                <h1>Profile Details</h1>
                <%
                    String jdbcUrl = "jdbc:mysql://localhost:3306/babysitter";
                    String dbUser = "root";
                    String dbPassword = "admin";
                    Integer parentID = (Integer) session.getAttribute("parentID");

                    if (parentID != null) {
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                            PreparedStatement ps = con.prepareStatement("SELECT * FROM parent WHERE parentID = ?");
                            ps.setInt(1, parentID);
                            ResultSet rs = ps.executeQuery();

                            if (rs.next()) {
                                String parentName = rs.getString("parentName");
                                String parentUser = rs.getString("parentUser");
                                String parentPass = rs.getString("parentPass");
                                String parentPhone = rs.getString("parentPhone");
                                String parentEmail = rs.getString("parentEmail");
                                InputStream parentPPStream = rs.getBinaryStream("parentPP");
                                String parentPPBase64 = "";

                                if (parentPPStream != null) {
                                    // Convert InputStream to Base64
                                    byte[] parentPPBytes = parentPPStream.readAllBytes();
                                    parentPPBase64 = Base64.getEncoder().encodeToString(parentPPBytes);
                                }
                %>
                <img src="data:image/jpeg;base64, <%= parentPPBase64%>" alt="Profile Picture" class="profile-picture">
                <br>
                <table class="profile-details">
                    <tr>
                        <td>User ID:</td>
                        <td><%= parentID.toString()%></td>
                    </tr>
                    <tr>
                        <td>Full Name:</td>
                        <td><%= parentName%></td>
                    </tr>
                    <tr>
                        <td>Username:</td>
                        <td><%= parentUser%></td>
                    </tr>
                    <tr>
                        <td>Phone Number:</td>
                        <td><%= parentPhone%></td>
                    </tr>
                    <tr>
                        <td>Email:</td>
                        <td><%= parentEmail%></td>
                    </tr>
                </table>
                <a class="update-button" href="ParentServlet?action=pedit&parentID=<%= parentID%>" class="update-button">Update</a>
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
                // If the session doesn't exist or parentID is not set, redirect to the login page
                response.sendRedirect("ParentSignIn.jsp");
            }
        %>
    </body>
</html>
