package com.yash.cabinallotment.domain;

public class Users {

    private int id;
    private String username;
    private String password;
    private String email;
    private String role;
    private boolean adminApproval;

    //Default Constructor
    public Users() {};

    //Parameterized Constructor
    public Users(int id, String name, String password, String email, String role) {
        this.id = id;
        this.username = name;
        this.password = password;
        this.email = email;
        this.role = role;
    }

    public Users(String name, String password, String email, String role) {
        this.username = name;
        this.password = password;
        this.email = email;
        this.role = role;
    }

    //Getter and Setter
    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setUsername(String name) {
        this.username = name;
    }

    public String getUsername() {
        return username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPassword() {
        return password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmail() {
        return email;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getRole() {
        return role;
    }

    public void setAdminApproval(boolean adminApproval) {
        this.adminApproval = adminApproval;
    }

    public boolean isAdminApproval() {
        return adminApproval;
    }

    @Override
    public String toString() {
        return "Users{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", role='" + role + '\'' +
                ", isAdminApproved='" + adminApproval + '\'' +
                '}';
    }
}
