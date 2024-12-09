<%-- 
    Document   : EmployerList
    Created on : 8 Jan 2024, 11:21:59 pm
    Author     : afrin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Owner @ Employee Details</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Sriracha&display=swap');

            body {
                margin: 0;
                box-sizing: border-box;
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
            .container {
                max-width: 2000px;
                margin: 0 auto;
                background-color: #8BABB2;
                font-family: "Poppins";
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
            }
            .nav-items {
                display: flex;
                justify-content: space-around;
                align-items: center;
                background-color: #8BABB2;
                margin-right: 20px;

            }

            .nav-items a {
                text-decoration: none;
                color: #000;
                padding: 35px 20px;
            }

            /* CSS for main element */

            .main {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh; /* 100% of the viewport height */
            }
            .intro {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center; /* Center content vertically */
                width: 100%;
                min-height: 900px;
                max-height: 10000px;
                background:#A8C7CD;
                background: linear-gradient(to bottom, rgba(0, 0, 0, 0.3) 0%, rgba(0, 0, 0, 0.7) 60%), url('https://i.pinimg.com/564x/c7/2d/b7/c72db792b13ec2b08cf1101d0307fb23.jpg'); /* Replace 'your-wallpaper-image.jpg' with the path to your wallpaper image */
                background-size: cover;
                background-position: center;
                background-repeat: repeat;

            }
            .intro h1 {
                font-family: "Times new roman";
                font-size: 40px;
                color: black;
                font-weight: bold;
                text-transform: uppercase;
                margin: 5px;
            }

            .intro p {
                font-size: 20px;
                margin: 20px 0;
            }

            .intro button {
                color: #000;
                padding: 10px 25px;
                border: none;
                border-radius: 5px;
                font-size: 20px;
                font-weight: bold;
                cursor: pointer;
                box-shadow: 0px 0px 20px rgba(255, 255, 255, 0.4)
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

            .content {
                max-height: 10000px;
                margin: 10px auto;
                font-size: 20px;
                padding: 20px;
                background-color: white;
                box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
            }

            .content h2 {
                margin-bottom: 20px;
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
            .input-container {
                margin-bottom: 15px; /* Adjust the margin between each input */
                display: flex;
                gap: 6px; /* Adjust the gap between label and input */
            }


            .clkbtn:hover {
                background-color: #2e3e42;
                font-size: 25px;
            }

            .label1 {
                text-align: left;
                width: 220px; /* Adjust the width of the label */
            }

            .h3 {
                color: black;
            }

            .popup-container {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                justify-content: center;
                align-items: center;
            }

            .popup-content {
                background-color: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
                color: black;
            }

            .popup-buttons {
                display: flex;
                justify-content: space-around;
                margin-top: 20px;
            }

            .popup-button {
                padding: 10px;
                border-radius: 5px;
                cursor: pointer;
            }

            .confirm-button {
                background-color: #78E678;
                color: white;
            }

            .cancel-button {
                background-color: #EE5E5E;
            }
            .print-button {
                margin: 10px; /* Adjust margin */
                padding: 15px 30px;
                background-color: #E4DF69;
                color: black;
                border: none;
                border-radius: 10px;
                font-size: 18px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.3s ease; /* Add transition for smooth hover effect */
            }

            .print-button:hover {
                background-color: #CCCC00; /* Darker green color on hover */
                transform: scale(1.05); /* Increase size on hover */
            }
        </style>
    </head>
    <body>
        <header>
            <a href="AdminHomepage.jsp" class="logo">BRMS</a>
            <a href="AdminSignIn.jsp" class="logout" style="float: right;">LogOut</a>

            <div class="container">
                <nav class="nav-bar">
                    <ul>
                        <li class="nav-item"><a class="nav-link" href="adminHomepage.jsp">Dashboard</a></li>
                        <li class="nav-item"><a class="nav-link" href="ParentServlet?action=plist">Manage Parents</a></li>
                        <li class="nav-item"><a class="nav-link" href="BabysitterServlet?action=prlist">Manage Babysitter</a></li>
                        <li class="nav-item"><a class="nav-link" href="Report.jsp">Reports</a></li>
                    </ul>
                </nav>
            </div>


        </header>
        <div class="intro">
            <div class="content">
                <h1>Babysitter Details</h1>
                <br> 
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Babysitter ID</th>
                            <th>Name </th>
                            <th>Username</th>
                            <th>Password</th>
                            <th>Phone No</th>
                            <th>Email</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>

                        <c:forEach var="babysitter" items="${listBabysitter}">
                            <tr>
                                <td><c:out value="${babysitter.babyID}"/></td>

                                <td><c:out value="${babysitter.babyName}"/></td>

                                <td><c:out value="${babysitter.babyUser}"/></td>

                                <td><c:out value="${babysitter.babyPass}"/></td>

                                <td><c:out value="${babysitter.babyPhone}"/></td>

                                <td><c:out value="${babysitter.babyEmail}"/></td>


                                <td>
                                    <a href="BabysitterServlet?action=preditadmin&babyID=<c:out value='${babysitter.babyID}'/>">
                                        <i class="fas fa-edit" style="color: green;"></i>
                                    </a>
                                    &nbsp;&nbsp;&nbsp;&nbsp;

                                    <a href="#" onclick="showConfirmationPopup('<c:out value='${babysitter.babyID}'/>')">
                                        <i class="fas fa-trash-alt" style="color: red;"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <div class="popup-container" id="confirmationPopup">
                    <div class="popup-content">
                        <h2>Confirm Deletion</h2>
                        <p>Are you sure you want to delete this babysitter?</p>
                        <div class="popup-buttons">
                            <form id="deleteForm" method="post" action="BabysitterServlet?action=prdelete">
                                <input type="hidden" name="babyID" id="babyID" value="" />
                                <button type="button" class="popup-button confirm-button" onclick="confirmDelete()">Confirm</button>
                            </form>
                            <button type="button" class="popup-button cancel-button" onclick="cancelDelete()">Cancel</button>
                        </div>
                    </div>
                </div>

                <script>
                    function showConfirmationPopup(babyID) {
                        document.getElementById('babyID').value = babyID;
                        document.getElementById('confirmationPopup').style.display = 'flex';
                    }

                    function hideConfirmationPopup() {
                        document.getElementById('confirmationPopup').style.display = 'none';
                    }

                    function confirmDelete() {
                        document.getElementById('deleteForm').submit();
                        hideConfirmationPopup();
                    }

                    function cancelDelete() {
                        hideConfirmationPopup();
                    }
                </script>
            </div><button class="print-button" onclick="window.print()">Print Report</button>
        </div>

    </body>
</html>
