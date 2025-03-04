package com.yash.cabinallotment.exception;

public class CabinException extends RuntimeException {
    public CabinException(String message) { super(message); }

    public CabinException(String message, Throwable e) { super(message, e); }
}
