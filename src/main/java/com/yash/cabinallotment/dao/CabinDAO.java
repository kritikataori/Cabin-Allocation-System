package com.yash.cabinallotment.dao;

import com.yash.cabinallotment.domain.Cabins;

import java.util.List;

public interface CabinDAO {
    List<Cabins> getAllCabins();
    void createCabin(Cabins cabin);
    void updateCabin(Cabins cabin);
    void deleteCabin(int cabinId);
    String getCabinNameById(int cabinId);
    Cabins getCabinById(int cabinId);
}
