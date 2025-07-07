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

@WebServlet("/ManageBook")
public class ManageBook extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Connection conn;
    private PreparedStatement pstmtGetBooks;
    private PreparedStatement pstmtDeleteBook;
    private PreparedStatement pstmtAddBook;

    public void init() throws ServletException {
        try {
            initializeJdbc();
        } catch (ClassNotFoundException | SQLException ex) {
            throw new ServletException("Error initializing JDBC", ex);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            handleDelete(request, response);
        } else {
            handleListBooks(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String action = request.getParameter("action");
    if ("add".equals(action)) {
        handleAddBook(request, response);
    }
}


    private void handleListBooks(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String view = request.getParameter("view");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            ResultSet rs = getBooks();
            out.println("<table>");
            out.println("<tr>");
            out.println("<th>ID</th>");
            out.println("<th>Title</th>");
            out.println("<th>Author</th>");
            out.println("<th>Publication Year</th>");
            out.println("<th>Genre</th>");
            out.println("<th>Status</th>");
            if ("catalog".equals(view)) {
                out.println("<th>Action</th>");
            }
            out.println("</tr>");
            while (rs.next()) {
                int id = rs.getInt("ID");
                String title = rs.getString("TITLE");
                String author = rs.getString("AUTHOR");
                int year = rs.getInt("PUBLICATION_YEAR");
                String genre = rs.getString("GENRE");
                String status = rs.getString("STATUS");

                out.println("<tr>");
                out.println("<td>" + id + "</td>");
                out.println("<td>" + title + "</td>");
                out.println("<td>" + author + "</td>");
                out.println("<td>" + year + "</td>");
                out.println("<td>" + genre + "</td>");
                out.println("<td>" + status + "</td>");
                
                if ("catalog".equals(view)) {
                    out.println("<td><button onclick='deleteBook(" + id + ")'>Delete</button></td>");
                }

                out.println("</tr>");
            }
            out.println("</table>");
        } catch (SQLException ex) {
            out.println("Database error: " + ex.getMessage());
            ex.printStackTrace(out);
        } finally {
            out.close();
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int idToDelete = Integer.parseInt(request.getParameter("idToDelete"));
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            deleteBook(idToDelete);
            out.println("Book successfully deleted");
        } catch (SQLException ex) {
            out.println("Database error: " + ex.getMessage());
            ex.printStackTrace(out);
        } finally {
            out.close();
        }
    }

    private void handleAddBook(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        int publicationYear = Integer.parseInt(request.getParameter("publicationYear"));
        String genre = request.getParameter("genre");
        String status = request.getParameter("status");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            addBook(bookId, title, author, publicationYear, genre, status);
            out.println("<html><body>");
            out.println("<script type='text/javascript'>");
            out.println("alert('Book successfully added.');");
            out.println("window.location.href = 'catalog.jsp';");
            out.println("</script>");
            out.println("</body></html>");
        } catch (SQLException ex) {
            out.println("Database error: " + ex.getMessage());
            ex.printStackTrace(out);
        } finally {
            out.close();
        }
    }

    private void initializeJdbc() throws ClassNotFoundException, SQLException {
        String driver = "org.apache.derby.jdbc.ClientDriver";
        String connectionString = "jdbc:derby://localhost:1527/NewUserDB;create=true;user=APP;password=app";

        Class.forName(driver);
        conn = DriverManager.getConnection(connectionString);
        pstmtGetBooks = conn.prepareStatement("SELECT * FROM NEWBOOK");
        pstmtDeleteBook = conn.prepareStatement("DELETE FROM NEWBOOK WHERE ID = ?");
        pstmtAddBook = conn.prepareStatement("INSERT INTO NEWBOOK (ID, TITLE, AUTHOR, PUBLICATION_YEAR, GENRE, STATUS) VALUES (?, ?, ?, ?, ?, ?)");
    }

    private ResultSet getBooks() throws SQLException {
        return pstmtGetBooks.executeQuery();
    }

    private void deleteBook(int id) throws SQLException {
        pstmtDeleteBook.setInt(1, id);
        pstmtDeleteBook.executeUpdate();
    }

    private void addBook(int bookId, String title, String author, int publicationYear, String genre, String status) throws SQLException {
        pstmtAddBook.setInt(1, bookId);
        pstmtAddBook.setString(2, title);
        pstmtAddBook.setString(3, author);
        pstmtAddBook.setInt(4, publicationYear);
        pstmtAddBook.setString(5, genre);
        pstmtAddBook.setString(6, status);
        pstmtAddBook.executeUpdate();
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
