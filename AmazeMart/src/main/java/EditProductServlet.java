import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import dao.DBConnection;

@WebServlet("/EditProductServlet")
public class EditProductServlet extends HttpServlet {
   
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String subcategory = request.getParameter("subcategory");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String image = request.getParameter("image");

        try {
            Connection conn = DBConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(
                "UPDATE products SET name=?, category=?, subcategory=?, description=?, price=?, stock=?, image=? WHERE id=?"
            );
            stmt.setString(1, name);
            stmt.setString(2, category);
            stmt.setString(3, subcategory);
            stmt.setString(4, description);
            stmt.setDouble(5, price);
            stmt.setInt(6, stock);
            stmt.setString(7, image);
            stmt.setInt(8, id);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("adminManageProducts.jsp");
    }
}
