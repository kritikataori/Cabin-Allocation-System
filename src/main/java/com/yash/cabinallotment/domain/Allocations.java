package com.yash.cabinallotment.domain;

import java.sql.Time;

public class Allocations {

    private int id;
    private int requestId;
    private int cabinId;
    private int employeeId;
    private Time startTime;
    private Time endTime;

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
                '}';
    }
}

