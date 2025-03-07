package com.yash.cabinallotment.domain;

import java.sql.Time;
import java.sql.Date;

public class Allocations {

    private int id;
    private int requestId;
    private int cabinId;
    private int employeeId;
    private Time startTime;
    private Time endTime;
    private String cabinName;
    private String employeeName;
    private int assignedCabinId;
    private String status;
    private String assignedCabinName;
    private Date requestDate;

    // Constructors
    public Allocations() {
    }

    public Allocations(int id, int requestId, int cabinId, int employeeId, Time startTime, Time endTime) {
        this.id = id;
        this.requestId = requestId;
        this.cabinId = cabinId;
        this.employeeId = employeeId;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRequestId() {
        return requestId;
    }

    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }

    public int getCabinId() {
        return cabinId;
    }

    public void setCabinId(int cabinId) {
        this.cabinId = cabinId;
    }

    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    public Time getEndTime() {
        return endTime;
    }

    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }

    public String getCabinName() {
        return cabinName;
    }

    public void setCabinName(String cabinName) {
        this.cabinName = cabinName;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public int getAssignedCabinId() {
        return assignedCabinId;
    }

    public void setAssignedCabinId(int assignedCabinId) {
        this.assignedCabinId = assignedCabinId;
    }

    public String getAssignedCabinName() {
        return assignedCabinName;
    }

    public void setAssignedCabinName(String assignedCabinName) {
        this.assignedCabinName = assignedCabinName;
    }

    public Date getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(Date requestDate) {
        this.requestDate = requestDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // toString Method
    @Override
    public String toString() {
        return "Allocations{" +
                "id=" + id +
                ", requestId=" + requestId +
                ", cabinId=" + cabinId +
                ", employeeId=" + employeeId +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", cabinName='" + cabinName + '\'' +
                ", employeeName='" + employeeName + '\'' +
                '}';
    }
}

