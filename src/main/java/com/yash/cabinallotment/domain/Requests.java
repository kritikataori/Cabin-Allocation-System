package com.yash.cabinallotment.domain;

import java.sql.Date;
import java.sql.Time;

public class Requests {
    private int id;
    private int empId;
    private Integer cabinId; // Can be null, so use Integer instead of int
    private Date reqDate;
    private Time startTime;
    private Time endTime;
    private String status; // "pending", "approved", "rejected"
    private String cabinName;

    // Default constructor
    public Requests() {
    }

    // Parameterized constructor without ID
    public Requests(int empId, Integer cabinId, Date reqDate, Time startTime, Time endTime, String status) {
        this.empId = empId;
        this.cabinId = cabinId;
        this.reqDate = reqDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
    }

    // Parameterized constructor with ID
    public Requests(int id, int empId, Integer cabinId, Date reqDate, Time startTime, Time endTime, String status) {
        this.id = id;
        this.empId = empId;
        this.cabinId = cabinId;
        this.reqDate = reqDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.status = status;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public Integer getCabinId() {
        return cabinId;
    }

    public void setCabinId(Integer cabinId) {
        this.cabinId = cabinId;
    }

    public Date getReqDate() {
        return reqDate;
    }

    public void setReqDate(Date reqDate) {
        this.reqDate = reqDate;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCabinName() {
        return cabinName;
    }

    public void setCabinName(String cabinName) {
        this.cabinName = cabinName;
    }

    // Override toString() for easy debugging
    @Override
    public String toString() {
        return "Requests{" +
                "id=" + id +
                ", empId=" + empId +
                ", cabinId=" + cabinId +
                ", reqDate=" + reqDate +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                ", status='" + status + '\'' +
                '}';
    }
}


