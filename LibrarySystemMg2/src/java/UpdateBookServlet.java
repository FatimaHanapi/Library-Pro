import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateBookServlet")
public class UpdateBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Connection conn;
    private PreparedStatement pstmtUpdate;

    public void init() throws ServletException {
        try {
            initializeJdbc();
        } catch (ClassNotFoundException | SQLException ex) {
            throw new ServletException("Error initializing JDBC", ex);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publicationYear = request.getParameter("publicationYear");
        String genre = request.getParameter("genre");
        String status = request.getParameter("status");

        response.setContentType("text/html");
        try {
            if (title != null && !title.isEmpty() && author != null && !author.isEmpty()
                    && publicationYear != null && !publicationYear.isEmpty() && genre != null && !genre.isEmpty()
                    && status != null && !status.isEmpty()) {
                int rowsUpdated = updateBook(title, author, publicationYear, genre, status);
                if (rowsUpdated > 0) {
                    response.sendRedirect("catalog.jsp");
                } else {
                    response.getWriter().println("No book found with the given title.");
                }
            } else {
                response.getWriter().println("Invalid input. Please ensure all fields are filled.");
            }
        } catch (SQLException ex) {
            throw new ServletException("Error updating book details", ex);
        }
    }

    private void initializeJdbc() throws ClassNotFoundException, SQLException {
        String driver = "org.apache.derby.jdbc.ClientDriver";
        String connectionString = "jdbc:derby://localhost:1527/NewUserDB;create=true;user=APP;password=app";

        Class.forName(driver); // Load JDBC driver
        conn = DriverManager.getConnection(connectionString); // Establish database connection

        pstmtUpdate = conn.prepareStatement("UPDATE NEWBOOK SET AUTHOR=?, PUBLICATION_YEAR=?, GENRE=?, STATUS=? WHERE TITLE=?");
    }

    private int updateBook(String title, String author, String publicationYear, String genre, String status) throws SQLException {
        pstmtUpdate.setString(1, author);
        pstmtUpdate.setString(2, publicationYear);
        pstmtUpdate.setString(3, genre);
        pstmtUpdate.setString(4, status);
        pstmtUpdate.setString(5, title);
        return pstmtUpdate.executeUpdate();
    }

    public void destroy() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
