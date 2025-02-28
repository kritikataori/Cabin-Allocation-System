package com.yash.cabinallotment.service;

import com.yash.cabinallotment.domain.Cabins;
import com.yash.cabinallotment.exception.CabinException;
import com.yash.cabinallotment.exception.CabinRequestException;

import java.util.List;

public interface CabinService {
    List<Cabins> getAllCabins() throws CabinException;
    void createCabin(Cabins cabin) throws CabinException;
    void updateCabin(Cabins cabin) throws CabinException;
    void deleteCabin(int cabinId) throws CabinException;
    Cabins getCabinById(int cabinId) throws CabinRequestException;
}
