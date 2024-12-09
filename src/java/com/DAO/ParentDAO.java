/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.DAO;

import com.Model.Parent;
import java.io.InputStream;
import java.sql.*;
import java.util.*;

/**
 *
 * @author afrin
 */
public class ParentDAO {

    Connection con = null;
    private String jdbcURL = "jdbc:mysql://localhost:3306/babysitter";
    private String jdbcUsername = "root";
    private String jdbcPassword = "admin";
    private static final String INSERT_PARENT_SQL = "INSERT INTO parent (parentName, parentUser, parentPass, parentPhone, parentEmail, parentPP) VALUES (?,?,?,?,?,?)";
    private static final String SELECT_PARENT_BY_ID = "SELECT parentID, parentName, parentUser, parentPass, parentPhone, parentEmail, parentPP FROM parent WHERE parentID=?";
    private static final String SELECT_ALL_PARENTS = "SELECT * FROM parent";
    private static final String DELETE_PARENT_SQL = "DELETE FROM parent WHERE parentID=?";
    private static final String UPDATE_PARENT_SQL = "UPDATE parent SET parentName=?, parentUser=?, parentPass=?, parentPhone=?, parentEmail=?, parentPP=? WHERE parentID=?";
    private static final String UPDATE_PROFILE = "UPDATE parent SET parentName=?, parentUser=?, parentPass=?, parentPhone=?, parentEmail=?, parentPP=? WHERE parentID=?";
    public static final String LOGIN_PARENT = "SELECT * FROM parent WHERE parentUser=? AND parentPass=?";

    public ParentDAO() {
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

    public void insertParent(Parent parent) {
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(INSERT_PARENT_SQL)) {
            preparedStatement.setString(1, parent.getParentName());
            preparedStatement.setString(2, parent.getParentUser());
            preparedStatement.setString(3, parent.getParentPass());
            preparedStatement.setString(4, parent.getParentPhone());
            preparedStatement.setString(5, parent.getParentEmail());
            preparedStatement.setBlob(6, parent.getParentPP());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public Parent selectParent(int parentID) {
        Parent parent = null;
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_PARENT_BY_ID)) {
            preparedStatement.setInt(1, parentID);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                String parentName = rs.getString("parentName");
                String parentUser = rs.getString("parentUser");
                String parentPass = rs.getString("parentPass");
                String parentPhone = rs.getString("parentPhone");
                String parentEmail = rs.getString("parentEmail");
                InputStream parentPP = rs.getBinaryStream("parentPP");
                parent = new Parent(parentID, parentName, parentUser, parentPass, parentPhone, parentEmail, parentPP);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return parent;
    }

    public List<Parent> selectAllParents() {
        List<Parent> parents = new ArrayList<>();
        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_PARENTS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int parentID = rs.getInt("parentID");
                String parentName = rs.getString("parentName");
                String parentUser = rs.getString("parentUser");
                String parentPass = rs.getString("parentPass");
                String parentPhone = rs.getString("parentPhone");
                String parentEmail = rs.getString("parentEmail");
                InputStream parentPP = rs.getBinaryStream("parentPP");
                parents.add(new Parent(parentID, parentName, parentUser, parentPass,  parentPhone, parentEmail, parentPP));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return parents;
    }

    public boolean deleteParent(int parentID) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(DELETE_PARENT_SQL)) {
            statement.setInt(1, parentID);
            rowDeleted = statement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean updateParent(Parent parent) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(UPDATE_PARENT_SQL)) {
            statement.setString(1, parent.getParentName());
            statement.setString(2, parent.getParentUser());
            statement.setString(3, parent.getParentPass());
            statement.setString(4, parent.getParentPhone());
            statement.setString(5, parent.getParentEmail());
            statement.setBlob(6, parent.getParentPP());
            statement.setInt(7, parent.getParentID());
            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    public boolean updateProfile(Parent parent) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(UPDATE_PROFILE)) {
            statement.setString(1, parent.getParentName());
            statement.setString(2, parent.getParentUser());
            statement.setString(3, parent.getParentPass());
            statement.setString(4, parent.getParentPhone());
            statement.setString(5, parent.getParentEmail());
            statement.setBlob(6, parent.getParentPP());
            statement.setInt(7, parent.getParentID());
            rowUpdated = statement.executeUpdate() > 0;
        }
        return rowUpdated;
    }

    public Parent loginParent(String parentUser, String parentPass) throws SQLException {
        Parent parent = null;

        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(LOGIN_PARENT)) {

            preparedStatement.setString(1, parentUser);
            preparedStatement.setString(2, parentPass);

            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                int parentID = rs.getInt("parentID");
                String retrievedParentName = rs.getString("parentName");
                String retrievedParentUser = rs.getString("parentUser");
                String retrievedParentPhone = rs.getString("parentPhone");
                String retrievedParentEmail = rs.getString("parentEmail");
                InputStream retrievedParentPP = rs.getBinaryStream("parentPP");

                parent = new Parent(parentID, retrievedParentName, retrievedParentUser, parentPass, retrievedParentPhone, retrievedParentEmail, retrievedParentPP);
            }

        } catch (SQLException e) {
            printSQLException(e);
        }

        return parent;
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
