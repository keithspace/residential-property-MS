import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CategoryServlet")
public class CategoryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            // Connect to your database
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rpms", "root", "1234");

            // Query to fetch category names and images
            String query = "SELECT categoryID, categoryname, categoryimage FROM category";
            stmt = conn.prepareStatement(query);
            rs = stmt.executeQuery();

            // Set content type for response
            response.setContentType("text/html");
            OutputStream out = response.getOutputStream();

            // Generate HTML for displaying categories
            while (rs.next()) {
                String categoryID = rs.getString("categoryID"); 
                String categoryName = rs.getString("categoryname");
                byte[] imgData = rs.getBytes("categoryimage");

                // Display category details in HTML cards
                out.write("<div class=\"card\">".getBytes());
                out.write("<div class=\"img\">".getBytes());
                out.write("<img src=\"data:image/jpg;base64,".getBytes());
                out.write(org.apache.commons.codec.binary.Base64.encodeBase64(imgData));
                out.write("\" alt=\"Category Image\" style=\"width:100%\">".getBytes());
                out.write("</div>".getBytes());
                out.write(("<h2><a href=\"PropertyServlet?category=" + categoryID + "\">" + categoryName + "</a></h2>").getBytes());
                out.write("</div>".getBytes());
                
            }
            out.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
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
            }
        }
    }
}
