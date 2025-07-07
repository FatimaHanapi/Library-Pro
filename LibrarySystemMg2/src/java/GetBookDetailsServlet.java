import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

@WebServlet("/GetBookDetails")
public class GetBookDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PreparedStatement pstmtSelect;

    public void init() throws ServletException {
        try {
            initializeJdbc();
        } catch (ClassNotFoundException | SQLException ex) {
            throw new ServletException("Error initializing JDBC", ex);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            ResultSet rs = getBookDetails(title);
            if (rs.next()) {
                JSONObject book = new JSONObject();
                book.put("title", rs.getString("TITLE"));
                book.put("author", rs.getString("AUTHOR"));
                book.put("publicationYear", rs.getString("PUBLICATION_YEAR"));
                                book.put("genre", rs.getString("GENRE"));
                book.put("status", rs.getString("STATUS"));

                out.print(book.toString());
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print("{\"error\":\"Book not found\"}");
            }
        } catch (SQLException ex) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"Database error: " + ex.getMessage() + "\"}");
        } finally {
            out.close();
        }
    }

    private void initializeJdbc() throws ClassNotFoundException, SQLException {
        String driver = "org.apache.derby.jdbc.ClientDriver";
        String connectionString = "jdbc:derby://localhost:1527/NewUserDB;create=true;user=APP;password=app";

        Class.forName(driver); // Load JDBC driver
        Connection conn = DriverManager.getConnection(connectionString); // Establish database connection

        pstmtSelect = conn.prepareStatement("SELECT * FROM NEWBOOK WHERE TITLE = ?");
    }

    private ResultSet getBookDetails(String title) throws SQLException {
        pstmtSelect.setString(1, title);
        return pstmtSelect.executeQuery();
    }
}

