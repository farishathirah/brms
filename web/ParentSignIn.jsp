<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <title>Parent Sign In</title>
        <style>
            @import url("https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");

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
                gap: 30px;
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

            .title {
                font-weight: 400;
                letter-spacing: 1.5px;
                color: black;

            }

            .container {
                height: 530px;
                width: 700px;
                background-color: #e86100;
                box-shadow: 8px 8px 10px black;
                position: relative;
                overflow: hidden;
                border-radius: 50px;
            }

            .login-box {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 0px 40px;
            }

            /* email password field box */
            .ele {
                height: 60px;
                width: 400px;
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
                background-color: #333333;
                font-size: 22px;
                border: none;
                cursor: pointer;
                color: white;
                font-weight: bold;
                transition: background-color 0.3s ease;
            }

            .clkbtn:hover {
                background-color: #444444;
            }
            .clkbtn2 {
                height: 60px;
                width: 230px;
                border-radius: 50px;
                background-color: #666666;
                font-size: 22px;
                border: none;
                cursor: pointer;
                color: white;
                font-weight: bold;
                text-transform: uppercase;
                transition: background-color 0.3s ease;
            }

            .clkbtn2:hover {
                background-color: #cc5500;
            }

            .clkbtn3 {
                height: 60px;
                width: 230px;
                border-radius: 50px;
                background-color: #333333;
                font-size: 22px;
                border: none;
                cursor: pointer;
                color: white;
                font-weight: bold;
                text-transform: uppercase;
                transition: background-color 0.3s ease;
            }


            .label1 {
                text-align: left;
                color: white;
            }

            .h3 {
                color: white;
            }

            .button-group {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
            }


            .password-toggle {
                cursor: pointer;
                position: absolute;
                font-size: 1.3rem;
                margin-top: 25px;
                margin-left: 330px;
            }

        </style>
    </head>

    <body>
        <h4 style="color: white; text-align: left; margin: 10px; position: absolute; top: 10px; left: 10px;">
            <a href="AdminSignIn.jsp" style="text-decoration: none; color: white;">Admin</a>
        </h4>

        <header>
            <a href="FirstHomepage.jsp" class="heading-link">
                <h1 class="heading">BRMS</h1></a>
            <h3 class="title">Trusted Babysitter You Looking For</h3>
        </header>

        <!-- container div -->
        <div class="container">
            <br>
            <h3 align="center">Parent Log In</h3>
            <br>
            <div class="form-section">

                <!-- login form -->
                <div class="login-box">
                    <div class="button-group">
                        <button onclick="loginParent()" class="clkbtn3">Parent</button>
                        <button onclick="loginBabysitter()" class="clkbtn2">Babysitter</button>
                    </div><br>
                    <form action="ParentServlet?action=plogin" class="login-box" method="post">
                        <label class="label1">Username</label>
                        <input type="text" id="parentUser" name="parentUser" class="ele" placeholder="Enter your Username" required><br>
                        <label class="label1">Password</label>
                        <input type="password" id="parentPass" name="parentPass" class="password ele" placeholder="Enter your Password" required>
                        <i class="fas fa-eye password-toggle" onclick="togglePasswordVisibility()"></i>
                        <!--<h4 align="center"><a href="ForgotPassword.jsp">Forgot password?</a></h4><br>--><br><br>
                        <input type="submit" class="clkbtn" id="submit" value="Login">
                        <%
                            String errorMessage = (String) request.getAttribute("errorMessage");
                            if (errorMessage != null) {
                        %>
                        <span style='color: red;'><%= errorMessage%></span>
                        <%
                            }
                        %>
                    </form>
                </div>
                <br>

                <h3 align="center">New to BRMS? Register <a href="ParentRegister.jsp">HERE</a></h3>
                <br>
            </div>
        </div>

        <script>
            function loginParent() {
                // Redirect to the owner login page
                window.location.href = "ParentSignIn.jsp";
            }

            function loginBabysitter() {
                // Redirect to the babysitter login page
                window.location.href = "BabysitterSignIn.jsp";
            }

            function togglePasswordVisibility() {
                var passwordInput = document.getElementById("parentPass");
                if (passwordInput.type === "password") {
                    passwordInput.type = "text";
                } else {
                    passwordInput.type = "password";
                }
            }
        </script>


    </body>
</html>
