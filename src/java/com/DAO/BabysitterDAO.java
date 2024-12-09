/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.Model.Babysitter;
import java.io.InputStream;
import java.sql.*;
import java.util.*;

/**
 *
 * @author afrin
 */
public class BabysitterDAO {

    Connection con = null;
    private String jdbcURL = "jdbc:mysql://localhost:3306/babysitter";
    private String jdbcUsername = "root";
    private String jdbcPassword = "admin";

    private static final String INSERT_BABYSITTER_SQL = "INSERT INTO babysitter(babyName, babyUser, babyPass,  babyPhone, babyEmail, babyPP) VALUES (?,?,?,?,?,?)";
    private static final String SELECT_BABYSITTER_BY_ID = "SELECT babyID, babyName, babyUser, babyPass, babyPhone, babyEmail, babyPP FROM babysitter WHERE babyID=?";
    private static final String SELECT_ALL_BABYSITTERS = "SELECT * FROM babysitter";
    private static final String DELETE_BABYSITTER_SQL = "DELETE FROM babysitter WHERE babyID=?";
    private static final String UPDATE_BABYSITTER_SQL = "UPDATE babysitter SET  babyName=?, babyUser=?, babyPass=?, babyPhone=?, babyEmail=?, babyPP=? WHERE babyID=?";
    public static final String LOGIN_BABYSITTER = "SELECT * FROM babysitter WHERE babyUser=? AND babyPass=?";
    private static final String UPDATE_PROFILE = "UPDATE babysitter SET babyName=?, babyUser=?, babyPass=?,babyPhone=?, babyEmail=?, babyPP=? WHERE babyID=?";

    public BabysitterDAO() {
    }

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public void insertBabysitter(Babysitter babysitter) {
        System.out.println(INSERT_BABYSITTER_SQL);

        try (Connection connection = getConnection(); PreparedStatement prepareStatement = connection.prepareStatement(INSERT_BABYSITTER_SQL)) {
            prepareStatement.setString(1, babysitter.getBabyName());
            prepareStatement.setString(2, babysitter.getBabyUser());
            prepareStatement.setString(3, babysitter.getBabyPass());
            prepareStatement.setString(4, babysitter.getBabyPhone());
            prepareStatement.setString(5, babysitter.getBabyEmail());
            prepareStatement.setBlob(6, babysitter.getBabyPP());
            System.out.println(prepareStatement);
            prepareStatement.executeUpdate();

        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public Babysitter selectBabysitter(int babyID) {
        Babysitter babysitter = null;
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BABYSITTER_BY_ID)) {
            preparedStatement.setInt(1, babyID);
            System.out.println(preparedStatement);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                String babyName = rs.getString("babyName");
                String babyUser = rs.getString("babyUser");
                String babyPass = rs.getString("babyPass");
                String babyPhone = rs.getString("babyPhone");
                String babyEmail = rs.getString("babyEmail");
                InputStream babyPP = rs.getBinaryStream("babyPP");
                babysitter = new Babysitter(babyID, babyName, babyUser, babyPass, babyPhone, babyEmail, babyPP);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return babysitter;
    }

    public List<Babysitter> selectAllBabysitters() {
        List<Babysitter> babysitter = new ArrayList<>();
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_BABYSITTERS)) {
            System.out.println(preparedStatement);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int babyID = rs.getInt("babyID");
                String babyName = rs.getString("babyName");
                String babyUser = rs.getString("babyUser");
                String babyPass = rs.getString("babyPass");
                String babyPhone = rs.getString("babyPhone");
                String babyEmail = rs.getString("babyEmail");
                InputStream babyPP = rs.getBinaryStream("babyPP");
                babysitter.add(new Babysitter(babyID, babyName, babyUser, babyPass, babyPhone, babyEmail, babyPP));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return babysitter;
    }

    public boolean deleteBabysitter(int babyID) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(DELETE_BABYSITTER_SQL)) {
            statement.setInt(1, babyID);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean updateBabysitter(Babysitter baby) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(UPDATE_BABYSITTER_SQL)) {
            statement.setString(1, baby.getBabyName());
            statement.setString(2, baby.getBabyUser());
            statement.setString(3, baby.getBabyPass());
            statement.setString(4, baby.getBabyPhone());
            statement.setString(5, baby.getBabyEmail());
            statement.setBlob(6, baby.getBabyPP());
            statement.setInt(7, baby.getBabyID());
            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    public boolean updateProfile(Babysitter babysitter) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(UPDATE_PROFILE)) {
            statement.setString(1, babysitter.getBabyName());
            statement.setString(2, babysitter.getBabyUser());
            statement.setString(3, babysitter.getBabyPass());
            statement.setString(4, babysitter.getBabyPhone());
            statement.setString(5, babysitter.getBabyEmail());
            statement.setBlob(6, babysitter.getBabyPP());
            statement.setInt(7, babysitter.getBabyID());
            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    public Babysitter loginBabysitter(String babyUser, String babyPass) throws SQLException {
        Babysitter babysitter = null;

        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(LOGIN_BABYSITTER)) {

            preparedStatement.setString(1, babyUser);
            preparedStatement.setString(2, babyPass);

            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                int babyID = rs.getInt("babyID");
                String retrievedBabyName = rs.getString("babyName");
                String retrievedBabyUser = rs.getString("babyUser");
                String retrievedBabyPhone = rs.getString("babyPhone");
                String retrievedBabyEmail = rs.getString("babyEmail");
                InputStream retrievedBabyPP = rs.getBinaryStream("babyPP");

                babysitter = new Babysitter(babyID, retrievedBabyName, retrievedBabyUser, babyPass, retrievedBabyPhone, retrievedBabyEmail, retrievedBabyPP);
            }

        } catch (SQLException e) {
            printSQLException(e);
        }

        return babysitter;
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
