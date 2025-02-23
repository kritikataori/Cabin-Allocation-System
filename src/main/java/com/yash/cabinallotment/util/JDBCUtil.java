package com.yash.cabinallotment.util;

import java.sql.*;

public class JDBCUtil {

    private final static String URL = "jdbc:mysql://localhost:3306/cabinallotment";
    private final static String USER = "root";
    private final static String PASSWORD = "root";

    /** establish the connection */
    public static Connection dbConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            /**
             * Wrapping the exception properly:
             * - If the MySQL JDBC driver is missing, ClassNotFoundException is thrown.
             * - Instead of just printing the stack trace (which hides the issue),
             *   we rethrow it as a new SQLException with a meaningful message.
             * - If we only print the exception and return nothing, then the method will return null
             *   instead of a connection. This can cause NullPointerException.
             *   So, we avoid this by throwing SQLException.
             * - We also pass the original exception (e) to preserve debugging details.
             */
            throw new SQLException("JDBC Driver not found", e);
        }
    }

    /** close the connection */
    public static void closeConnection(Connection con) {
        if (con != null) {
            try {
                con.close();
                System.out.println("Database connection closed");
            } catch (SQLException e) {
                System.err.println("Error while closing the connection: " + e.getMessage());
            }
        }
    }

    /** create a statement to execute queries */
    public static int getStatement(String query) throws SQLException {
        if(query == null || query.trim().isEmpty()) {
            throw new SQLException("Query is empty or null");
        }
        Connection con = null;
        Statement st = null;
        try {
            con = dbConnection();
            st = con.createStatement();
            return st.executeUpdate(query);
        } catch (SQLException e) {
            throw new SQLException("Error creating statement. " + e.getMessage(), e);
        } finally {
            st.close();
        }
    }

    /** create a prepared statement
     * - This method is responsible for creating a PreparedStatement using the database connection.
     * - This method allows us to prepare a query, set its parameters,
     *   and return the PreparedStatement object for execution.
     * - PreparedStatement helps prevent SQL injection attacks by separating SQL logic from user input.
     * - It also improves performance, as the query is precompiled
     * - can be reused with different parameters.
     */
     /*public static PreparedStatement getPreparedStatement(String query, Object... params) throws SQLException {
            Connection con = null;
            PreparedStatement pst = null;
            try {
                con = dbConnection();
                pst = con.prepareStatement(query);

                // Set parameters to corresponding placeholders (?) in the PreparedStatement
                for(int i = 0; i < params.length; i++){
                    //to bind the parameter value to the PreparedStatement.
                    //i+1 because preparedStatements are 1-indexed
                    pst.setObject(i+1, params[i]);
                }
                return pst;
            } catch (SQLException e) {
                throw new SQLException("Error creating statement. "+e.getMessage());
            }
     }*/
    public static PreparedStatement getPreparedStatement(String query) throws SQLException {
        Connection con = null;
        PreparedStatement pst = null;
        try {
            con = dbConnection();
            pst = con.prepareStatement(query);
            return pst;
        } catch (SQLException e) {
            throw new SQLException("Error creating statement. "+e.getMessage());
        }
    }

}
