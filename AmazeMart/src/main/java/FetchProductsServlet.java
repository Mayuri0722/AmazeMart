
import dao.DBConnection;
import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/FetchProductsServlet")
public class FetchProductsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String search = request.getParameter("search");
        if (search == null) search = "";

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try (Connection conn = DBConnection.getConnection()) {
            String query = "SELECT * FROM products WHERE name LIKE ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, "%" + search + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String name = rs.getString("name");
                String category = rs.getString("category");
                String image = rs.getString("image");
                String price = rs.getString("price");

                // Fallback if image is null or empty
                if (image == null || image.trim().isEmpty()) {
                    image = "https://via.placeholder.com/300x200?text=" + name.replaceAll(" ", "+");
                }

                out.println("<div class='card'>");
                out.println("<img src='" + image + "' class='card-img-top' alt='" + name + "'>");
                out.println("<div class='card-body'>");
                out.println("<h5 class='card-title'>" + name + "</h5>");
                out.println("<p class='card-text'>Category: " + category + "</p>");
                out.println("<p class='card-text text-success fw-bold'>₹" + price + "</p>");
                out.println("<a href='#' class='btn'>Add to Cart</a>");
                out.println("</div></div>");
            }

        } catch (Exception e) {
            out.println("<p style='color:red;'>Error loading products.</p>");
            e.printStackTrace(out);
        }
    }
}
