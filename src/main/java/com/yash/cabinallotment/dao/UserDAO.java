package com.yash.cabinallotment.dao;

import com.yash.cabinallotment.domain.Users;

import java.util.List;

public interface UserDAO {
    void save(Users user);
    boolean validateUser(String username, String password);
    Users findUserByUsername(String username);
    void requestAdminRole(String username, String reason);
    List<Users> getPendingAdminRequests();
    void approveAdminRequest(int userId);
    void rejectAdminRequest(int userId);
}
