<%-- 
    Document   : LoginSignupPage
    Created on : 24 Dec 2023, 12:13:21 am
    Author     : afrin
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <title>Parent Register</title>
        <style>
            @import url("https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: "Poppins", sans-serif;
            }

            body {
                height: 100vh;
                width: 100vw;
                display: flex;
                justify-content: center;
                align-items: center;
                flex-direction: column;
                gap: 20px;
                background: whitesmoke;
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;

            }

            header {
                width: 100%;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                gap: 8px;
            }

            .heading {
                color: black;
            }

            .heading-link {
                cursor: pointer;
                text-decoration: none;
                color: inherit; /* Inherit the color from the parent element */
                transition: color 0.3s ease; /* Smooth color transition */
            }

            .heading-link:hover {
                color: #2e3e42; /* Change color on hover */
            }

            .title {
                font-weight: 400;
                letter-spacing: 1.5px;
                color: black;
            }

            .container {
                height: auto; /* Adjust height to fit content */
                width: 60%; /* Take 60% of the viewport width */
                max-width: 800px; /* Limit maximum width */
                background-color: white;
                box-shadow: 8px 8px 10px black;
                border-radius: 50px;
                padding: 20px; /* Add padding for space inside the container */
            }

            .login-box {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                width: 100%; /* Fill the container width */
            }

            .input-container {
                margin-bottom: 15px; /* Add margin between each input */
                display: flex;
                flex-direction: column; /* Arrange inputs vertically */
                gap: 12px; /* Adjust the gap between inputs */
                width: 100%; /* Fill the container width */
            }

            .ele {
                height: 40px;
                width: 100%; /* Take full width */
                outline: none;
                border: none;
                color: rgb(77, 77, 77);
                background-color: rgb(240, 240, 240);
                border-radius: 50px;
                padding-left: 30px;
                font-size: 18px;
            }


            .clkbtn {
                height: 60px;
                width: 230px;
                border-radius: 50px;
                background-color: #829EA6;
                font-size: 22px;
                border: none;
                cursor: pointer;
                color: white;
                font-weight: bold;
                text-transform: uppercase;
                transition: background-color 0.3s ease;
            }

            .clkbtn:hover {
                background-color: #2e3e42;
                font-size: 25px;
            }




            .h3 {
                color: black;
            }

            table {
                display: table;
                border-collapse: separate;
                box-sizing: border-box;
                text-indent: initial;
                unicode-bidi: isolate;
                border-spacing: 10px; /* Adjust the spacing between cells */
                border-color: gray;
            }
            table {
                width: 100%; /* Fill the container width */
            }

            td {
                padding: 10px; /* Add padding to cells for space around content */
                text-align: left;
            }

            .label1 {
                width: 20%; /* Fill the container width */
            }
            .cancel-btn {
                color: white;
                background-color: red;
                border: none;
                padding: 10px 20px;
                cursor: pointer;
            }

        </style>
    </head>
    <body>

        <h4 style="color: white; text-align: left; margin: 10px; position: absolute; top: 10px; left: 10px;">
            <a href="ParentSignIn.jsp" style="text-decoration: none; color: white;"><- Back</a>
        </h4>
        <header>
            <a href="FirstHomepage.jsp" class="heading-link">
                <h1 class="heading">BRMS</h1></a>
            <h3 class="title" align="center">
                <c:if test="${parent!= null}">
                    Edit Information
                </c:if>
                <c:if test="${parent== null}">
                    Fill in the Form
                </c:if>
            </h3>
        </header>

        <div class="container">
<!--            <div style="text-align: center; font-weight: bold; font-size: 1.2em;">
                Hire smarter. Sign up as a parent now!
            </div>-->

            <br>

            <main>
                <div class="intro">
                    <div class="content">
                        <c:if test ="${parent!=null}">
                            <form action="ParentServlet" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
                                <input type="hidden" name="action" value="pupdate">
                            </c:if>
                            <c:if test="${parent== null}">
                                <form action="ParentServlet" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
                                    <input type="hidden" name="action" value="pinsert">
                                </c:if>
                                <c:if test="${parent!=null}">
                                    <input type="hidden" name ="parentID" value="<c:out value='${parent.parentID}'/>"/>
                                </c:if>
                                <div class="login-box">
                                    <table>
                                        <c:if test="${parent!=null}">
                                            <tr>
                                                <td class="label1"><label>Profile Picture :</label></td>
                                                <td><input type="file" name="parentPP" accept="image/*"></td>
                                            </tr>
                                        </c:if>
                                        <tr>
                                            <td class="label1"><label>Full Name :</label></td>
                                            <td><input type="text" name="parentName" class="parentName ele" value="<c:out value='${parent.parentName}'/>" placeholder="Enter your Name" required></td>
                                        </tr>
                                        <tr>
                                            <td class="label1"><label>Username :</label></td>
                                            <td><input type="text" name="parentUser" class="User ele" value="<c:out value='${parent.parentUser}'/>" placeholder="Enter your Username" required></td>
                                        </tr>
                                        <tr>
                                            <td class="label1"><label>Password :</label></td>
                                            <td><input type="password" name="parentPass" class="password ele" value="<c:out value='${parent.parentPass}'/>" placeholder="Enter your Password" required></td>
                                        </tr>
                                        <tr>
                                            <td class="label1" ><label>Phone Number :</label></td>
                                            <td><input type="text" name="parentPhone" class="phoneNo ele" value="<c:out value='${parent.parentPhone}'/>" placeholder="Enter your Phone Number" oninput="restrictToNumbers(this);" required></td>
                                        </tr>
                                        <tr>
                                            <td class="label1" ><label>Email Address :</label></td>
                                            <td><input type="email" name="parentEmail" class="email ele" value="<c:out value='${parent.parentEmail}'/>" placeholder="Enter your Email Address" required></td>
                                        </tr>
                                    </table>
                                    <br>
                                    <div style="text-align: center;">
                                        <button type="submit" class="clkbtn">Save</button>
                                        <c:if test="${parent!= null}">
                                            <button type="button" class="clkbtn cancel-btn" onclick="window.location.href = 'ParentHomepage.jsp';">Cancel</button>
                                        </c:if>
                                    </div>
                                </div>
                            </form>
                    </div>
                </div>
            </main>

        </div> 
    </body>
</html>
