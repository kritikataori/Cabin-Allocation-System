package com.yash.cabinallotment.dao;

import com.yash.cabinallotment.domain.Cabins;

import java.sql.Time;
import java.util.List;

public interface CabinDAO {
    List<Cabins> getAllCabins();
    List<Cabins> getAvailableCabins();
    void createCabin(Cabins cabin);
    void updateCabin(Cabins cabin);
    void deleteCabin(int cabinId);
    String getCabinNameById(int cabinId);
    Cabins getCabinById(int cabinId);
    void updateCabinStatus(int cabinId, String status);
    List<Cabins> getAvailableFilteredCabins(java.sql.Date reqDate, Time startTime, Time endTime);
}
