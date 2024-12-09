package com.Model;
import java.math.BigDecimal;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author faris
 */
public class Booking {
    private int bookingID;
    private int parentID;
    private String bookingDesc;
    private String bookingAddress;
    private String bookingCity;
    private String bookingState;
    private String bookingZip;
    private BigDecimal bookingReward;
    private String dateCreated;
    private String date;
    private String startTime;
    private String endTime;

    public Booking(int bookingID, int parentID, String bookingDesc, String bookingAddress, String bookingCity, String bookingState, String bookingZip, BigDecimal bookingReward, String dateCreated, String date, String startTime, String endTime) {
        this.bookingID = bookingID;
        this.parentID = parentID;
        this.bookingDesc = bookingDesc;
        this.bookingAddress = bookingAddress;
        this.bookingCity = bookingCity;
        this.bookingState = bookingState;
        this.bookingZip = bookingZip;
        this.bookingReward = bookingReward;
        this.dateCreated = dateCreated;
        this.date = date;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public Booking(int parentID, String bookingDesc, String bookingAddress, String bookingCity, String bookingState, String bookingZip, BigDecimal bookingReward, String dateCreated, String date, String startTime, String endTime) {
        this.parentID = parentID;
        this.bookingDesc = bookingDesc;
        this.bookingAddress = bookingAddress;
        this.bookingCity = bookingCity;
        this.bookingState = bookingState;
        this.bookingZip = bookingZip;
        this.bookingReward = bookingReward;
        this.dateCreated = dateCreated;
        this.date = date;
        this.startTime = startTime;
        this.endTime = endTime;
    }
    
    public Booking() {
    }

    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public int getParentID() {
        return parentID;
    }

    public void setParentID(int parentID) {
        this.parentID = parentID;
    }

    public String getBookingDesc() {
        return bookingDesc;
    }

    public void setBookingDesc(String bookingDesc) {
        this.bookingDesc = bookingDesc;
    }

    public String getBookingAddress() {
        return bookingAddress;
    }

    public void setBookingAddress(String bookingAddress) {
        this.bookingAddress = bookingAddress;
    }

    public String getBookingCity() {
        return bookingCity;
    }

    public void setBookingCity(String bookingCity) {
        this.bookingCity = bookingCity;
    }

    public String getBookingState() {
        return bookingState;
    }

    public void setBookingState(String bookingState) {
        this.bookingState = bookingState;
    }

    public String getBookingZip() {
        return bookingZip;
    }

    public void setBookingZip(String bookingZip) {
        this.bookingZip = bookingZip;
    }

    public BigDecimal getBookingReward() {
        return bookingReward;
    }

    public void setBookingReward(BigDecimal bookingReward) {
        this.bookingReward = bookingReward;
    }

    public String getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(String dateCreated) {
        this.dateCreated = dateCreated;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }
    
    
}
