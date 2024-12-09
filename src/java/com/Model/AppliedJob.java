package com.Model;

import java.io.InputStream;
import java.sql.Timestamp;

public class AppliedJob {
    private int applicationID;
    private int bookingID;
    private int babyID;
    private Timestamp applicationDate;
    private String applyStatus;
    private String bookingStatus;

    public AppliedJob() {
    }

    public AppliedJob(int applicationID, int bookingID, int babyID, Timestamp applicationDate, String applyStatus, String bookingStatus) {
        this.applicationID = applicationID;
        this.bookingID = bookingID;
        this.babyID = babyID;
        this.applicationDate = applicationDate;
        this.applyStatus = applyStatus;
        this.bookingStatus = bookingStatus;
    }
    
     public AppliedJob(int bookingID, int babyID, String applyStatus) {
        this.bookingID = bookingID;
        this.babyID = babyID;
    }

    public String getJobStatus() {
        return bookingStatus;
    }

    public void setJobStatus(String bookingStatus) {
        this.bookingStatus = bookingStatus;
    }

    public int getApplicationID() {
        return applicationID;
    }

    public void setApplicationID(int applicationID) {
        this.applicationID = applicationID;
    }

    public int getJobID() {
        return bookingID;
    }

    public void setJobID(int bookingID) {
        this.bookingID = bookingID;
    }

    public int getJobseekID() {
        return babyID;
    }

    public void setApplyStatus(String applyStatus) {
        this.applyStatus = applyStatus;
    }

    public String getApplyStatus() {
        return applyStatus;
    }

    public void setJobseekID(int babyID) {
        this.babyID = babyID;
    }

    public Timestamp getApplicationDate() {
        return applicationDate;
    }

    public void setApplicationDate(Timestamp applicationDate) {
        this.applicationDate = applicationDate;
    }

    @Override
    public String toString() {
        return "AppliedJob{" +
                "applicationID=" + applicationID +
                ", bookingID=" + bookingID +
                ", babyID=" + babyID +
                ", applicationDate=" + applicationDate + 
                ", applyStatus=" + applyStatus +
                '}';
    }
}
