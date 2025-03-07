package com.yash.cabinallotment.test;

import com.yash.cabinallotment.util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DbConnectionTest extends JDBCUtil {
    public static void main(String[] args) {
        Connection con = null;
        PreparedStatement pst = null;
        try {
            con = dbConnection();
            System.out.println("Database connected successfully.");

            String query = "DELETE FROM users WHERE username = ?";
            pst = getPreparedStatement(query);
            pst.setString(1,"Palak");
            int rowsAffected = pst.executeUpdate();
            System.out.println(rowsAffected + " row(s) affected");
        } catch (SQLException e) {
            System.err.println("Error connecting to the database: " + e.getMessage());
        } finally {
            closeConnection(con);
        }
    }
}
