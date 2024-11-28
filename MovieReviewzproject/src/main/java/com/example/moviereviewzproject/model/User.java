package com.example.moviereviewzproject.model;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;

import java.util.Date;

@Entity
@Table(name = "User")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private long user_id;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "watchlist_id")
    private long watchlist_id;

    @Column(name="date_joined")
    @JsonFormat(shape= JsonFormat.Shape.STRING, pattern="dd-MM-yyyy", timezone = "UTC")
    @Temporal(TemporalType.DATE)
    private Date date_joined;

    public long getUserID(){
        return this.user_id;
    }
    public String getUserEmail(){
        return this.email;
    }
    public long getUserWatchlistId(){
        return this.watchlist_id;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public void setEmail(String email){
        this.email = email;
    }
}
