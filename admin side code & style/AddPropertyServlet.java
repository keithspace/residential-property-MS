import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;


@WebServlet("/addProperty")
@MultipartConfig
public class AddPropertyServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Retrieving form data
        //String propertyID = request.getParameter("PropertyID");
        String propertyName = request.getParameter("PropertyName");
        String categoryID = request.getParameter("Category");
        String location = request.getParameter("Location");
        String price = request.getParameter("Price");
        String publishDate = request.getParameter("PublishDate");
        String status = request.getParameter("Status");

        try {
            // Input validation
            if (propertyName == null || categoryID == null || location == null || price == null || publishDate == null || status == null ||
                propertyName.isEmpty() || categoryID.isEmpty() || location.isEmpty() || price.isEmpty() || publishDate.isEmpty() || status.isEmpty()) {
                out.println("<h2>Error: All fields are required.</h2>");
                return;
            }

            // Establishing database connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rpms", "root", "1234");

            // Inserting data into the database
            PreparedStatement pstmt = con.prepareStatement("INSERT INTO property (propertyName, categoryID, location, price, publishDate, status, img) VALUES (?, ?, ?, ?, ?, ?, ?)");
            //pstmt.setString(1, propertyID);
            pstmt.setString(1, propertyName);
            pstmt.setString(2, categoryID);
            pstmt.setString(3, location);
            pstmt.setString(4, price);
            pstmt.setString(5, publishDate);
            pstmt.setString(6, status);

            // Uploading image
            Part filePart = request.getPart("property_image");
            String fileName = extractFileName(filePart);

            if (fileName != null && !fileName.isEmpty()) {
                InputStream inputStream = filePart.getInputStream();
                pstmt.setBlob(7, inputStream);
            }

            int row = pstmt.executeUpdate();

            if (row > 0) {
                //out.println("<h2>Property added successfully!</h2>");
                response.sendRedirect("displayProperties.jsp");
            } else {
                out.println("<h2>Failed to add property.</h2>");
            }

            // Closing resources
            pstmt.close();
            con.close();
        } catch (SQLException e) {
            out.println("<h2>Error: 1" + e.getMessage() + "</h2>");
        } catch (ClassNotFoundException e) {
            out.println("<h2>Error: 2" + e.getMessage() + "</h2>");
        } catch (Exception e) {
            out.println("<h2>Error: 3 " + e.getMessage() + "</h2>");
        } finally {
            out.close();
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}
