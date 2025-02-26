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
        String query = "SELECT a.id, a.request_id, c.name as cabin_name, u.username as employee_name, a.start_time, a.end_time " +
                "FROM allocations a " +
                "JOIN cabins c ON a.cabin_id = c.id " +
                "JOIN users u ON a.employee_id = u.id;";

        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                Allocations allocation = new Allocations();
                allocation.setId(rs.getInt("id"));
                allocation.setRequestId(rs.getInt("request_id"));
                allocation.setCabinName(rs.getString("cabin_name"));
                allocation.setEmployeeName(rs.getString("employee_name"));
                allocation.setStartTime(rs.getTime("start_time"));
                allocation.setEndTime(rs.getTime("end_time"));
                allocations.add(allocation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return allocations;
    }

    @Override
    public void addAllocation(Allocations allocation) {
        String query = "INSERT INTO allocations (request_id, cabin_id, employee_id, start_time, end_time) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query)) {
            pst.setInt(1, allocation.getRequestId());
            pst.setInt(2, allocation.getCabinId());
            pst.setInt(3, allocation.getEmployeeId());
            pst.setTime(4, allocation.getStartTime());
            pst.setTime(5, allocation.getEndTime());
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
