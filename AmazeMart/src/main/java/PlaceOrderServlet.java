import dao.CartItem;
import dao.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;
import java.util.List;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);

        // Check user authentication
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("login.jsp?status=unauthorized");
            return;
        }

        String email = (String) session.getAttribute("email");

        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        // Empty cart check
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp?status=empty");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            String insertOrderSQL = "INSERT INTO orders(user_email, product_id, quantity, order_date, status) " +
                                    "VALUES (?, ?, ?, NOW(), 'Pending')";

            try (PreparedStatement ps = conn.prepareStatement(insertOrderSQL)) {
                for (CartItem item : cart) {
                    ps.setString(1, email);
                    ps.setInt(2, item.getProductId());
                    ps.setInt(3, item.getQuantity());
                    ps.addBatch();
                }

                ps.executeBatch(); // Insert all orders at once
                if (Boolean.TRUE.equals(session.getAttribute("buyNowMode"))) {
                    // Restore original cart if in buy-now mode
                    @SuppressWarnings("unchecked")
                    List<CartItem> originalCart = (List<CartItem>) session.getAttribute("originalCart");
                    session.setAttribute("cart", originalCart);
                    session.removeAttribute("originalCart");
                    session.removeAttribute("buyNowMode");
                } else {
                    // Regular cart flow
                    session.removeAttribute("cart");
                }

            }

            // Clear session cart after successful order
            session.removeAttribute("cart");

            response.sendRedirect("trackOrders.jsp?status=success");

        } catch (SQLException e) {
            e.printStackTrace(); // Optional: log to file
            response.sendRedirect("cart.jsp?status=error");
        }
    }
}
