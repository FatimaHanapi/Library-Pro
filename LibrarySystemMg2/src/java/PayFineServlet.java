import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/PayFineServlet")
public class PayFineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final double FINE_RATE = 0.50;
    private Connection conn;
    private PreparedStatement pstmtSelect;
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
        String studentId = request.getParameter("studentId");
        int id = Integer.parseInt(request.getParameter("bookId"));

        try {
            double fine = calculateFine(studentId, id);
            processFinePayment(studentId, id, fine);
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html><body>");
            out.println("<h2>Fine Payment</h2>");
            out.println("<script type='text/javascript'>");
            out.println("alert('Payment Successful!');");
            out.println("window.location.href = 'homeStudent.jsp';");
            out.println("</script>");
            out.println("</body></html>");
            
                    
                    
        } catch (SQLException ex) {
            throw new ServletException("Error processing fine payment", ex);
        }

    }

    private void initializeJdbc() throws ClassNotFoundException, SQLException {
        String driver = "org.apache.derby.jdbc.ClientDriver";
        String connectionString = "jdbc:derby://localhost:1527/NewUserDB;create=true;user=APP;password=app";
        
        Class.forName(driver);
        conn = DriverManager.getConnection(connectionString);
        
        pstmtSelect = conn.prepareStatement("SELECT RETURNDATE FROM RESERVEBOOK WHERE STUDENTID=? AND ID=?");
        pstmtUpdate = conn.prepareStatement("UPDATE FINE SET FINEAMOUNT = ?, PAYMENTSTATUS = 'PAID' WHERE ID = ? AND STUDENTID = ?");
    }

    private double calculateFine(String studentId, int id) throws SQLException {
        pstmtSelect.setString(1, studentId);
        pstmtSelect.setInt(2, id);
        ResultSet rs = null;

        try {
            rs = pstmtSelect.executeQuery();
        
            if (rs.next()) {
                Date returnDate = rs.getDate("RETURNDATE");
                LocalDate dueDate = returnDate.toLocalDate();
                LocalDate actualReturnDate = LocalDate.now();
                
                long daysLate = ChronoUnit.DAYS.between(dueDate, actualReturnDate);
                if (daysLate > 0) {
                    return daysLate * FINE_RATE; // Fine is $0.50 per day late
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
        }
        return 0.0;
    }

    private void processFinePayment(String studentId, int id, double fine) throws SQLException {
        pstmtUpdate.setDouble(1, fine);
        pstmtUpdate.setInt(2, id);
        pstmtUpdate.setString(3, studentId);
        pstmtUpdate.executeUpdate();
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
