package com.yash.cabinallotment.service;

import com.yash.cabinallotment.domain.Users;
import com.yash.cabinallotment.exception.UserException;

import java.util.List;

public interface UserService {
    void registerUser(Users user) throws UserException;
    Users loginUser(Users user) throws UserException;
    Users confirmUser(String username, String password) throws UserException;
    void requestAdminRole(String username, String reason) throws UserException;
    List<Users> getPendingAdminRequests() throws UserException;
    void approveAdminRequest(int userId) throws UserException;
    void rejectAdminRequest(int userId) throws UserException;
}
