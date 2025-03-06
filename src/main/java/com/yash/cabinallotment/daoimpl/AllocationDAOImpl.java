package com.yash.cabinallotment.daoimpl;

import com.yash.cabinallotment.dao.AllocationDAO;
import com.yash.cabinallotment.domain.Allocations;
import com.yash.cabinallotment.util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AllocationDAOImpl extends JDBCUtil implements AllocationDAO {

    @Override
    public List<Allocations> getCurrentAllocations() {
        List<Allocations> allocations = new ArrayList<>();
        String query = "SELECT a.*, u.username AS employee_name, COALESCE(ac.name, c.name) AS cabin_name " +
                "FROM Allocations a " +
                "JOIN Users u ON a.employee_id = u.id " +
                "JOIN Cabins c ON a.cabin_id = c.id " +
                "LEFT JOIN Cabins ac ON a.assigned_cabin_id = ac.id "+
                "WHERE a.status = 'active'";

        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query);
             ResultSet resultSet = pst.executeQuery()) {

            while (resultSet.next()) {
                Allocations allocation = new Allocations();
                allocation.setId(resultSet.getInt("id"));
                allocation.setRequestId(resultSet.getInt("request_id"));
                allocation.setCabinId(resultSet.getInt("cabin_id"));
                allocation.setEmployeeId(resultSet.getInt("employee_id"));
                allocation.setStartTime(resultSet.getTime("start_time"));
                allocation.setEndTime(resultSet.getTime("end_time"));
                allocation.setCabinName(resultSet.getString("cabin_name"));
                allocation.setEmployeeName(resultSet.getString("employee_name"));
                allocations.add(allocation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return allocations;
    }

    @Override
    public void addAllocation(Allocations allocation) {
        String query = "INSERT INTO allocations (request_id, cabin_id, employee_id, start_time, end_time, assigned_cabin_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query)) {
            pst.setInt(1, allocation.getRequestId());
            pst.setInt(2, allocation.getCabinId());
            pst.setInt(3, allocation.getEmployeeId());
            pst.setTime(4, allocation.getStartTime());
            pst.setTime(5, allocation.getEndTime());
            pst.setInt(6, allocation.getAssignedCabinId());
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Allocations> getExpiredAllocations() {
        List<Allocations> expiredAllocations = new ArrayList<>();
        String query = "SELECT a.*, u.username AS employee_name, COALESCE(ac.name, c.name) AS cabin_name " +
                "FROM Allocations a " +
                "JOIN Users u ON a.employee_id = u.id " +
                "JOIN Cabins c ON a.cabin_id = c.id " +
                "LEFT JOIN Cabins ac ON a.assigned_cabin_id = ac.id " +
                "WHERE a.end_time < NOW() AND a.status = 'active'";

        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query);
             ResultSet resultSet = pst.executeQuery()) {

            while (resultSet.next()) {
                Allocations allocation = new Allocations();
                allocation.setId(resultSet.getInt("id"));
                allocation.setRequestId(resultSet.getInt("request_id"));
                allocation.setCabinId(resultSet.getInt("cabin_id"));
                allocation.setEmployeeId(resultSet.getInt("employee_id"));
                allocation.setStartTime(resultSet.getTime("start_time"));
                allocation.setEndTime(resultSet.getTime("end_time"));
                allocation.setCabinName(resultSet.getString("cabin_name"));
                allocation.setEmployeeName(resultSet.getString("employee_name"));
                allocation.setAssignedCabinId(resultSet.getInt("assigned_cabin_id"));
                expiredAllocations.add(allocation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return expiredAllocations;
    }

    @Override
    public void updateAllocationStatus(int allocationId, String status) {
        String query = "UPDATE allocations SET status = ? WHERE id = ?";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query)) {
            pst.setString(1, status);
            pst.setInt(2, allocationId);
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
