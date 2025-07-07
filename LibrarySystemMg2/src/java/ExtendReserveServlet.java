import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ExtendReserveServlet")
public class ExtendReserveServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Connection conn;
    private PreparedStatement pstmtSelect;
    private PreparedStatement pstmtExtend;

    public void init() throws ServletException {
        try {
            initializeJdbc();
        } catch (ClassNotFoundException | SQLException ex) {
            throw new ServletException("Error initializing JDBC", ex);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("bookId"));
        String studentId = request.getParameter("studentId");
        int days = Integer.parseInt(request.getParameter("days"));

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (id != 0 && studentId != null && days > 0) {
            try {
                LocalDate newReturnDate = extendReturnDate(id, studentId, days);

                if (newReturnDate != null) {
                    out.println("<html><body>");
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Return date extended successfully! New return date: " + newReturnDate + "');");
                    out.println("window.location.href = 'extendBook.jsp';"); // Remove this line
                    out.println("</script>");
                    out.println("</body></html>");
                } else {
                    out.println("<p>Error extending return date. Book ID or Student ID may be incorrect.</p>");
                }
            } catch (SQLException | NumberFormatException ex) {
                out.println("Error: " + ex.getMessage());
                ex.printStackTrace(out);
            } finally {
                out.close();
            }
        } else {
            out.println("<p>Invalid input. Please provide Book ID, Student ID, and number of days to extend.</p>");
            out.close();
        }
    }

    private void initializeJdbc() throws ClassNotFoundException, SQLException {
        String driver = "org.apache.derby.jdbc.ClientDriver";
        String connectionString = "jdbc:derby://localhost:1527/NewUserDB;create=true;user=APP;password=app";

        Class.forName(driver);
        conn = DriverManager.getConnection(connectionString);

        pstmtSelect = conn.prepareStatement("SELECT RETURNDATE FROM RESERVEBOOK WHERE ID = ? AND STUDENTID = ?");
        pstmtExtend = conn.prepareStatement("UPDATE RESERVEBOOK SET RETURNDATE = ? WHERE ID = ? AND STUDENTID = ?");
    }

    private LocalDate extendReturnDate(int id, String studentId, int days) throws SQLException {
        pstmtSelect.setInt(1, id);
        pstmtSelect.setString(2, studentId);

        ResultSet rs = null;
        LocalDate newReturnDate = null;

        try {
            rs = pstmtSelect.executeQuery();

            if (rs.next()) {
                Date currentReturnDate = rs.getDate("RETURNDATE");
                newReturnDate = currentReturnDate.toLocalDate().plusDays(days);

                pstmtExtend.setDate(1, Date.valueOf(newReturnDate));
                pstmtExtend.setInt(2, id);
                pstmtExtend.setString(3, studentId);
                int rowsUpdated = pstmtExtend.executeUpdate();

                if (rowsUpdated <= 0) {
                    newReturnDate = null;
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
        }

        return newReturnDate;
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

