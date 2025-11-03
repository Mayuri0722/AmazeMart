import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import dao.DBConnection;

@WebServlet("/CancelOrderServlet")
public class CancelOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String email = (String) session.getAttribute("email");
        String orderIdStr = request.getParameter("orderId");

        if (orderIdStr == null || orderIdStr.isEmpty()) {
            response.sendRedirect("trackOrders.jsp?error=missingOrderId");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdStr);

            Connection conn = DBConnection.getConnection();

            // Make sure only "Pending" orders are cancelled and user matches
            String sql = "UPDATE orders SET status = 'Cancelled' WHERE id = ? AND user_email = ? AND status = 'Pending'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.setString(2, email);

            int rows = ps.executeUpdate();

            ps.close();
            conn.close();

            if (rows > 0) {
                response.sendRedirect("trackOrders.jsp?cancel=success");
            } else {
                response.sendRedirect("trackOrders.jsp?cancel=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("trackOrders.jsp?cancel=error");
        }
    }
}
