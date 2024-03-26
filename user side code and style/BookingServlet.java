import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String customerName = request.getParameter("customername");
        String phoneNumber = request.getParameter("phonenumber");
        String email = request.getParameter("email");
        LocalDate date = LocalDate.parse(request.getParameter("date"));
        String propertyID = request.getParameter("propertyID");

        
        // Generate a unique booking ID (you can customize this based on your requirements)
        String bookingID = generateBookingID();
        
        // Insert booking details into the database
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rpms", "root", "1234")) {
            String query = "INSERT INTO booking (bookingID, customername, phonenumber, email, date, propertyID) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, bookingID);
                stmt.setString(2, customerName);
                stmt.setString(3, phoneNumber);
                stmt.setString(4, email);
                stmt.setObject(5, date);
                stmt.setString(6, propertyID);
                
                int rowsInserted = stmt.executeUpdate();
                if (rowsInserted > 0) {
                    response.sendRedirect("success.jsp"); // Redirect to a success page
                } else {
                    response.sendRedirect("error.jsp"); // Redirect to an error page
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to an error page
        }
    }

    // Method to generate a unique booking ID (You can customize this based on your requirements)
    private String generateBookingID() {
        // Implementation to generate a unique booking ID (e.g., using UUID or timestamp)
        return "BOOK-" + System.currentTimeMillis(); // Example: Prefix with "BOOK-" followed by current timestamp
    }
}
