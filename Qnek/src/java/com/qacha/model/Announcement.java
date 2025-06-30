/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.qacha.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Announcement {
private int announcementId;
private String title;
private String content;
private int createdBy;
private Timestamp createdAt;
private Date expiryDate;
private String priority;
private String targetType;
private Integer targetValue; // nullable


public int getAnnouncementId() { return announcementId; }
public void setAnnouncementId(int announcementId) { this.announcementId = announcementId; }

public String getTitle() { return title; }
public void setTitle(String title) { this.title = title; }

public String getContent() { return content; }
public void setContent(String content) { this.content = content; }

public int getCreatedBy() { return createdBy; }
public void setCreatedBy(int createdBy) { this.createdBy = createdBy; }

public Timestamp getCreatedAt() { return createdAt; }
public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

public Date getExpiryDate() { return expiryDate; }
public void setExpiryDate(Date expiryDate) { this.expiryDate = expiryDate; }

public String getPriority() { return priority; }
public void setPriority(String priority) { this.priority = priority; }

public String getTargetType() { return targetType; }
public void setTargetType(String targetType) { this.targetType = targetType; }

public Integer getTargetValue() { return targetValue; }
public void setTargetValue(Integer targetValue) { this.targetValue = targetValue; }
}