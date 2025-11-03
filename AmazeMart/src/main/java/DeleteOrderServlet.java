

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dao.DBConnection;

@WebServlet("/DeleteOrderServlet")
public class DeleteOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String email = (String) session.getAttribute("email");
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        try (Connection conn = DBConnection.getConnection()) {
            // Check if the order belongs to the user and can be cancelled
            PreparedStatement checkStmt = conn.prepareStatement(
                    "SELECT status FROM orders WHERE id = ? AND user_email = ?");
            checkStmt.setInt(1, orderId);
            checkStmt.setString(2, email);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                String status = rs.getString("status");

                if (status.equalsIgnoreCase("Pending")) {
                    // Cancel the order
                    PreparedStatement cancelStmt = conn.prepareStatement(
                            "UPDATE orders SET status = 'Cancelled' WHERE id = ?");
                    cancelStmt.setInt(1, orderId);
                    cancelStmt.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("trackOrders.jsp");
    }
}
