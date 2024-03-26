import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.util.Currency;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/PropertyServlet")
public class PropertyServlet extends HttpServlet {

    // Other methods and variables

    // Implement this method to fetch category name from the database
    private String getCategoryNameFromDatabase(Connection conn, String categoryID) throws SQLException {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String categoryName = ""; // Initialize category name variable

        try {
            // Query to fetch category name based on categoryID
            String query = "SELECT categoryName FROM category WHERE categoryID = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, categoryID);
            rs = stmt.executeQuery();

            // Check if a result is obtained
            if (rs.next()) {
                categoryName = rs.getString("categoryName"); // Get the category name from the result set
            }
        } finally {
            // Close resources in the finally block
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
        }

        return categoryName; // Return the category name
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            // Connect to your database
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rpms", "root", "1234");

            // Retrieve category ID from the request parameter
            String categoryID = request.getParameter("category");

            // Fetch category name from the database
            String categoryName = getCategoryNameFromDatabase(conn, categoryID);

            // Query to fetch available properties
            String query = "SELECT propertyID, propertyname, img, price, location FROM property WHERE status = ? AND categoryID = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, "Available");
            stmt.setString(2, categoryID);
            rs = stmt.executeQuery();

            // Set content type for response
            response.setContentType("text/html");
            OutputStream out = response.getOutputStream();

            // Generate HTML for displaying properties
            while (rs.next()) {
                // Fetch property details
                String propertyID = rs.getString("propertyID");
                String propertyName = rs.getString("propertyname");
                byte[] imgData = rs.getBytes("img");
                String price = rs.getString("price");
                String location = rs.getString("location");

                // Format the price
                NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance();
                currencyFormatter.setCurrency(Currency.getInstance("KES"));
                String formattedPrice = currencyFormatter.format(Double.parseDouble(price));

                // Display property details in HTML cards with basic styling
                out.write("<!DOCTYPE html>".getBytes());
                out.write("<html>".getBytes());
                out.write("<head>".getBytes());
                out.write("<meta charset=\"UTF-8\">".getBytes());
                out.write("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">".getBytes());
                out.write("<title>Property Listings</title>".getBytes());
                out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"category.css\">".getBytes()); // Change "styles.css" to your actual stylesheet file
                out.write("</head>".getBytes());
                out.write("<body>".getBytes());
                out.write("<div class=\"card\">".getBytes());
                out.write("<div class=\"img\">".getBytes());
                out.write("<img src=\"data:image/jpg;base64,".getBytes());
                out.write(org.apache.commons.codec.binary.Base64.encodeBase64(imgData));
                out.write("\" alt=\"Property Image\" style=\"width:100%; border-radius: 5px;\">".getBytes());
                out.write("</div>".getBytes());
                out.write(("<h3><a href=\"userbooking.jsp?propertyID=" + propertyID + "\">" + propertyName + "</a></h3>").getBytes());
                out.write(("<p>Price: " + formattedPrice + "</p>").getBytes());
                out.write(("<p>Location: " + location + "</p>").getBytes());
                out.write(("<input type=\"hidden\" name=\"propertyID\" value=\"" + propertyID + "\">").getBytes());
                out.write(("<input type=\"hidden\" name=\"propertyname\" value=\"" + propertyName + "\">").getBytes());
                out.write("</div>".getBytes());
                out.write("</body>".getBytes());
                out.write("</html>".getBytes());
            }
            out.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately, e.g., by sending an error response to the client
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle the exception appropriately
            }
        }
    }
}
