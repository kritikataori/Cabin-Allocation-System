package com.yash.cabinallotment.daoimpl;

import com.yash.cabinallotment.dao.CabinRequestDAO;
import com.yash.cabinallotment.domain.Requests;
import com.yash.cabinallotment.exception.CabinRequestException;
import com.yash.cabinallotment.util.JDBCUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CabinRequestDAOImpl extends JDBCUtil implements CabinRequestDAO {
    @Override
    public List<Requests> getPendingRequests() throws CabinRequestException {
        List<Requests> pendingRequests = new ArrayList<>();
        //String query = "SELECT r.*, u.username FROM Requests r INNER JOIN Users u ON r.emp_id = u.id WHERE r.status = 'pending';";

        String query = "SELECT r.*, u.username, c.name AS cabin_name " +
                "FROM Requests r " +
                "INNER JOIN Users u ON r.emp_id = u.id " +
                "INNER JOIN Cabins c ON r.cabin_id = c.id " + // Join to get cabin name
                "WHERE r.status = 'pending';";

        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query);
             ResultSet resultSet = pst.executeQuery()) {

            while(resultSet.next()) {
                Requests request = new Requests();
                request.setId(resultSet.getInt("id"));
                request.setEmpId(resultSet.getInt("emp_id"));
                request.setCabinId(resultSet.getInt("cabin_id"));
                request.setReqDate(resultSet.getDate("req_date"));
                request.setStartTime(resultSet.getTime("start_time"));
                request.setEndTime(resultSet.getTime("end_time"));
                request.setStatus(resultSet.getString("status"));
                request.setUsername(resultSet.getString("username"));
                request.setCabinName(resultSet.getString("cabin_name"));
                pendingRequests.add(request);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pendingRequests;
    }

    @Override
    public void createRequest(Requests request) {
        String query = "INSERT INTO Requests (emp_id, cabin_id, req_date, start_time, end_time, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query)) {

            pst.setInt(1, request.getEmpId());
            pst.setInt(2, request.getCabinId());
            pst.setDate(3, request.getReqDate());
            pst.setTime(4, request.getStartTime());
            pst.setTime(5, request.getEndTime());
            pst.setString(6, request.getStatus());
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("ERROR");
        }
    }

    @Override
    public void approveRequest(int reqId) {
        String query = "UPDATE requests SET status = 'approved' WHERE id = ?";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query);) {
            pst.setInt(1, reqId);
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();;
            throw new CabinRequestException("Failed to approve request");
        }
    }

    @Override
    public void rejectRequest(int reqId) {
        String query = "UPDATE requests SET status = 'rejected' WHERE id = ?";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query);) {
            pst.setInt(1, reqId);
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new CabinRequestException("Failed to reject request");
        }
    }

    @Override
    public int getPendingRequestCount() {
        String query = "SELECT COUNT(*) FROM requests WHERE status='pending';";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query);
             ResultSet resultSet = pst.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error getting pending request count", e);
        }
        return 0;
    }

    @Override
    public List<Requests> getRequestsByUserId(int userId) {
        List<Requests> userRequests = new ArrayList<>();
        String query = "SELECT r.*, u.username, c.name AS cabin_name, ac.name AS assigned_cabin_name " +
                "FROM Requests r " +
                "INNER JOIN Users u ON r.emp_id = u.id " +
                "INNER JOIN Cabins c ON r.cabin_id = c.id " +
                "LEFT JOIN Cabins ac ON r.assigned_cabin_id = ac.id " + // Join for assigned cabin
                "WHERE r.emp_id = ?;";

        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query)) {
            pst.setInt(1, userId);

            try (ResultSet resultSet = pst.executeQuery()) {
                while (resultSet.next()) {
                    Requests request = new Requests();
                    request.setId(resultSet.getInt("id"));
                    request.setEmpId(resultSet.getInt("emp_id"));
                    request.setCabinId(resultSet.getInt("cabin_id"));
                    request.setAssignedCabinId(resultSet.getInt("assigned_cabin_id")); //Get assigned cabin ID
                    request.setReqDate(resultSet.getDate("req_date"));
                    request.setStartTime(resultSet.getTime("start_time"));
                    request.setEndTime(resultSet.getTime("end_time"));
                    request.setStatus(resultSet.getString("status"));
                    request.setUsername(resultSet.getString("username"));
                    request.setCabinName(resultSet.getString("cabin_name"));
                    request.setAssignedCabinName(resultSet.getString("assigned_cabin_name"));

                    userRequests.add(request);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error getting requests by user ID", e);
        }
        return userRequests;
    }

    @Override
    public void assignOtherCabin(int reqId, int cabinId) throws CabinRequestException {
        String query = "UPDATE requests SET assigned_cabin_id = ?, status = 'approved' WHERE id = ?";
        try (Connection conn = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query)) {
            pst.setInt(1, cabinId);
            pst.setInt(2, reqId);
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Requests getRequestById(int requestId) throws CabinRequestException {
        String query = "SELECT * FROM requests WHERE id = ?";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query);) {
            pst.setInt(1, requestId);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                Requests request = new Requests();
                request.setId(rs.getInt("id"));
                request.setEmpId(rs.getInt("emp_id"));
                request.setCabinId(rs.getInt("cabin_id"));
                request.setReqDate(rs.getDate("req_date"));
                request.setStartTime(rs.getTime("start_time"));
                request.setEndTime(rs.getTime("end_time"));
                request.setStatus(rs.getString("status"));
                return request;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void updateAssignedCabinId(int requestId, int assignedCabinId) {
        String query = "UPDATE requests SET assigned_cabin_id = ? WHERE id = ?";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query)) {
            pst.setInt(1, assignedCabinId);
            pst.setInt(2, requestId);
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Requests> getRequestsForActivation() {
        List<Requests> requests = new ArrayList<>();
        String query = "SELECT * FROM requests WHERE status = 'approved' AND allocation_status = 'pending' AND req_date <= CURDATE() AND start_time <= CURTIME()";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query);
             ResultSet resultSet = pst.executeQuery()) {
            while (resultSet.next()) {
                Requests request = new Requests();
                request.setId(resultSet.getInt("id"));
                request.setEmpId(resultSet.getInt("emp_id"));
                request.setCabinId(resultSet.getInt("cabin_id"));
                request.setAssignedCabinId(resultSet.getInt("assigned_cabin_id"));
                request.setReqDate(resultSet.getDate("req_date"));
                request.setStartTime(resultSet.getTime("start_time"));
                request.setEndTime(resultSet.getTime("end_time"));
                request.setStatus(resultSet.getString("status"));
                requests.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }

    public List<Requests> getExpiredRequests() {
        List<Requests> requests = new ArrayList<>();
        String query = "SELECT * FROM requests WHERE allocation_status = 'active' AND req_date <= CURDATE() AND end_time < CURTIME()";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query);
             ResultSet resultSet = pst.executeQuery()) {
            while (resultSet.next()) {
                Requests request = new Requests();
                request.setId(resultSet.getInt("id"));
                request.setEmpId(resultSet.getInt("emp_id"));
                request.setCabinId(resultSet.getInt("cabin_id"));
                request.setAssignedCabinId(resultSet.getInt("assigned_cabin_id"));
                request.setReqDate(resultSet.getDate("req_date"));
                request.setStartTime(resultSet.getTime("start_time"));
                request.setEndTime(resultSet.getTime("end_time"));
                request.setStatus(resultSet.getString("status"));
                requests.add(request);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }

    public void updateAllocationStatus(int requestId, String status) {
        String query = "UPDATE requests SET allocation_status = ? WHERE id = ?";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query)) {
            pst.setString(1, status);
            pst.setInt(2, requestId);
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean isCabinAssignedToOtherRequest(int cabinId, int currentRequestId) {
        String query = "SELECT COUNT(*) FROM requests WHERE (cabin_id = ? OR assigned_cabin_id = ?) AND allocation_status = 'active' AND id != ?";
        try (Connection con = JDBCUtil.dbConnection();
             PreparedStatement pst = JDBCUtil.getPreparedStatement(query)) {
            pst.setInt(1, cabinId);
            pst.setInt(2, cabinId);
            pst.setInt(3, currentRequestId);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
