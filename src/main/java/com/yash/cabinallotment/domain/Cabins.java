package com.yash.cabinallotment.domain;

public class Cabins {

    private int id;
    private String name;
    private int capacity;
    private String status; // "available", "occupied"

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

    @Override
    public String toString() {
        return "Cabins{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", capacity=" + capacity +
                '}';
    }
}
