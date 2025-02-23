package com.yash.cabinallotment.dao;

import com.yash.cabinallotment.domain.Users;

public interface UserDAO {
    void save(Users user);
    boolean validateUser(String username, String password);
    Users findUserByUsername(String username);
    void requestAdminRole(String username);
}
