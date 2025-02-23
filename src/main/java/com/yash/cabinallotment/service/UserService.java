package com.yash.cabinallotment.service;

import com.yash.cabinallotment.domain.Users;
import com.yash.cabinallotment.exception.UserException;

public interface UserService {
    void registerUser(Users user) throws UserException;
    Users loginUser(Users user) throws UserException;
    Users confirmUser(String username, String password) throws UserException;
    void requestAdminRole(String username) throws UserException;
}
