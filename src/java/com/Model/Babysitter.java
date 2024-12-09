/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.Model;

import java.io.InputStream;

/**
 *
 * @author faris
 */
public class Babysitter {
    private int babyID;
    private String babyName;
    private String babyUser;
    private String babyPass;
    private String babyPhone;
    private String babyEmail;
    private InputStream babyPP;

    public Babysitter(int babyID, String babyName, String babyUser, String babyPass, String babyPhone, String babyEmail, InputStream babyPP) {
        this.babyID = babyID;
        this.babyName = babyName;
        this.babyUser = babyUser;
        this.babyPass = babyPass;
        this.babyPhone = babyPhone;
        this.babyEmail = babyEmail;
        this.babyPP = babyPP;
    }

    public Babysitter(String babyName, String babyUser, String babyPass, String babyPhone, String babyEmail, InputStream babyPP) {
        this.babyName = babyName;
        this.babyUser = babyUser;
        this.babyPass = babyPass;
        this.babyPhone = babyPhone;
        this.babyEmail = babyEmail;
        this.babyPP = babyPP;
    }

    public int getBabyID() {
        return babyID;
    }

    public void setBabyID(int babyID) {
        this.babyID = babyID;
    }

    public String getBabyName() {
        return babyName;
    }

    public void setBabyName(String babyName) {
        this.babyName = babyName;
    }

    public String getBabyUser() {
        return babyUser;
    }

    public void setBabyUser(String babyUser) {
        this.babyUser = babyUser;
    }

    public String getBabyPass() {
        return babyPass;
    }

    public void setBabyPass(String babyPass) {
        this.babyPass = babyPass;
    }

    public String getBabyPhone() {
        return babyPhone;
    }

    public void setBabyPhone(String babyPhone) {
        this.babyPhone = babyPhone;
    }

    public String getBabyEmail() {
        return babyEmail;
    }

    public void setBabyEmail(String babyEmail) {
        this.babyEmail = babyEmail;
    }

    public InputStream getBabyPP() {
        return babyPP;
    }

    public void setBabyPP(InputStream babyPP) {
        this.babyPP = babyPP;
    }
    
    
}
