package com.yash.cabinallotment.daoimpl;

import com.yash.cabinallotment.dao.UserDAO;
import com.yash.cabinallotment.domain.Users;
import com.yash.cabinallotment.exception.UserException;
import com.yash.cabinallotment.util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl extends JDBCUtil implements UserDAO {
    @Override
    public void save(Users user) {
        String query = "INSERT INTO users(username, password, email, role) VALUES(?, ?, ?, ?);";

        try(Connection con = JDBCUtil.dbConnection();
            PreparedStatement pst = JDBCUtil.getPreparedStatement(query);) {
            pst.setString(1, user.getUsername());
            pst.setString(2, user.getPassword());
            pst.setString(3, user.getEmail());
            pst.setString(4, user.getRole());
            pst.executeUpdate(); // Execute the SQL statement
        } catch (SQLException e) {
            throw new UserException("Failed to register user: " + e.getMessage());
        }

    }

    @Override
    public boolean validateUser(String username, String password) {
        String query = "SELECT * FROM users WHERE username = ? AND password = ?;";

        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query)) {
            pst.setString(1, username);
            pst.setString(2, password);
            ResultSet resultSet = pst.executeQuery();
            return resultSet.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Return f
        }
    }

    @Override
    public Users findUserByUsername(String username) {
        String query = "SELECT * FROM users WHERE username = ?;";
        Users user = null;
        try (Connection connection = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query);) {

            pst.setString(1, username);

            try (ResultSet resultSet = pst.executeQuery()) {
                if (resultSet.next()) {
                    // Create a new Users object and populate it with data from the ResultSet
                    user = new Users();
                    user.setId(resultSet.getInt("id"));
                    user.setUsername(resultSet.getString("username"));
                    user.setPassword(resultSet.getString("password"));
                    user.setEmail(resultSet.getString("email"));
                    user.setRole(resultSet.getString("role"));
                    user.setAdminApproval(resultSet.getBoolean("adminApproval"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public void requestAdminRole(String username, String reason) throws UserException {
        String query = "UPDATE users SET adminApproval = TRUE, reason = ? WHERE username = ?";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = con.prepareStatement(query)) {
            pst.setString(1, reason);
            pst.setString(2, username);
            int rowsAffected = pst.executeUpdate();
            if (rowsAffected == 0) {
                throw new UserException("User not found or admin role already requested.");
            }
        } catch (SQLException e) {
            throw new UserException("Database error: " + e.getMessage());
        }
    }

    @Override
    public List<Users> getPendingAdminRequests() throws UserException {
        List<Users> pendingRequests = new ArrayList<>();
        String query = "SELECT * FROM users WHERE adminApproval = TRUE AND role = 'employee'"; // adminApproval = TRUE means pending

        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                Users user = new Users();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setReason(rs.getString("reason"));
                pendingRequests.add(user);
            }
        } catch (SQLException e) {
            throw new UserException("Database error: " + e.getMessage());
        }
        return pendingRequests;
    }

    @Override
    public void approveAdminRequest(int userId) throws UserException {
        String query = "UPDATE users SET role = 'admin', adminApproval = TRUE WHERE id = ?";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query)) {
            pst.setInt(1, userId);
            int rowsAffected = pst.executeUpdate();
            if (rowsAffected == 0) {
                throw new UserException("User not found or admin request already processed.");
            }
        } catch (SQLException e) {
            throw new UserException("Database error: " + e.getMessage());
        }
    }

    @Override
    public void rejectAdminRequest(int userId) throws UserException {
        String query = "UPDATE users SET adminApproval = FALSE WHERE id = ?";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query)) {
            pst.setInt(1, userId);
            int rowsAffected = pst.executeUpdate();
            if (rowsAffected == 0) {
                throw new UserException("User not found or admin request already processed.");
            }
        } catch (SQLException e) {
            throw new UserException("Database error: " + e.getMessage());
        }
    }
}
