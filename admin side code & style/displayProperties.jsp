<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ page import="java.sql.*, java.util.*, your_package_name.Property" %>--%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
    <title>Admin Dashboard | Properties</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
</head>
<body>
   <input type="checkbox" id="menu-toggle">
    <div class="sidebar">
        <div class="side-header">
            <h3><span>NestQuest</span></h3>
        </div>
        
        <div class="side-content">
            <div class="profile">
                <div class="profile-img bg-img" style="background-image: url(img/1.jpeg)"></div>
                <h4>Administrator</h4>
                <small>PM1</small>
            </div>

            <div class="side-menu">
                <ul>
                    <li>
                       <a href="displayProperties.jsp" class="active">
                            <span class="las la-home"></span>
                            <small>Properties</small>
                        </a>
                    </li>
                    <li>
                       <a href="booking.jsp">
                            <span class="las la-clipboard-list"></span>
                            <small>Bookings</small>
                        </a>
                    </li>
                  <!--  <li>
                       <a href="profile.html">
                            <span class="las la-user-alt"></span>
                            <small>Profile</small>
                        </a>
                    </li>-->
                </ul>
            </div>
        </div>
    </div>
    
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
                        <a href="AdminLogoutServlet">Logout</a>
                    </div>
                </div>
            </div>
        </header>
        
        
        <main>
            
            <div class="page-header">
                <h1>Properties</h1>
                <small>Home / Properties</small>
            </div>
            
            <div class="page-content">
            
                <div class="records table-responsive">

                    <div class="record-header">
                        <div class="add">
                            <span>Entries</span>
                            <select name="" id="">
                                <option value="">ID</option>
                            </select>
                            <a href="AddProperty.html" class="add-property-button">
                            <button>Add Property</button>
                            </a>
                            
                            <a href="RemoveProperty.jsp" class="remove-property-button">
                            <button>Remove Property</button>
                            </a>
                        </div>

                    </div>


                    <div>
                        <table width="100%">
                            <thead>
                                <tr>
                                    <th>PROPERTYID</th>
                                    <th><span class="las la-sort"></span> PROPERTY NAME</th>
                                    <th><span class="las la-sort"></span> LOCATION</th>
                                    <th><span class="las la-sort"></span> PRICE</th>
                                    <th><span class="las la-sort"></span> PUBLISH DATE</th>
                                    <th><span class="las la-sort"></span> STATUS</th>
                                    <th><span class="las la-sort"></span> ACTIONS</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rpms", "root", "1234");
                                        Statement stmt = conn.createStatement();
                                        String query = "SELECT * FROM property";
                                        ResultSet rs = stmt.executeQuery(query);
                                        while (rs.next()) {
                                            String propertyId = rs.getString("propertyID");
                                            String propertyName = rs.getString("propertyname");
                                            String location = rs.getString("location");
                                            double price = rs.getDouble("price");
                                            Date publishDate = rs.getDate("publishdate");
                                            String status = rs.getString("status");
                                %>
                                <tr>
                                    <td><%= propertyId %></td>
                                    <td><%= propertyName %></td>
                                    <td><%= location %></td>
                                    <td><%= price %></td>
                                    <td><%= new SimpleDateFormat("dd MMMM, yyyy").format(publishDate) %></td>
                                    <td><%= status %></td>
                                    <td>
                                        <div class="actions">
                                            <span class="lab la-telegram-plane"></span>
                                            <span class="las la-eye"></span>
                                            <span class="las la-ellipsis-v"></span>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                        }
                                        rs.close();
                                        stmt.close();
                                        conn.close();
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>

                </div>
            
            </div>
            
        </main>
        
    </div>
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        const notifyIcon = document.querySelector('.notify-icon');
        const notifyCount = document.querySelector('.notify');
        
        // Add click event listener to the notification icon
        notifyIcon.addEventListener('click', function() {
            // Redirect the admin to the page with new bookings
            window.location.href = 'newBookings.jsp'; // Change the URL to your actual page
        });

        // You can update the notify count dynamically here based on the number of new bookings
        // For demonstration purposes, let's assume there are 5 new bookings
        notifyCount.textContent = '5'; // Update the number accordingly
    });
</script>

</body>
</html>

