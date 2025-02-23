package com.yash.cabinallotment.serviceimpl;

import com.yash.cabinallotment.dao.UserDAO;
import com.yash.cabinallotment.daoimpl.UserDAOImpl;
import com.yash.cabinallotment.domain.Users;
import com.yash.cabinallotment.exception.UserException;
import com.yash.cabinallotment.service.UserService;

public class UserServiceImpl implements UserService {
    private UserDAO userDAO;

    public UserServiceImpl() {
        userDAO = new UserDAOImpl();
    }

    @Override
    public void registerUser(Users user) throws UserException {
        if (user == null || user.getUsername() == null || user.getUsername().isEmpty()) {
            throw new UserException("Username is required");
        }
        if (user.getEmail() == null || user.getEmail().isEmpty()) {
            throw new UserException("Email is required");
        }
        if (user.getPassword() == null || user.getPassword().isEmpty()) {
            throw new UserException("Password is required");
        }
        userDAO.save(user);
    }

    @Override
    public Users loginUser(Users user) throws UserException {
        if (user == null || user.getUsername() == null || user.getPassword() == null) {
            throw new UserException("Username and password are required");
        }
        if (userDAO.validateUser(user.getUsername(), user.getPassword())) {
            return userDAO.findUserByUsername(user.getUsername());
        } else {
            return null;
        }
    }

    @Override
    public Users confirmUser(String username, String password) throws UserException {
        Users user = userDAO.findUserByUsername(username);
        if (user == null) {
            System.out.println("DEBUG: User not found.");
            return null; // User does not exist
        }
        if (user.getPassword().equals(password)) {
            System.out.println("DEBUG: User authenticated: " + user);
            return user; // User authenticated successfully
        } else {
            System.out.println("DEBUG: Password mismatch for user: " + username);
            return null; // Password does not match
        }
    }

    @Override
    public void requestAdminRole(String username) throws UserException {
        Users user = userDAO.findUserByUsername(username);
        if (user == null) {
            throw new UserException("User not found.");
        }
        userDAO.requestAdminRole(username);
    }


}
