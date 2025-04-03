package com.yash.cabinallotment.domain;

import java.sql.Time;

public class Cabins {

    private int id;
    private String name;
    private int capacity;
    private String status; // "available", "occupied"
    private Time nextAvailableTime;
    private String cabinImageUrl;

    //Default Constructor
    public Cabins() {};

    //Parameterized Constructor
    public Cabins(int id, String name, int capacity, String status) {
        this.id = id;
        this.name = name;
        this.capacity = capacity;
        this.status = status;
    }

    public Cabins(int id, String name, int capacity) {
        this.id = id;
        this.name = name;
        this.capacity = capacity;
        this.status = "available";
    }

    public Cabins(String name, int capacity, String status) {
        this.name = name;
        this.capacity = capacity;
        this.status = status;
    }

    public Cabins(int id, String name, int capacity, String status, String cabinImageUrl) {
        this.id = id;
        this.name = name;
        this.capacity = capacity;
        this.status = status;
        this.nextAvailableTime = nextAvailableTime;
        this.cabinImageUrl = cabinImageUrl;
    }

    public Cabins(String name, int capacity, String status, String cabinImageUrl) {
        this.name = name;
        this.capacity = capacity;
        this.status = status;
        this.cabinImageUrl = cabinImageUrl;
    }

    //Getter and Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Time getNextAvailableTime() {
        return nextAvailableTime;
    }

    public void setNextAvailableTime(Time nextAvailableTime) {
        this.nextAvailableTime = nextAvailableTime;
    }

    public String getCabinImageUrl() {
        return cabinImageUrl;
    }

    public void setCabinImageUrl(String imageUrl) {
        this.cabinImageUrl = imageUrl;
    }

    @Override
    public String toString() {
        return "Cabins{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", capacity=" + capacity +
                '}';
    }
}
