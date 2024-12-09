package com.WEB;

import com.DAO.BookingDAO;
import com.Model.Booking;
import com.Model.AppliedJob;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class BookingServlet extends HttpServlet {

    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "tnew":
                    showNewForm(request, response);
                    break;

                case "tinsert":
                    insertBooking(request, response);
                    break;

                case "tdelete":
                    deleteBooking(request, response);
                    break;

                case "tedit":
                    showEditForm(request, response);
                    break;

                case "tupdate":
                    updateBooking(request, response);
                    break;

                case "tapply":
                    applyBooking(request, response);
                    break;

                case "twithdraw":
                    withdrawApplication(request, response);
                    break;
                case "tdeleteapply":
                    deleteApplication(request, response);
                    break;
                case "tlist":
                    listBooking(request, response);
                    break;

            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listBooking(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Booking> listBooking = bookingDAO.selectAllBookings();
        request.setAttribute("listBooking", listBooking);
        RequestDispatcher dispatcher = request.getRequestDispatcher("BookingList.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("BookingForm.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int bookingID = Integer.parseInt(request.getParameter("bookingID"));
        Booking existingBooking = bookingDAO.selectBooking(bookingID);
        RequestDispatcher dispatcher = request.getRequestDispatcher("BookingForm.jsp");
        request.setAttribute("booking", existingBooking);
        dispatcher.forward(request, response);
    }

    private void insertBooking(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int parentID = Integer.parseInt(request.getParameter("parentID"));
        String bookingDesc = request.getParameter("bookingDesc");
        String bookingAddress = request.getParameter("bookingAddress");
        String bookingCity = request.getParameter("bookingCity");
        String bookingState = request.getParameter("bookingState");
        String bookingZip = request.getParameter("bookingZip");
        BigDecimal bookingReward = new BigDecimal(request.getParameter("bookingReward"));
        String dateCreated = request.getParameter("dateCreated");
        String date = request.getParameter("date");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        HttpSession session = request.getSession();
        Booking newBooking = new Booking(parentID, bookingDesc, bookingAddress, bookingCity, bookingState, bookingZip, bookingReward, dateCreated, date, startTime, endTime);
        session.setAttribute("parentID", parentID);
        session.setAttribute("redirect", "true");
        bookingDAO.insertBooking(newBooking);
        response.sendRedirect("BookingServlet?action=tlist");
    }

    private void updateBooking(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int bookingID = Integer.parseInt(request.getParameter("bookingID"));
        int parentID = Integer.parseInt(request.getParameter("parentID"));
        String bookingDesc = request.getParameter("bookingDesc");
        String bookingAddress = request.getParameter("bookingAddress");
        String bookingCity = request.getParameter("bookingCity");
        String bookingState = request.getParameter("bookingState");
        String bookingZip = request.getParameter("bookingZip");
        BigDecimal bookingReward = new BigDecimal(request.getParameter("bookingReward"));
        String dateCreated = request.getParameter("dateCreated");
        String date = request.getParameter("date");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        Booking booking = new Booking(bookingID, parentID, bookingDesc, bookingAddress, bookingCity, bookingState, bookingZip, bookingReward, dateCreated, date, startTime, endTime);
        bookingDAO.updateBooking(booking);
        response.sendRedirect("BookingList.jsp");
    }

    private void deleteBooking(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int bookingID = Integer.parseInt(request.getParameter("bookingID"));
        bookingDAO.deleteBooking(bookingID);
        response.sendRedirect("BookingServlet?action=tlist");
    }
    
     private void deleteApplication(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int applicationID = Integer.parseInt(request.getParameter("applicationID"));
        boolean success = bookingDAO.deleteApplication(applicationID);
        response.setStatus(success ? HttpServletResponse.SC_OK : HttpServletResponse.SC_BAD_REQUEST);
    }

    private static final Logger LOGGER = Logger.getLogger(BookingServlet.class.getName());

    protected void applyBooking(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            // Get jobID and jobSeekerID from request parameters
            int bookingID = Integer.parseInt(request.getParameter("bookingID"));
            int babyID = Integer.parseInt(request.getParameter("babyID"));
            String applyStatus = request.getParameter("applyStatus");
            String bookingStatus = request.getParameter("bookingStatus");

            // Check if job seeker has already applied for this job
            BookingDAO bookingDAO = new BookingDAO();
            boolean alreadyApplied = bookingDAO.hasApplied(bookingID, babyID);

            if (alreadyApplied) {
                // Booking seeker has already applied for this job
                session.setAttribute("errorMessage", "You have already applied for this job.");
                response.sendRedirect("ApplyBooking.jsp");
                return; // Stop further processing
            }

            // Generate applicationID (Implement this method as per your requirements)
            int applicationID = generateApplicationID();

            // Get current timestamp
            Timestamp applicationDate = new Timestamp(System.currentTimeMillis());


            // Apply for the job
            boolean success = bookingDAO.applyForBooking(applicationID, bookingID, babyID, applicationDate, applyStatus, bookingStatus);

            // Redirect to appropriate page based on success/failure
            if (success) {
                session.setAttribute("successMessage", "Booking application submitted successfully!");
                response.sendRedirect("BookingHistory.jsp");
            } else {
                session.setAttribute("errorMessage", "Failed to apply for the job. Please try again.");
                response.sendRedirect("ApplyBooking.jsp");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error applying for job", e);
            session.setAttribute("errorMessage", "An error occurred while applying for the job. Please try again later.");
            response.sendRedirect("error.jsp");
        }
    }

    private void withdrawApplication(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int applicationID = Integer.parseInt(request.getParameter("applicationID"));

        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/babysitter", "root", "admin");
            PreparedStatement ps = conn.prepareStatement("UPDATE appliedjob SET applyStatus = ? WHERE applicationID = ?");
            ps.setString(1, "Withdrawn");
            ps.setInt(2, applicationID);

            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to withdraw application");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "SQL Error: " + e.getMessage());
        }
    }

// Method to generate a unique applicationID (example)
    private int generateApplicationID() {
        // Your implementation to generate a unique applicationID
        // For simplicity, let's assume it's just a random number
        return (int) (Math.random() * 100);
    }

}
