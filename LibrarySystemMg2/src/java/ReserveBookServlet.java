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

@WebServlet("/ReserveBookServlet")
public class ReserveBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int DUE_PERIOD_DAYS = 14;
    private Connection conn;
    private PreparedStatement pstmtReserve;
    private PreparedStatement pstmtGetReservations;

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

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (id != 0 && studentId != null) {
            try {
                LocalDate reservationDate = LocalDate.now();
                LocalDate returnDate = reservationDate.plusDays(DUE_PERIOD_DAYS);
                int result = reserveBook(id, studentId, reservationDate, returnDate);

                if (result > 0) {
                    out.println("<html><body>");
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Book reserved successfully!');");
                    out.println("window.location.href = 'reserveBook.jsp';");
                    out.println("</script>");
                    out.println("</body></html>");
                } else {
                    out.println("<html><body>");
                    out.println("<script type='text/javascript'>");
                    out.println("alert('Error reserving book. Book ID may not exist.');");
                    out.println("window.location.href = 'reserveBook.jsp';");
                    out.println("</script>");
                    out.println("</body></html>");
                }
            } catch (SQLException | NumberFormatException ex) {
                out.println("Error: " + ex.getMessage());
                ex.printStackTrace(out);
            } finally {
                out.close();
            }
        } else {
            out.println("<p>Invalid input. Please provide both Book ID and your Student ID.</p>");
            out.close();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if ("view".equals(action)) {
            try {
                ResultSet rs = getReservations();

                out.println("<table>");
                out.println("<tr><th>ID</th><th>Student ID</th><th>Reservation Date</th><th>Return Date</th></tr>");

                while (rs.next()) {
                    int id = rs.getInt("ID");
                    String studentId = rs.getString("STUDENTID");
                    Date reservationDate = rs.getDate("RESERVATIONDATE");
                    Date returnDate = rs.getDate("RETURNDATE");

                    out.println("<tr>");
                    out.println("<td>" + id + "</td>");
                    out.println("<td>" + studentId + "</td>");
                    out.println("<td>" + reservationDate + "</td>");
                    out.println("<td>" + returnDate + "</td>");
                    out.println("</tr>");
                }

                out.println("</table>");
            } catch (SQLException ex) {
                out.println("Database error: " + ex.getMessage());
                ex.printStackTrace(out);
            } finally {
                out.close();
            }
        } else {
            out.println("<p>Invalid action.</p>");
            out.close();
        }
    }

    private void initializeJdbc() throws ClassNotFoundException, SQLException {
        String driver = "org.apache.derby.jdbc.ClientDriver";
        String connectionString = "jdbc:derby://localhost:1527/NewUserDB;create=true;user=APP;password=app";

        Class.forName(driver);
        conn = DriverManager.getConnection(connectionString);

        pstmtReserve = conn.prepareStatement("INSERT INTO RESERVEBOOK (ID, STUDENTID, RESERVATIONDATE, RETURNDATE) VALUES (?, ?, ?, ?)");
        pstmtGetReservations = conn.prepareStatement("SELECT * FROM RESERVEBOOK");
    }

    private int reserveBook(int id, String studentId, LocalDate reservationDate, LocalDate returnDate) throws SQLException {
        pstmtReserve.setInt(1, id);
        pstmtReserve.setString(2, studentId);
        pstmtReserve.setDate(3, Date.valueOf(reservationDate));
        pstmtReserve.setDate(4, Date.valueOf(returnDate));
        return pstmtReserve.executeUpdate();
    }

    private ResultSet getReservations() throws SQLException {
        return pstmtGetReservations.executeQuery();
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
