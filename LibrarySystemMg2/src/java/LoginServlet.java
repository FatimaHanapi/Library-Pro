import java.io.IOException;
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
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PreparedStatement pstmtSelect;

    public void init() throws ServletException {
        try {
            initializeJdbc(); // Initialize JDBC connection and prepared statement
        } catch (ClassNotFoundException | SQLException ex) {
            throw new ServletException("Error initializing JDBC", ex);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        String username = request.getParameter("name");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType"); // Capture the userType parameter

        try {
            if (validateUser(username, password)) {
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("userType", userType);

                // Debug logging
                System.out.println("User validated. Username: " + username + ", UserType: " + userType);

                // Redirect based on userType
                if ("student".equals(userType)) {
                    response.sendRedirect("homeStudent.jsp");
                } else if ("staff".equals(userType)) {
                    response.sendRedirect("homeStaff.jsp");
                } else {
                    response.sendRedirect("login.jsp?error=invalid");
                }
            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }
        } catch (SQLException ex) {
            throw new ServletException("Database error", ex);
        }
    }

    private void initializeJdbc() throws ClassNotFoundException, SQLException {
        String driver = "org.apache.derby.jdbc.ClientDriver";
        String connectionString = "jdbc:derby://localhost:1527/NewUserDB;create=true;user=APP;password=app";

        Class.forName(driver); // Load JDBC driver
        Connection conn = DriverManager.getConnection(connectionString); // Establish database connection

        pstmtSelect = conn.prepareStatement("select username from NEWUSER where username = ? and password = ?");
    }

    private boolean validateUser(String username, String password) throws SQLException {
        pstmtSelect.setString(1, username);
        pstmtSelect.setString(2, password);
        ResultSet rs = pstmtSelect.executeQuery();
        
        return rs.next(); // Return true if a user with matching credentials is found
    }
}

