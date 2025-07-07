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

@WebServlet("/UserRegistration")
public class UserRegistration extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PreparedStatement pstmtInsert;
    private PreparedStatement pstmtSelect;

    public void init() throws ServletException {
        try {
            initializeJdbc(); // Initialize JDBC connection in init method
        } catch (ClassNotFoundException | SQLException ex) {
            throw new ServletException("Error initializing JDBC", ex);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
                out.println("Username and Password are required");
                return;
            }

            // Check if username already exists
            if (checkIfUserExists(username)) {
                out.println("Username already exists. Please choose a different username.");
                return;
            }

            // Register new user
            registerUser(username, password);

            // Display success message with script for popup and redirect
            out.println("<html><body>");
            out.println("<script type='text/javascript'>");
            out.println("alert('Successfully Registered! Please log in.');");
            out.println("window.location.href = 'login.jsp';");
            out.println("</script>");
            out.println("</body></html>");
        } catch (SQLException ex) {
            out.println("Database error: " + ex.getMessage());
            ex.printStackTrace();
        } finally {
            out.close();
        }
    }

    private void initializeJdbc() throws ClassNotFoundException, SQLException {
        String driver = "org.apache.derby.jdbc.ClientDriver";
        String connectionString = "jdbc:derby://localhost:1527/NewUserDB;create=true;user=APP;password=app";

        Class.forName(driver); // Load JDBC driver
        Connection conn = DriverManager.getConnection(connectionString); // Establish database connection

        pstmtInsert = conn.prepareStatement("insert into NEWUSER (username, password) values (?, ?)");
        pstmtSelect = conn.prepareStatement("select username from NEWUSER where username = ?");
    }

    private boolean checkIfUserExists(String username) throws SQLException {
        pstmtSelect.setString(1, username);
        ResultSet rs = pstmtSelect.executeQuery();
        return rs.next(); // Return true if user exists, false otherwise
    }

    private void registerUser(String username, String password) throws SQLException {
        pstmtInsert.setString(1, username);
        pstmtInsert.setString(2, password);
        pstmtInsert.executeUpdate(); // Execute SQL insert operation
    }
}