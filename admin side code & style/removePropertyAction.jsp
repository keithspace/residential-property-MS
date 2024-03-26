<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
    <title>Remove Property Action</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
</head>
<body>
    <%
        String propertyName = request.getParameter("propertyName");
        String message = "";

        try {
            // Establish database connection (Replace 'url', 'user', and 'password' with your actual database credentials)
            String url = "jdbc:mysql://localhost:3306/rpms";
            String user = "root";
            String password = "1234";
            Connection connection = DriverManager.getConnection(url, user, password);

            // Update property status to 'sold'
            PreparedStatement statement = connection.prepareStatement("UPDATE property SET status = 'Sold' WHERE propertyname = ?");
            statement.setString(1, propertyName);
            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                message = "Property '" + propertyName + "' has been marked as Sold.";
            } else {
                message = "Property '" + propertyName + "' not found.";
            }

            // Close statement and connection
            statement.close();
            connection.close();
        } catch (SQLException e) {
            message = "Error: " + e.getMessage();
        }
    %>
    <div class="main-content">
        <header>
            <div class="header-content">
                <label for="menu-toggle">
                    <span class="las la-bars"></span>
                </label>
                
                <div class="header-menu">
                    <label for="">
                        <span class="las la-search"></span>
                    </label>
                    
                    <div class="notify-icon">
                        <span class="las la-bell"></span>
                        <span class="notify">3</span>
                    </div>
                    
                    <div class="user">
                        <div class="bg-img" style="background-image: url(img/1.jpeg)"></div>
                        
                        <span class="las la-power-off"></span>
                        <span>Logout</span>
                    </div>
                </div>
            </div>
        </header>
        
        <main>
            <div class="page-header">
                <h1>Remove Property </h1>
                <small>Home / Remove Property</small>
            </div>
            
            <div class="page-content">
                <p><%= message %></p>
                <a href="displayProperties.jsp">Return to Properties</a>
            </div>
        </main>
    </div>
</body>
</html>

