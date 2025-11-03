import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import dao.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/BuyNowServlet")
public class BuyNowServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String email = (String) session.getAttribute("email");

            Connection conn = DBConnection.getConnection();
            String sql = "INSERT INTO orders(user_email, product_id, quantity, order_date, status) VALUES (?, ?, ?, NOW(), 'Pending')";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);
            ps.executeUpdate();
            ps.close();
            conn.close();

            response.sendRedirect("trackOrders.jsp?status=buy-now-success");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("productDetails.jsp?id=" + request.getParameter("productId") + "&status=error");
        }
    }
}
