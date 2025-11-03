import dao.DBConnection;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String subcategory = request.getParameter("subcategory");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String imageUrl = request.getParameter("image");

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO products(name, category, subcategory, description, price, stock, image) VALUES (?, ?, ?, ?, ?, ?, ?)");
            stmt.setString(1, name);
            stmt.setString(2, category);
            stmt.setString(3, subcategory);
            stmt.setString(4, description);
            stmt.setDouble(5, price);
            stmt.setInt(6, stock);
            stmt.setString(7, imageUrl);
            stmt.executeUpdate();

            response.sendRedirect("adminAddProduct.jsp?status=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminAddProduct.jsp?status=error");
        }
    }
}
