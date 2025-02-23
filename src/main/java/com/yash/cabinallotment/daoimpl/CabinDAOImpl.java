package com.yash.cabinallotment.daoimpl;

import com.yash.cabinallotment.dao.CabinDAO;
import com.yash.cabinallotment.domain.Cabins;
import com.yash.cabinallotment.util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CabinDAOImpl extends JDBCUtil implements CabinDAO {
    @Override
    public List<Cabins> getAllCabins() {
        List<Cabins> availableCabins = new ArrayList<>();
        String query = "SELECT * FROM cabins;";

        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query);
             ResultSet resultSet = pst.executeQuery()) {

            System.out.println("Query executed: " + query);

            while (resultSet.next()) {
                Cabins cabin = new Cabins();
                cabin.setId(resultSet.getInt("id"));
                cabin.setName(resultSet.getString("name"));
                cabin.setCapacity(resultSet.getInt("capacity"));
                cabin.setStatus(resultSet.getString("status"));
                availableCabins.add(cabin);

                System.out.println("Adding cabin: " + cabin.getName());
            }
            System.out.println("Available cabins size: " + availableCabins.size()); // Add this line
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return availableCabins;
    }

    @Override
    public void createCabin(Cabins cabin) {
        String query = "INSERT INTO cabins(name, capacity, status) VALUES(?,?,?);";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query);) {
            pst.setString(1, cabin.getName());
            pst.setInt(2, cabin.getCapacity());
            pst.setString(3, cabin.getStatus());
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateCabin(Cabins cabin) {
        String query = "UPDATE cabins SET name = ?, capacity = ?, status = ? WHERE id = ?";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query);) {
            pst.setString(1, cabin.getName());
            pst.setInt(2, cabin.getCapacity());
            pst.setString(3, cabin.getStatus());
            pst.setInt(4, cabin.getId());
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteCabin(int cabinId) {
        String query = "DELETE FROM cabins WHERE id = ?;";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query);){
            pst.setInt(1, cabinId);
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getCabinNameById(int cabinId) {
        String query = "SELECT name FROM cabins WHERE id = ?";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = con.prepareStatement(query)) {
            pst.setInt(1, cabinId);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return rs.getString("name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

