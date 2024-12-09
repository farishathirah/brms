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
public class Parent {
    private int parentID;
    private String parentName;
    private String parentUser;
    private String parentPass;
    private String parentPhone;
    private String parentEmail;
    private InputStream parentPP;

    public Parent(int parentID, String parentName, String parentUser, String parentPass, String parentPhone, String parentEmail, InputStream parentPP) {
        this.parentID = parentID;
        this.parentName = parentName;
        this.parentUser = parentUser;
        this.parentPass = parentPass;
        this.parentPhone = parentPhone;
        this.parentEmail = parentEmail;
        this.parentPP = parentPP;
    }

    public Parent(String parentName, String parentUser, String parentPass, String parentPhone, String parentEmail, InputStream parentPP) {
        this.parentName = parentName;
        this.parentUser = parentUser;
        this.parentPass = parentPass;
        this.parentPhone = parentPhone;
        this.parentEmail = parentEmail;
        this.parentPP = parentPP;
    }

    public int getParentID() {
        return parentID;
    }

    public void setParentID(int parentID) {
        this.parentID = parentID;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public String getParentUser() {
        return parentUser;
    }

    public void setParentUser(String parentUser) {
        this.parentUser = parentUser;
    }

    public String getParentPass() {
        return parentPass;
    }

    public void setParentPass(String parentPass) {
        this.parentPass = parentPass;
    }

    public String getParentPhone() {
        return parentPhone;
    }

    public void setParentPhone(String parentPhone) {
        this.parentPhone = parentPhone;
    }

    public String getParentEmail() {
        return parentEmail;
    }

    public void setParentEmail(String parentEmail) {
        this.parentEmail = parentEmail;
    }

    public InputStream getParentPP() {
        return parentPP;
    }

    public void setParentPP(InputStream parentPP) {
        this.parentPP = parentPP;
    }
    
    
}
