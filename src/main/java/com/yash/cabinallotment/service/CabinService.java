package com.yash.cabinallotment.service;

import com.yash.cabinallotment.domain.Cabins;
import com.yash.cabinallotment.exception.CabinException;
import com.yash.cabinallotment.exception.CabinRequestException;

import java.sql.Time;
import java.util.List;

public interface CabinService {
    List<Cabins> getAllCabins() throws CabinException;
    List<Cabins> getAvailableCabins() throws CabinException;
    void createCabin(Cabins cabin) throws CabinException;
    void updateCabin(Cabins cabin) throws CabinException;
    void deleteCabin(int cabinId) throws CabinException;
    Cabins getCabinById(int cabinId) throws CabinRequestException;
    void updateCabinStatus(int cabinId, String status) throws CabinException;
    List<Cabins> getAvailableFilteredCabins(java.sql.Date reqDate, Time startTime, Time endTime);
}
