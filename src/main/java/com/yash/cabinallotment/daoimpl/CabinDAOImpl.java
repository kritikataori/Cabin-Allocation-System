package com.yash.cabinallotment.daoimpl;

import com.yash.cabinallotment.dao.CabinDAO;
import com.yash.cabinallotment.domain.Cabins;
import com.yash.cabinallotment.exception.CabinException;
import com.yash.cabinallotment.exception.CabinRequestException;
import com.yash.cabinallotment.util.JDBCUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CabinDAOImpl extends JDBCUtil implements CabinDAO {
    @Override
    public List<Cabins> getAllCabins() {
        List<Cabins> allCabins = new ArrayList<>();
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
                cabin.setCabinImageUrl(resultSet.getString("imageUrl"));
                if ("occupied".equals(cabin.getStatus())) {
                    Time nextAvailableTime = getNextAvailableTime(cabin.getId());
                    cabin.setNextAvailableTime(nextAvailableTime);
                }
                allCabins.add(cabin);
                System.out.println("Adding cabin: " + cabin.getName());
            }
            System.out.println("cabins size: " + allCabins.size());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return allCabins;
    }

    private Time getNextAvailableTime(int cabinId) {
        String timeQuery = "SELECT MIN(end_time) FROM allocations WHERE assigned_cabin_id = ? AND end_time > NOW()";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = con.prepareStatement(timeQuery)) {
            pst.setInt(1, cabinId);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return rs.getTime(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Cabins> getAvailableCabins() {
        List<Cabins> availableCabins = new ArrayList<>();
        String query = "SELECT * FROM cabins WHERE status = 'available'";

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
                cabin.setCabinImageUrl(resultSet.getString("imageUrl"));
                availableCabins.add(cabin);
                System.out.println("Adding cabin: " + cabin.getName());
            }
            System.out.println("cabins size: " + availableCabins.size());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return availableCabins;
    }

    @Override
    public void createCabin(Cabins cabin) {
        String query = "INSERT INTO cabins(name, capacity, status, imageUrl) VALUES(?,?,?,?);";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query);) {
            pst.setString(1, cabin.getName());
            pst.setInt(2, cabin.getCapacity());
            pst.setString(3, cabin.getStatus());
            pst.setString(4, cabin.getCabinImageUrl());
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void updateCabin(Cabins cabin) {
        String query = "UPDATE cabins SET name = ?, capacity = ?, status = ?, imageUrl = ? WHERE id = ?";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query);) {
            pst.setString(1, cabin.getName());
            pst.setInt(2, cabin.getCapacity());
            pst.setString(3, cabin.getStatus());
            pst.setString(4, cabin.getCabinImageUrl());
            pst.setInt(5, cabin.getId());
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

    @Override
    public Cabins getCabinById(int cabinId) throws CabinRequestException {
        String query = "SELECT * FROM Cabins WHERE id = ?";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query)) {
            pst.setInt(1, cabinId);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return new Cabins(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getInt("capacity"),
                    rs.getString("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new CabinRequestException("Error fetching cabin by ID");
        }
        return null;
    }

    @Override
    public void updateCabinStatus(int cabinId, String status) {
        String query = "UPDATE cabins SET status = ? WHERE id = ?";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query)) {
            pst.setString(1, status);
            pst.setInt(2, cabinId);
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new CabinException("Failed to change cabin status", e);
        }
    }

    @Override
    public List<Cabins> getAvailableFilteredCabins(java.sql.Date reqDate, Time startTime, Time endTime) {
        List<Cabins> availableFilteredCabins = new ArrayList<>();
        String query = "SELECT c.*, (SELECT MIN(a.end_time) FROM allocations a WHERE a.assigned_cabin_id = c.id AND a.end_time > ?) AS next_available_time FROM cabins c WHERE c.status = 'available' AND NOT EXISTS (SELECT 1 FROM allocations a WHERE a.assigned_cabin_id = c.id AND a.start_time < ? AND a.end_time > ?)";

        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = con.prepareStatement(query)) {
            pst.setTime(1, Time.valueOf(java.time.LocalTime.now())); // Current time
            pst.setTime(2, endTime);
            pst.setTime(3, startTime);
            ResultSet resultSet = pst.executeQuery();

            while (resultSet.next()) {
                Cabins cabin = new Cabins();
                cabin.setId(resultSet.getInt("id"));
                cabin.setName(resultSet.getString("name"));
                cabin.setCapacity(resultSet.getInt("capacity"));
                cabin.setStatus(resultSet.getString("status"));
                cabin.setNextAvailableTime(resultSet.getTime("next_available_time"));
                cabin.setCabinImageUrl(resultSet.getString("imageUrl"));
                availableFilteredCabins.add(cabin);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return availableFilteredCabins;
    }
}

