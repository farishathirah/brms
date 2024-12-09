package com.DAO;

import com.Model.Booking;
import com.Model.AppliedJob;
import java.io.InputStream;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    private String jdbcURL = "jdbc:mysql://localhost:3306/babysitter";
    private String jdbcUsername = "root";
    private String jdbcPassword = "admin";

    private static final String INSERT_BOOKING_SQL = "INSERT INTO booking (parentID, bookingDesc, bookingAddress, bookingCity, bookingState, bookingZip, bookingReward, dateCreated, date, startTime, endTime) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
    private static final String SELECT_BOOKING_BY_ID = "SELECT bookingID, parentID, bookingDesc, bookingType, bookingAddress, bookingCity, bookingState, bookingZip, bookingReward, dateCreated, date, startTime, endTime FROM booking WHERE bookingID=?";
    private static final String SELECT_ALL_BOOKING = "SELECT * FROM booking";
    private static final String DELETE_BOOKING_SQL = "DELETE FROM booking WHERE bookingID=?";
    private static final String UPDATE_BOOKING_SQL = "UPDATE booking SET parentID=?, bookingDesc=?, bookingType=?, bookingAddress=?, bookingCity=?, bookingState=?, bookingZip=?, bookingReward=?, dateCreated=?, date=?, startTime=?, endTime=?  WHERE bookingID=?";
    private static final String DELETE_APPLICATION_SQL = "DELETE FROM booking WHERE applicationID = ?";

    public BookingDAO() {
    }

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public void insertBooking(Booking booking) {
        System.out.println(INSERT_BOOKING_SQL);
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(INSERT_BOOKING_SQL)) {
            preparedStatement.setInt(1, booking.getParentID());
            preparedStatement.setString(2, booking.getBookingDesc());
            preparedStatement.setString(3, booking.getBookingAddress());
            preparedStatement.setString(4, booking.getBookingCity());
            preparedStatement.setString(5, booking.getBookingState());
            preparedStatement.setString(6, booking.getBookingZip());
            preparedStatement.setBigDecimal(7, booking.getBookingReward());
            preparedStatement.setString(8, booking.getDateCreated());
            preparedStatement.setString(9, booking.getDate());
            preparedStatement.setString(10, booking.getStartTime());
            preparedStatement.setString(11, booking.getEndTime());
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public Booking selectBooking(int bookingID) {
        Booking booking = null;
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BOOKING_BY_ID)) {
            preparedStatement.setInt(1, bookingID);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int parentID = rs.getInt("parentID");
                String bookingDesc = rs.getString("bookingDesc");
                String bookingAddress = rs.getString("bookingAddress");
                String bookingCity = rs.getString("bookingCity");
                String bookingState = rs.getString("bookingState");
                String bookingZip = rs.getString("bookingZip");
                BigDecimal bookingReward = rs.getBigDecimal("bookingReward");
                String dateCreated = rs.getString("dateCreated");
                String date = rs.getString("date");
                String startTime = rs.getString("startTime");
                String endTime = rs.getString("endTime");
                booking = new Booking(bookingID, parentID, bookingDesc, bookingAddress, bookingCity, bookingState, bookingZip, bookingReward, dateCreated, date, startTime, endTime);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return booking;
    }

    public List<Booking> selectAllBookings() {
        List<Booking> bookingList = new ArrayList<>();
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_BOOKING)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int bookingID = rs.getInt("bookingID");
                int parentID = rs.getInt("parentID");
                String bookingDesc = rs.getString("bookingDesc");
                String bookingAddress = rs.getString("bookingAddress");
                String bookingCity = rs.getString("bookingCity");
                String bookingState = rs.getString("bookingState");
                String bookingZip = rs.getString("bookingZip");
                BigDecimal bookingReward = rs.getBigDecimal("bookingReward");
                String dateCreated = rs.getString("dateCreated");
                String date = rs.getString("date");
                String startTime = rs.getString("startTime");
                String endTime = rs.getString("endTime");
                bookingList.add(new Booking(bookingID, parentID, bookingDesc, bookingAddress, bookingCity, bookingState, bookingZip, bookingReward, dateCreated, date, startTime, endTime));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return bookingList;
    }

    public boolean deleteBooking(int bookingID) {
        boolean rowDeleted = false;
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(DELETE_BOOKING_SQL)) {
            statement.setInt(1, bookingID);
            rowDeleted = statement.executeUpdate() > 0;
        } catch (SQLException e) {
            printSQLException(e);
        }
        return rowDeleted;
    }

    public boolean updateBooking(Booking booking) throws SQLException {
        boolean rowUpdated = false;
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(UPDATE_BOOKING_SQL)) {
            statement.setInt(1, booking.getParentID());
            statement.setString(2, booking.getBookingDesc());
            statement.setString(3, booking.getBookingAddress());
            statement.setString(4, booking.getBookingCity());
            statement.setString(5, booking.getBookingState());
            statement.setString(6, booking.getBookingZip());
            statement.setBigDecimal(7, booking.getBookingReward());
            statement.setString(8, booking.getDateCreated());
            statement.setString(9, booking.getDate());
            statement.setString(10, booking.getStartTime());
            statement.setString(11, booking.getEndTime());
            statement.setInt(12, booking.getBookingID());
            rowUpdated = statement.executeUpdate() > 0;
        } catch (SQLException e) {
            printSQLException(e);
        }
        return rowUpdated;
    }

    public boolean applyForBooking(int applicationID, int bookingID, int babyID, Timestamp applicationDate, String applyStatus, String bookingStatus) {
        Connection connection = null;
        PreparedStatement statement = null;
        boolean success = false;

        try {
            // Establish connection and prepare statement
            connection = getConnection();
            String query = "INSERT INTO AppliedBooking (applicationID, bookingID, babyID, applicationDate, applyStatus, bookingStatus) VALUES ( ?, ?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(query);
            statement.setInt(1, applicationID);
            statement.setInt(2, bookingID);
            statement.setInt(3, babyID);
            statement.setTimestamp(4, applicationDate);
            statement.setString(5, applyStatus);
            statement.setString(6, bookingStatus);

            // Execute the query
            int rowsAffected = statement.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close connections
            try {
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return success;
    }

    public boolean hasApplied(int bookingID, int babyID) throws SQLException {
        String jdbcUrl = "jdbc:mysql://localhost:3306/babysitter";
        String dbUser = "root";
        String dbPassword = "admin";
        boolean applied = false;
        String sql = "SELECT COUNT(*) AS count FROM appliedbooking WHERE bookingID = ? AND babyID = ?";

        try (Connection con = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword); PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, bookingID);
            stmt.setInt(2, babyID);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt("count");
                    if (count > 0) {
                        applied = true; // Booking seeker has already applied for this booking
                    }
                }
            }
        }

        return applied;
    }

    public static boolean withdrawApplication(int applicationID) {
        String jdbcUrl = "jdbc:mysql://localhost:3306/babysitter";
        String dbUser = "root";
        String dbPassword = "";

        try (Connection con = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
            String sql = "UPDATE AppliedBooking SET applyStatus = 'Withdrawn' WHERE applicationID = ?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, applicationID);
                int rowsUpdated = ps.executeUpdate();
                return rowsUpdated > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteApplication(int applicationID) {
        boolean rowDeleted = false;
        try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(DELETE_APPLICATION_SQL)) {
            ps.setInt(1, applicationID);
            rowDeleted = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            printSQLException(e);
        }
        return rowDeleted;
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
